unit Auth;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.OleCtrls, SHDocVw, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.JSON, Vcl.Buttons, ActiveX;



type
  TAuthForm = class(TForm)
    BottomPanel: TPanel;
    BrowserAuth: TWebBrowser;
    LogMemo: TMemo;
    PropertiesPanel: TPanel;
    AuthGB: TGroupBox;
    Splitter1: TSplitter;
    Label1: TLabel;
    PropertiesGB: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StatusEdit: TEdit;
    Access_TokenEdit: TEdit;
    NicknameEdit: TEdit;
    Account_IdEdit: TEdit;
    Expires_AtEdit: TEdit;
    NetClient: TNetHTTPClient;
    NetRequest: TNetHTTPRequest;
    AuthBtn: TBitBtn;
    SaveLogBtn: TBitBtn;
    OpenLogBtn: TBitBtn;
    ClearLogBtn: TBitBtn;
    procedure BrowserAuthBeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure BrowserAuthNavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure NetRequestRequestError(const Sender: TObject;
      const AError: string);
    procedure AuthBtnClick(Sender: TObject);
    procedure NetRequestRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
  private
    FCodeErr: string;
    FMessageErr: string;
    FStatusErr: string;
    Fnickname: string;
    Fexpires_at: string;
    FStatus: string;
    FSuccessRedirectURL: string;
    Faccess_token: String;
    FlocationRedirect: string;
    Faccount_id: string;
    { Private declarations }
    procedure ParseAuth(strJSON: string);
    procedure GetPropertiesAuth(strAuth: string; CountSymb: integer);
    procedure Setaccess_token(const Value: String);
    procedure Setaccount_id(const Value: string);
    procedure SetCodeErr(const Value: string);
    procedure Setexpires_at(const Value: string);
    procedure SetlocationRedirect(const Value: string);
    procedure SetMessageErr(const Value: string);
    procedure Setnickname(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetStatusErr(const Value: string);
    procedure SetSuccessRedirectURL(const Value: string);

    function SaveHTML(Strings:TStrings; WB: TWebBrowser):boolean;
  public
    { Public declarations }

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
  AuthForm: TAuthForm;

implementation

{$R *.dfm}

uses Globals, SConsts, BrowserEmulationAdjuster;

procedure TAuthForm.AuthBtnClick(Sender: TObject);
var
  strReq: string;
begin
  try
    LogMemo.Lines.Add('Попытка авторизации');
    strReq := Format(AuthURL, [AppKey,
                               DisplayApp,
                               Expires_at,
                               Nofollow]);
    NetRequest.MethodString := 'GET';
    NetRequest.URL := strReq;
    NetRequest.Execute();
  finally
    LogMemo.Lines.Add(strReq);
  end;
end;

procedure TAuthForm.BrowserAuthBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  LogMemo.Lines.Add(URL);
end;

procedure TAuthForm.BrowserAuthNavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  try
    SuccessRedirectURL := URL;
    GetPropertiesAuth(SuccessRedirectURL, Length(SuccessRedirectURL));
    LogMemo.Lines.Add(URL);
  finally
    LogMemo.Lines.Add('Строка успешной авторизации получена!');
  end;
end;

procedure TAuthForm.GetPropertiesAuth(strAuth: string; CountSymb: integer);
begin
    if CountSymb > 0 then
    try
       Status := Copy(strAuth, Pos('&status=', strAuth) + Length('&status='), Pos('&access_token=', strAuth) - (Pos('&status=', strAuth) + Length('&status=')));
       access_token := Copy(strAuth, Pos('&access_token=', strAuth) + Length('&access_token='), Pos('&nickname=', strAuth) - (Pos('&access_token=', strAuth) + Length('&access_token=')));
       nickname := Copy(strAuth, Pos('&nickname=', strAuth) + Length('&nickname='), Pos('&account_id=', strAuth) - (Pos('&nickname=', strAuth) + Length('&nickname=')));
       account_id := Copy(strAuth, Pos('&account_id=', strAuth) + Length('&account_id='), Pos('&expires_at=', strAuth) - (Pos('&account_id=', strAuth) + Length('&account_id=')));
       expires_at := Copy(strAuth, Pos('&expires_at=', strAuth) + Length('&expires_at='), CountSymb - Pos('&expires_at=', strAuth));
    finally
       LogMemo.Lines.Add('Получение параметров завершено!');
       StatusEdit.Text := Status;
       Access_TokenEdit.Text := access_token;
       Expires_AtEdit.Text := expires_at;
       Account_IdEdit.Text := account_id;
       NicknameEdit.Text := nickname;

       SetAuthParams(Status, access_token, expires_at, account_id, nickname);   // Передача данных в глобальную запись (record)
    end;
end;

procedure TAuthForm.NetRequestRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  LogMemo.Lines.Add(AResponse.ContentAsString());
  ParseAuth(AResponse.ContentAsString());
  BrowserAuth.Navigate2(locationRedirect);
end;

procedure TAuthForm.NetRequestRequestError(const Sender: TObject;
  const AError: string);
begin
    LogMemo.Lines.Add('-------------------------------------------------------------------------');
    LogMemo.Lines.Add('При попытке открыть ссылку произошла ошибка: ' + AError);
end;

procedure TAuthForm.ParseAuth(strJSON: string);
var
  JSON: TJSONObject;
begin
 JSON := TJSONObject.ParseJSONValue(strJSON) as TJSONObject;

  try
    locationRedirect := ((JSON.Get('data').JsonValue as TJSONObject).Get('location')).JsonValue.Value;
  finally
    LogMemo.Lines.Add('-------------------------------------------------------------------------');
    LogMemo.Lines.Add(locationRedirect);
    FreeAndNil(JSON);
  end;
end;

function TAuthForm.SaveHTML(Strings: TStrings; WB: TWebBrowser): boolean;
var
 PersistStream: IPersistStreamInit;
 MS: TMemoryStream;
 Stream: IStream;
 SaveResult: HRESULT;
begin
   PersistStream := WB.Document as IPersistStreamInit;
   MS := TMemoryStream.Create;
   Result:=false;
   try
    Stream := TStreamAdapter.Create(MS, soReference) as IStream;
    SaveResult := PersistStream.Save(Stream, True);
    if FAILED(SaveResult) then exit;
    Result:=true;
    MS.position:=0;
    Strings.LoadFromStream(MS);
   finally
    MS.Free;
   end;
end;

procedure TAuthForm.Setaccess_token(const Value: String);
begin
  Faccess_token := Value;
end;

procedure TAuthForm.Setaccount_id(const Value: string);
begin
  Faccount_id := Value;
end;

procedure TAuthForm.SetCodeErr(const Value: string);
begin
  FCodeErr := Value;
end;

procedure TAuthForm.Setexpires_at(const Value: string);
begin
  Fexpires_at := Value;
end;

procedure TAuthForm.SetlocationRedirect(const Value: string);
begin
  FlocationRedirect := Value;
end;

procedure TAuthForm.SetMessageErr(const Value: string);
begin
  FMessageErr := Value;
end;

procedure TAuthForm.Setnickname(const Value: string);
begin
  Fnickname := Value;
end;

procedure TAuthForm.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TAuthForm.SetStatusErr(const Value: string);
begin
  FStatusErr := Value;
end;

procedure TAuthForm.SetSuccessRedirectURL(const Value: string);
begin
  FSuccessRedirectURL := Value;
end;

end.
