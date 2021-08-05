unit Globals;

interface

type
  TAuthParams = record
  // ��������� redirect_uri ��� �������� ��������������
       Status: string;
       access_token: String;
       expires_at: string;
       account_id: string;
       nickname: string;

  // ��������� redirect_uri ��� ������ ��������������
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
  FillChar(g_AuthParams, SizeOf(TAuthParams), #0); // ������� ������

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
