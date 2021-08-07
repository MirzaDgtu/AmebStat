program AmebStat;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  BrowserEmulationAdjuster in 'BrowserEmulationAdjuster.pas',
  Auth in 'Auth.pas' {AuthForm},
  SConsts in 'SConsts.pas',
  Globals in 'Globals.pas',
  Search in 'Search.pas' {SearchForm},
  Personal in 'Personal.pas' {PersonalForm},
  Garage in 'Garage.pas' {GarageFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSearchForm, SearchForm);
  Application.CreateForm(TPersonalForm, PersonalForm);
  Application.Run;
end.
