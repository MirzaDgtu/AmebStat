unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls,
  SHDocVw, Vcl.StdCtrls, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.ImageList, Vcl.ImgList, System.JSON, ActiveX,
  Vcl.AppEvnts, System.Actions, Vcl.ActnList, Vcl.Menus;

const
  AppKey = 'f1039cf84261ac615fa8221e7938a42d';  // Идентификатор приложения
  DisplayApp = 'page';  // Внешний вид формы мобильных приложений. Допустимые значения:
                        //   "page" — Страница
                        //   "popup" — Всплывающее окно
  Expires_at = 604800;  // Срок действия access_token в формате UNIX. Также можно указать дельту в секундах.
                        // Срок действия и дельта не должны превышать две недели, начиная с настоящего времени.
  Nofollow = 1;         // При передаче параметра nofollow=1 переадресация не происходит. URL возвращается в ответе.
                        // По умолчанию: 0. Минимальное значение: 0. Максимальное значение: 1.
  RedirectURL = 'https://developers.wargaming.net/reference/all/wot/auth/login/';   // URL на который будет переброшен пользователь
                                                                                    // после того как он пройдет аутентификацию.
                                                                                    // По умолчанию: api.worldoftanks.ru/wot//blank/
  AuthURL = 'https://api.worldoftanks.ru/wot/auth/login/?application_id=%s&display=%s&expires_at=%s&nofollow=%d';  // URL для запроса

  // Коды ошибок
  AUTH_CANCEL = 401;   // Пользователь отменил авторизацию для приложения
  AUTH_EXPIRED = 403;  // Превышено время ожидания авторизации пользователя
  AUTH_ERROR = 410;    // Ошибка аутентификации

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
    procedure AuthActionExecute(Sender: TObject);
    procedure SearchActionExecute(Sender: TObject);
  private
    FCodeErr: string;
    FMessageErr: string;
    FStatusErr: string;
    Fnickname: string;
    Fexpires_at: string;
    FStatus: string;
    Faccess_token: String;
    Faccount_id: string;
    FlocationRedirect: string;
    FSuccessRedirectURL: string;
    procedure Setaccess_token(const Value: String);
    procedure Setaccount_id(const Value: string);
    procedure SetCodeErr(const Value: string);
    procedure Setexpires_at(const Value: string);
    procedure SetMessageErr(const Value: string);
    procedure Setnickname(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetStatusErr(const Value: string);
    procedure SetlocationRedirect(const Value: string);
    procedure SetSuccessRedirectURL(const Value: string);
    { Private declarations }
  public

  published
//    Параметры redirect_uri при успешной аутентификации
    property Status: string read FStatus write SetStatus;
    property access_token: String read Faccess_token write Setaccess_token;
    property expires_at: string read Fexpires_at write Setexpires_at;
    property account_id: string read Faccount_id write Setaccount_id;
    property nickname: string read Fnickname write Setnickname;

    // Параметры redirect_uri при ошибке аутентификации
    property StatusErr: string read FStatusErr write SetStatusErr;
    property CodeErr: string read FCodeErr write SetCodeErr;
    property MessageErr: string read FMessageErr write SetMessageErr;

    property locationRedirect: string read FlocationRedirect write SetlocationRedirect;
    property SuccessRedirectURL: string read FSuccessRedirectURL write SetSuccessRedirectURL;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses BrowserEmulationAdjuster, Auth, Globals, SConsts, Search;

{ TMainForm }

procedure TMainForm.AuthActionExecute(Sender: TObject);
var
  AuthF: TAuthForm;
begin
  AuthF := TAuthForm.Create(Self);

  try
      AuthF.ShowModal();
  finally
    FreeAndNil(AuthF);
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

procedure TMainForm.Setaccess_token(const Value: String);
begin
  Faccess_token := Value;
end;

procedure TMainForm.Setaccount_id(const Value: string);
begin
  Faccount_id := Value;
end;

procedure TMainForm.SetCodeErr(const Value: string);
begin
  FCodeErr := Value;
end;

procedure TMainForm.Setexpires_at(const Value: string);
begin
  Fexpires_at := Value;
end;

procedure TMainForm.SetlocationRedirect(const Value: string);
begin
  FlocationRedirect := Value;
end;

procedure TMainForm.SetMessageErr(const Value: string);
begin
  FMessageErr := Value;
end;

procedure TMainForm.Setnickname(const Value: string);
begin
  Fnickname := Value;
end;

procedure TMainForm.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TMainForm.SetStatusErr(const Value: string);
begin
  FStatusErr := Value;
end;

procedure TMainForm.SetSuccessRedirectURL(const Value: string);
begin
  FSuccessRedirectURL := Value;
end;

end.
