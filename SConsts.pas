unit SConsts;

interface

const
  AppKey = 'f1039cf84261ac615fa8221e7938a42d';  // Идентификатор приложения

  // Параметры авторизации
  DisplayApp = 'page';  // Внешний вид формы мобильных приложений. Допустимые значения:
                        //   "page" — Страница
                        //   "popup" — Всплывающее окно
  s_Expires_at = 604800;  // Срок действия access_token в формате UNIX. Также можно указать дельту в секундах.
                        // Срок действия и дельта не должны превышать две недели, начиная с настоящего времени.
  Nofollow = 1;         // При передаче параметра nofollow=1 переадресация не происходит. URL возвращается в ответе.
                        // По умолчанию: 0. Минимальное значение: 0. Максимальное значение: 1.
  RedirectURL = 'https://developers.wargaming.net/reference/all/wot/auth/login/';   // URL на который будет переброшен пользователь
                                                                                    // после того как он пройдет аутентификацию.
                                                                                    // По умолчанию: api.worldoftanks.ru/wot//blank/
  AuthURL = 'https://api.worldoftanks.ru/wot/auth/login/?application_id=%s&display=%s&expires_at=%d&nofollow=%d';  // URL для запроса

  s_AccessKey = 'Ключ доступа: [ %s ]';
  s_IdAccount = 'ID аккаунта: [ %s ]';
  s_AccessExpires = 'Доступен до: [ %s ]';
  s_Status = 'Статус: [ %s ]';

  s_PremiumDays = '%d д';
  s_GoldCount = '%d золота';
  s_SilverCount = '%d серебра';
  s_BonCount = '%d бонов';
  s_FreeExpirience = '%d св. опыта';

  // Коды ошибок авторизации
  AUTH_CANCEL = 401;   // Пользователь отменил авторизацию для приложения
  AUTH_EXPIRED = 403;  // Превышено время ожидания авторизации пользователя
  AUTH_ERROR = 410;    // Ошибка аутентификации

implementation

end.
