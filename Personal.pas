unit Personal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXCtrls, Vcl.ComCtrls, Vcl.CategoryButtons, System.ImageList,
  Vcl.ImgList, Garage, System.Actions, Vcl.ActnList, RandomFrame;

const
  // Extra ������ �������������� �����, ������� ����� �������� � �����.
  // ������������ ����� �������. ���������� ��������:
  Boosters = 'private.boosters';                                              // ������ �������
  Garage   = 'private.garage';                                                // ������� � ������
  Grouped_Contacts = 'private.grouped_contacts';                              // ������ ���������

  Personal_Missions = 'private.personal_missions';                            // �������� �� ������ ������ �������.
                                                                              // ���� - ������������� ������, �������� - ������.
                                                                              // ��������� �������:
                                                                              // NONE - ������ ����������
                                                                              // UNLOCKED - ������ ��������
                                                                              // NEED_GET_MAIN_REWARD - �� �������� �������� ��������������
                                                                              // MAIN_REWARD_GOTTEN - �������� �������������� ��������
                                                                              // NEED_GET_ADD_REWARD - �� �������� �������������� ��������������
                                                                              // NEED_GET_ALL_REWARDS - �� �������� �� ���� ��������������
                                                                              // ALL_REWARDS_GOTTEN - ��� �������������� �������� .

  Rented =  'private.rented';                                                 // ������ �������.
  StatisticsEpic = 'statistics.epic';                                         // ���������� � ���� ��� ������������ ��������
  StatisticsFallout = 'statistics.fallout';                                   // ���������� � ������ ���� �� ����������.
  StatisticsGlobalmapAbsolute = 'statistics.globalmap_absolute';              // ���������� ��� �� ���������� ����� � ���������� ���������.
  StatisticsRandom = 'statistics.random';                                     // ���������� ��������� ���.
  StatisticsRanked_battles = 'statistics.ranked_battles';                     // ���������� �� �������� ����.
  StatisticsRanked_battles_current = 'statistics.ranked_battles_current';     // ������� ���������� �� �������� ����.
  StatisticsRanked_battles_previous = 'statistics.ranked_battles_previous';   // ���������� ���������� �� �������� ����.
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
