unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls,
  SHDocVw, Vcl.StdCtrls, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.ImageList, Vcl.ImgList, System.JSON, ActiveX,
  Vcl.AppEvnts, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ExtCtrls, System.UITypes;

const
  AppKey = 'f1039cf84261ac615fa8221e7938a42d';  // ������������� ����������
  DisplayApp = 'page';  // ������� ��� ����� ��������� ����������. ���������� ��������:
                        //   "page" � ��������
                        //   "popup" � ����������� ����
  Expires_at = 604800;  // ���� �������� access_token � ������� UNIX. ����� ����� ������� ������ � ��������.
                        // ���� �������� � ������ �� ������ ��������� ��� ������, ������� � ���������� �������.
  Nofollow = 1;         // ��� �������� ��������� nofollow=1 ������������� �� ����������. URL ������������ � ������.
                        // �� ���������: 0. ����������� ��������: 0. ������������ ��������: 1.
  RedirectURL = 'https://developers.wargaming.net/reference/all/wot/auth/login/';   // URL �� ������� ����� ���������� ������������
                                                                                    // ����� ���� ��� �� ������� ��������������.
                                                                                    // �� ���������: api.worldoftanks.ru/wot//blank/
  AuthURL = 'https://api.worldoftanks.ru/wot/auth/login/?application_id=%s&display=%s&expires_at=%s&nofollow=%d';  // URL ��� �������

  // ���� ������
  AUTH_CANCEL = 401;   // ������������ ������� ����������� ��� ����������
  AUTH_EXPIRED = 403;  // ��������� ����� �������� ����������� ������������
  AUTH_ERROR = 410;    // ������ ��������������

type
  TMainForm = class(TForm)
    NetClient: TNetHTTPClient;
    NetRequest: TNetHTTPRequest;
    Menu: TMainMenu;
    FileMenu: TMenuItem;
    AuthMenu: TMenuItem;
    AL: TActionList;
    AppEvents: TApplicationEvents;
    IL: TImageList;
    AuthAction: TAction;
    SB: TStatusBar;
    SearchAction: TAction;
    SearchMenu: TMenuItem;
    PersonAction: TAction;
    N1: TMenuItem;
    TopInfoPanel: TPanel;
    RigthInfoPanel: TPanel;
    MiddleLine: TBevel;
    lblNickName: TLabel;
    LeftInfoSB: TStatusBar;
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    procedure AuthActionExecute(Sender: TObject);
    procedure SearchActionExecute(Sender: TObject);
    procedure PersonActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure LeftInfoSBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure TopInfoPanelClick(Sender: TObject);
  private
    { Private declarations }

    procedure SetInfoSB();
    procedure SetLeftInfoSB(silver, premiumDays, gold, bons, freeExpirience: string);
  public

  published

  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses BrowserEmulationAdjuster, Auth, Globals, SConsts, Search, Personal;

{ TMainForm }

procedure TMainForm.AuthActionExecute(Sender: TObject);
var
  AuthF: TAuthForm;
begin
  AuthF := TAuthForm.Create(Self);

  try
    AuthF.SetpathJSONfile(ExtractFilePath(GetModuleName(0)) + 'ParamsFiles\authentication.json');
    AuthF.LoadParamsActionExecute(nil);
    AuthF.ShowModal();
  finally
    FreeAndNil(AuthF);
  end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  sl: TStringList;
begin
  try
    sl := TStringList.Create;
    sl.LoadFromFile(ExtractFilePath(GetModuleName(0)) + 'ParamsFiles\authentication.json');
    GetPropertiesAuth(sl.Text, Length(sl.Text));
    SetInfoSB();
    SetLeftInfoSB(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr);
  finally
    FreeAndNil(sl);
  end;
end;

