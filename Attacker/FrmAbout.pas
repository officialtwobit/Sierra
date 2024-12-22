unit FrmAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton,
  System.ImageList, Vcl.ImgList, acAlphaImageList, Vcl.StdCtrls, sMemo, sLabel,
  ShellAPI;

type
  TForm2 = class(TForm)
    sLabelFX1: TsLabelFX;
    sMemo1: TsMemo;
    sCharImageList1: TsCharImageList;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.sSpeedButton1Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', 'https://github.com/officialtwobit', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TForm2.sSpeedButton2Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', 'https://youtube.com/@officialtwobit', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TForm2.sSpeedButton3Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', 'https://t.me/officialtwobit', nil, nil,
    SW_SHOWNORMAL);
end;

end.
