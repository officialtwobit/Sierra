program SierraLoader;









{$R *.dres}

uses
  Vcl.Forms,
  FrmMain in 'FrmMain.pas' {Form1},
  FrmAbout in 'FrmAbout.pas' {Form2},
  FrmExecute in 'FrmExecute.pas' {Form4},
  FrmScripting in 'FrmScripting.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