procedure TMainForm.LeftInfoSBDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  with LeftInfoSB.Canvas do
    try
      Font.Style := Font.Style + [TFontStyle.fsBold];
      Font.Name := 'Times New Roman';
      Panel.Alignment := taCenter;

      if Panel = LeftInfoSB.Panels[0] then
        Begin
           Font.Color := clSilver;
           IL.Draw(LeftInfoSB.Canvas, Rect.Left, Rect.Top, 50);
        End;
      if Panel = LeftInfoSB.Panels[1] then
        Begin
           Font.Color := clSilver;
           IL.Draw(LeftInfoSB.Canvas, Rect.Left, Rect.Top, 50);
        End;
      if Panel = LeftInfoSB.Panels[2] then
        Begin
           Font.Color := clSilver;
           IL.Draw(LeftInfoSB.Canvas, Rect.Left, Rect.Top, 50);
        End;
      if Panel = LeftInfoSB.Panels[3] then
        Begin
           Font.Color := clSilver;
           IL.Draw(LeftInfoSB.Canvas, Rect.Left, Rect.Top, 50);
        End;
      if Panel = LeftInfoSB.Panels[4] then
        Begin
           Font.Color := $0046C8F9;
           IL.Draw(LeftInfoSB.Canvas, Rect.Left, Rect.Top, 49);
        End;

    finally
       TextOut(Rect.Left + 17, Rect.Top, Panel.Text);
    end;
end;

procedure TMainForm.PersonActionExecute(Sender: TObject);
var
  personF: TPersonalForm;
begin
  personF := TPersonalForm.Create(Self);

  try
    personF.ShowModal;
  finally
    FreeAndNil(personF);
  end;
end;

procedure TMainForm.SBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  with SB.Canvas do
    try
      Font.Style := Font.Style + [fsBold];
      Font.Name := 'Times New Roman';
      if Panel = SB.Panels[0] then
        Begin
          Font.Color := clGreen;
          IL.Draw(SB.Canvas, Rect.Left, Rect.Top, 47);
        End;
      if Panel = SB.Panels[1] then
        Begin
          Font.Color := clGreen;
          IL.Draw(SB.Canvas, Rect.Left, Rect.Top, 1);
        End;
      if Panel = SB.Panels[2] then
        Begin
          Font.Color := clRed;
          IL.Draw(SB.Canvas, Rect.Left, Rect.Top, 3);
        End;
      if Panel = StatusBar.Panels[3] then
        Begin
          Font.Color := clBlue;
          Font.Name := 'Segoe UI';
          IL.Draw(SB.Canvas, Rect.Left, Rect.Top, 48);
        end;
    finally
      TextOut(Rect.Left + 17, Rect.Top, Panel.Text);
    end;
end;

procedure TMainForm.SearchActionExecute(Sender: TObject);
var
  searchF: TSearchForm;
begin
  searchF := TSearchForm.Create(Self);

  try
    searchF.ShowModal();
  finally
    FreeAndNil(searchF);
  end;
end;

procedure TMainForm.SetInfoSB;
begin
  SB.Panels[0].Text := Format(s_AccessKey, [g_AuthParams.access_token]);
  SB.Panels[1].Text := Format(s_IdAccount, [g_AuthParams.account_id]);
  SB.Panels[2].Text := Format(s_AccessExpires, [g_AuthParams.expires_at]);
  SB.Panels[3].Text := Format(s_Status, [g_AuthParams.Status]);
end;

procedure TMainForm.SetLeftInfoSB(silver, premiumDays, gold, bons,
  freeExpirience: string);
begin
  LeftInfoSB.Panels[0].Text := Format('%d �', [42]);    // ������� ����
  LeftInfoSB.Panels[1].Text := Format('%d', [1088]);    // ������
  LeftInfoSB.Panels[2].Text := Format('%d', [1316820]); // �������
  LeftInfoSB.Panels[3].Text := Format('%d', [2345]);    // ����
  LeftInfoSB.Panels[4].Text := Format('%d', [0]);       // ��������� �����
end;

procedure TMainForm.TopInfoPanelClick(Sender: TObject);
VAR
  s,h: string;
  i: integer;
begin
  if ColorDialog1.Execute then
    Begin
        h:=IntToHex(ColorToRGB(ColorDialog1.Color),8);
        Edit1.Text := '$' + h;
    End;
end;

end.
