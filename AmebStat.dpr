program AmebStat;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  BrowserEmulationAdjuster in 'BrowserEmulationAdjuster.pas',
  Auth in 'Auth.pas' {AuthForm},
  SConsts in 'SConsts.pas',
  Globals in 'Globals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
