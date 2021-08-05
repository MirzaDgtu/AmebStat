unit Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

const
  StartsWith = 'startswith';  // Поиск по начальной части имени игрока без учёта регистра.
                              // Минимальная длина: 3 символа. Максимальная длина: 24 символа.

  exact = 'exact';            // Поиск по строгому соответствию имени игрока без учёта регистра.
                              // Можно перечислить несколько имён для поиска (до 100 значений), разделив их запятыми.

type
  TSearchForm = class(TForm)
    SearchGB: TGroupBox;
    NikcknameLE: TLabeledEdit;
    RegionCB: TComboBox;
    Label1: TLabel;
    BottomPanel: TPanel;
    SearchBtn: TBitBtn;
    SwichRBG: TRadioGroup;
    StartsRBtn: TRadioButton;
    ExactRBtn: TRadioButton;
  private
    { Private declarations }
    function getRagion(Index: smallint): string;
  public
    { Public declarations }
  end;

var
  SearchForm: TSearchForm;

implementation

{$R *.dfm}

{ TSearchForm }

function TSearchForm.getRagion(Index: smallint): string;
begin
   case Index of
     0: Result := 'en';
     1: Result := 'ru';
     2: Result := 'pl';
     3: Result := 'de';
     4: Result := 'fr';
     5: Result := 'es';
     6: Result := 'zh-cn';
     7: Result := 'zh-tw';
     8: Result := 'tr';
     9: Result := 'cs';
     10: Result := 'th';
     11: Result := 'vi';
     12: Result := 'ko';
   else
    raise Exception.Create('Необходимо выбрать регион, в котором зарегистрирован аккаунт пользователя');
   end;
end;

end.
