unit Globals;

interface

type
  TAuthParams = record
  // Параметры redirect_uri при успешной аутентификации
       Status: string;
       access_token: String;
       expires_at: string;
       account_id: string;
       nickname: string;

  // Параметры redirect_uri при ошибке аутентификации
       StatusErr: string;
       CodeErr: string;
       MessageErr: string;
  end;

var
  g_AuthParams: TAuthParams;
  procedure SetAuthParams(Status, access_token, expires_at,
                          account_id, nickname: string);

implementation

procedure SetAuthParams(Status, access_token, expires_at,
                        account_id, nickname: string);
Begin
  FillChar(g_AuthParams, SizeOf(TAuthParams), #0); // Очищаем запись

  try
    g_AuthParams.Status := Status;
    g_AuthParams.access_token := access_token;
    g_AuthParams.expires_at := expires_at;
    g_AuthParams.account_id := account_id;
    g_AuthParams.nickname := nickname;
  finally
  end;
End;

end.
