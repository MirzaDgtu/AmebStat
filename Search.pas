unit Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

const
  StartsWith = 'startswith';  // ����� �� ��������� ����� ����� ������ ��� ����� ��������.
                              // ����������� �����: 3 �������. ������������ �����: 24 �������.

  exact = 'exact';            // ����� �� �������� ������������ ����� ������ ��� ����� ��������.
                              // ����� ����������� ��������� ��� ��� ������ (�� 100 ��������), �������� �� ��������.

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
    raise Exception.Create('���������� ������� ������, � ������� ��������������� ������� ������������');
   end;
end;

end.
