unit Globals;


interface

uses
  System.DateUtils, System.SysUtils;

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

  procedure GetPropertiesAuth(strAuth: string; CountSymb: integer); overload;
  procedure GetPropertiesAuth(strAuth: string; CountSymb: integer;
                              var Status, access_token, expires_at,
                                  account_id, nickname: string); overload;
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

procedure GetPropertiesAuth(strAuth: string; CountSymb: integer;
                              var Status, access_token, expires_at,
                                  account_id, nickname: string);
Begin
    if CountSymb > 0 then
    try
       Status := Copy(strAuth, Pos('&status=', strAuth) + Length('&status='), Pos('&access_token=', strAuth) - (Pos('&status=', strAuth) + Length('&status=')));
       access_token := Copy(strAuth, Pos('&access_token=', strAuth) + Length('&access_token='), Pos('&nickname=', strAuth) - (Pos('&access_token=', strAuth) + Length('&access_token=')));
       nickname := (Copy(strAuth, Pos('&nickname=', strAuth) + Length('&nickname='), Pos('&account_id=', strAuth) - (Pos('&nickname=', strAuth) + Length('&nickname='))));
       account_id := (Copy(strAuth, Pos('&account_id=', strAuth) + Length('&account_id='), Pos('&expires_at=', strAuth) - (Pos('&account_id=', strAuth) + Length('&account_id='))));
       expires_at := DateTimeToStr(UnixToDateTime(StrToInt64(Trim((Copy(strAuth, Pos('&expires_at=', strAuth) + Length('&expires_at='), Length(strAuth) - Pos('&expires_at=', strAuth) + Length('&expires_at=')))))));
    finally
       SetAuthParams(Status, access_token, expires_at, account_id, nickname);   // Передача данных в глобальную запись (record)
    end;
End;

procedure GetPropertiesAuth(strAuth: string; CountSymb: integer);
var
   Status, access_token, expires_at, account_id, nickname: string;
Begin
    try
       Status := Copy(strAuth, Pos('&status=', strAuth) + Length('&status='), Pos('&access_token=', strAuth) - (Pos('&status=', strAuth) + Length('&status=')));
       access_token := Copy(strAuth, Pos('&access_token=', strAuth) + Length('&access_token='), Pos('&nickname=', strAuth) - (Pos('&access_token=', strAuth) + Length('&access_token=')));
       nickname := (Copy(strAuth, Pos('&nickname=', strAuth) + Length('&nickname='), Pos('&account_id=', strAuth) - (Pos('&nickname=', strAuth) + Length('&nickname='))));
       account_id := (Copy(strAuth, Pos('&account_id=', strAuth) + Length('&account_id='), Pos('&expires_at=', strAuth) - (Pos('&account_id=', strAuth) + Length('&account_id='))));
       expires_at := DateTimeToStr(UnixToDateTime(StrToInt64(Trim((Copy(strAuth, Pos('&expires_at=', strAuth) + Length('&expires_at='), Length(strAuth) - Pos('&expires_at=', strAuth) + Length('&expires_at=')))))));
    finally
       SetAuthParams(Status, access_token, expires_at, account_id, nickname);   // Передача данных в глобальную запись (record)
    end;
End;

end.
