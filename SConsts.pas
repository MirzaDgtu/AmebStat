unit SConsts;

interface

const
  AppKey = 'f1039cf84261ac615fa8221e7938a42d';  // ������������� ����������

  // ��������� �����������
  DisplayApp = 'page';  // ������� ��� ����� ��������� ����������. ���������� ��������:
                        //   "page" � ��������
                        //   "popup" � ����������� ����
  s_Expires_at = 604800;  // ���� �������� access_token � ������� UNIX. ����� ����� ������� ������ � ��������.
                        // ���� �������� � ������ �� ������ ��������� ��� ������, ������� � ���������� �������.
  Nofollow = 1;         // ��� �������� ��������� nofollow=1 ������������� �� ����������. URL ������������ � ������.
                        // �� ���������: 0. ����������� ��������: 0. ������������ ��������: 1.
  RedirectURL = 'https://developers.wargaming.net/reference/all/wot/auth/login/';   // URL �� ������� ����� ���������� ������������
                                                                                    // ����� ���� ��� �� ������� ��������������.
                                                                                    // �� ���������: api.worldoftanks.ru/wot//blank/
  AuthURL = 'https://api.worldoftanks.ru/wot/auth/login/?application_id=%s&display=%s&expires_at=%d&nofollow=%d';  // URL ��� �������

  s_AccessKey = '���� �������: [ %s ]';
  s_IdAccount = 'ID ��������: [ %s ]';
  s_AccessExpires = '�������� ��: [ %s ]';
  s_Status = '������: [ %s ]';

  s_PremiumDays = '%d �';
  s_GoldCount = '%d ������';
  s_SilverCount = '%d �������';
  s_BonCount = '%d �����';
  s_FreeExpirience = '%d ��. �����';

  // ���� ������ �����������
  AUTH_CANCEL = 401;   // ������������ ������� ����������� ��� ����������
  AUTH_EXPIRED = 403;  // ��������� ����� �������� ����������� ������������
  AUTH_ERROR = 410;    // ������ ��������������

implementation

end.
