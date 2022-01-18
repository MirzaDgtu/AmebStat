unit Auth;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.OleCtrls, SHDocVw, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.JSON, Vcl.Buttons, ActiveX,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.ComCtrls,
  Vcl.ToolWin, System.DateUtils, System.StrUtils;



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
    SaveLogBtn: TBitBtn;
    OpenLogBtn: TBitBtn;
    ClearLogBtn: TBitBtn;
    AL: TActionList;
    AuthAction: TAction;
    IL: TImageList;
    SaveParamsAction: TAction;
    LoadParamsAction: TAction;
    SaveLogAction: TAction;
    OpenLogAction: TAction;
    ClearLogAction: TAction;
    BtnsTB: TToolBar;
    btnAuth: TToolButton;
    btnSaveParams: TToolButton;
    btnLoadParams: TToolButton;
    btnClearParams: TToolButton;
    ClearParamsAction: TAction;
    procedure BrowserAuthBeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure BrowserAuthNavigateComplete2(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure NetRequestRequestError(const Sender: TObject;
      const AError: string);
    procedure NetRequestRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure AuthActionExecute(Sender: TObject);
    procedure ClearParamsActionExecute(Sender: TObject);
    procedure SaveParamsActionExecute(Sender: TObject);
    procedure LoadParamsActionExecute(Sender: TObject);
  private
    { Private declarations }
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
    FpathJSONfile: string;

    procedure ParseAuth(strJSON: string);
//    procedure GetPropertiesAuth(strAuth: string; CountSymb: integer);
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
    procedure setParamsToProperty(st, at, ex, ac, nc: string);
  public
    { Public declarations }
    procedure SetpathJSONfile(const Value: string);
    procedure setParamsToEdit(st, at, ex, ac, nc: string);

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

      property pathJSONfile: string read FpathJSONfile write SetpathJSONfile;
  end;

var
  AuthForm: TAuthForm;

implementation

{$R *.dfm}

uses Globals, SConsts, BrowserEmulationAdjuster;

procedure TAuthForm.AuthActionExecute(Sender: TObject);
var
  strReq: string;
begin
  try
    LogMemo.Lines.Add('Начат процесс авторизации');
    strReq := Format(AuthURL, [AppKey,
                               DisplayApp,
                               s_Expires_at,
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
var
  st, at, ex, ac, nc: string;
begin
  try
    SuccessRedirectURL := URL;
    GetPropertiesAuth(SuccessRedirectURL, Length(SuccessRedirectURL),
                      st, at, ex,
                      ac, nc);
    setParamsToProperty(st, at, ex, ac, nc);
    LogMemo.Lines.Add(URL);
  finally
    LogMemo.Lines.Add('Строка успешной авторизации получена!');
    setParamsToEdit(st, at, ex, ac, nc);
  end;
end;

procedure TAuthForm.ClearParamsActionExecute(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ControlCount - 1 do
    Begin
      if Controls[i] is TEdit then
        Begin
          (Controls[i] as TEdit).Clear;
        End;
    End;
end;

procedure TAuthForm.LoadParamsActionExecute(Sender: TObject);
var
  sl: TStringList;
  st, at, ex, ac, nc: string;
begin
  try
    sl := TStringList.Create;
    sl.LoadFromFile(pathJSONfile);
    GetPropertiesAuth(sl.Text, Length(sl.Text),
                      st, at, ex, ac, nc);
    setParamsToProperty(st, at, ex, ac, nc);
  finally
    FreeAndNil(sl);
    setParamsToEdit(st, at, ex, ac, nc);
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
    SetlocationRedirect(((JSON.Get('data').JsonValue as TJSONObject).Get('location')).JsonValue.Value);
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

procedure TAuthForm.SaveParamsActionExecute(Sender: TObject);
var
  sl: TStringList;
begin
  try
    sl := TStringList.Create;
    sl.Add(SuccessRedirectURL);
    LogMemo.Lines.Add(pathJSONfile);
  finally
    sl.SaveToFile(pathJSONfile, TEncoding.UTF8);
    FreeAndNil(sl);
    LogMemo.Lines.Add('Файл с параметрами успешно сохранен');
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

procedure TAuthForm.setParamsToEdit(st, at, ex, ac, nc: string);
begin
  StatusEdit.Text := IfThen(not st.IsEmpty, st, Status);
  Access_TokenEdit.Text := IfThen(not at.IsEmpty, at, access_token);
  Expires_AtEdit.Text := IfThen(not ex.IsEmpty, ex, expires_at);
  Account_IdEdit.Text := IfThen(not ac.IsEmpty, ac, account_id);
  NicknameEdit.Text := IfThen(not nc.IsEmpty, nc, nickname);
end;

procedure TAuthForm.setParamsToProperty(st, at, ex, ac, nc: string);
begin
  try
    SetStatus(st);
    Setaccess_token(at);
    Setexpires_at(ex);
    Setaccount_id(ac);
    Setnickname(nc);
  finally
    LogMemo.Lines.Add('Параметры успешно записаны в свойства')
  end;
end;

procedure TAuthForm.SetpathJSONfile(const Value: string);
begin
  FpathJSONfile := Value;
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
