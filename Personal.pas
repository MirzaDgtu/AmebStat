unit Personal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXCtrls, Vcl.ComCtrls, Vcl.CategoryButtons, System.ImageList,
  Vcl.ImgList, Garage, System.Actions, Vcl.ActnList, RandomFrame;

const
  // Extra Список дополнительных полей, которые будут включены в ответ.
  // Записываются через запятые. Допустимые значения:
  Boosters = 'private.boosters';                                              // Личные резервы
  Garage   = 'private.garage';                                                // Техника в Ангаре
  Grouped_Contacts = 'private.grouped_contacts';                              // Группы контактов

  Personal_Missions = 'private.personal_missions';                            // Прогресс по личным боевым задачам.
                                                                              // Ключ - идентификатор задачи, значение - статус.
                                                                              // Возможные статусы:
                                                                              // NONE - миссия недоступна
                                                                              // UNLOCKED - миссия доступна
                                                                              // NEED_GET_MAIN_REWARD - не получено основное вознаграждение
                                                                              // MAIN_REWARD_GOTTEN - основное вознаграждение получено
                                                                              // NEED_GET_ADD_REWARD - не получено второстепенное вознаграждение
                                                                              // NEED_GET_ALL_REWARDS - не получено ни одно вознаграждение
                                                                              // ALL_REWARDS_GOTTEN - все вознаграждения получены .

  Rented =  'private.rented';                                                 // Аренда техники.
  StatisticsEpic = 'statistics.epic';                                         // Статистика в типе боя «Генеральное сражение»
  StatisticsFallout = 'statistics.fallout';                                   // Статистика в режиме «Бой до последнего».
  StatisticsGlobalmapAbsolute = 'statistics.globalmap_absolute';              // Статистика боёв на Глобальной карте в Абсолютном дивизионе.
  StatisticsRandom = 'statistics.random';                                     // Статистика случайных боёв.
  StatisticsRanked_battles = 'statistics.ranked_battles';                     // Статистика по Ранговым боям.
  StatisticsRanked_battles_current = 'statistics.ranked_battles_current';     // Текущая статистика по Ранговым боям.
  StatisticsRanked_battles_previous = 'statistics.ranked_battles_previous';   // Предыдущая статистика по Ранговым боям.
 ////-------------------------------------------------------------------------////

type
  TPersonalForm = class(TForm)
    TopPanel: TPanel;
    SB: TStatusBar;
    SV: TSplitView;
    MenuBtn: TBitBtn;
    catMenuItems: TCategoryButtons;
    imlIcons: TImageList;
    FramePanel: TPanel;
    GarageF: TGarageFrame;
    AL: TActionList;
    RandomF: TRandomFormFrame;
    procedure MenuBtnClick(Sender: TObject);
    procedure catMenuItemsCategoryCollapase(Sender: TObject;
      const Category: TButtonCategory);
    procedure SVClosed(Sender: TObject);
    procedure SVOpened(Sender: TObject);
    procedure SVOpening(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PersonalForm: TPersonalForm;

implementation

{$R *.dfm}

uses SConsts, Globals;

procedure TPersonalForm.catMenuItemsCategoryCollapase(Sender: TObject;
  const Category: TButtonCategory);
begin
  catMenuItems.Categories[0].Collapsed := False;
end;

procedure TPersonalForm.MenuBtnClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TPersonalForm.SVClosed(Sender: TObject);
begin
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions - [boShowCaptions];
  if SV.CloseStyle = svcCompact then
    catMenuItems.Width := SV.CompactWidth;
end;

procedure TPersonalForm.SVOpened(Sender: TObject);
begin
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width := SV.OpenedWidth;
end;

procedure TPersonalForm.SVOpening(Sender: TObject);
begin
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width := SV.OpenedWidth;
end;

end.
