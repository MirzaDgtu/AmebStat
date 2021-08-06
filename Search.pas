unit Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.Grids, System.JSON, ActiveX, Vcl.Samples.Spin, Vcl.ComCtrls;

const
  StartsWith = 'startswith';  // ����� �� ��������� ����� ����� ������ ��� ����� ��������.
                              // ����������� �����: 3 �������. ������������ �����: 24 �������.

  Exact = 'exact';            // ����� �� �������� ������������ ����� ������ ��� ����� ��������.
                              // ����� ����������� ��������� ��� ��� ������ (�� 100 ��������), �������� �� ��������.
  SearchURL = 'https://api.worldoftanks.ru/wot/account/list/?application_id=%s&search=%s&language=%s&limit=%s&type=%s';

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
    NetClient: TNetHTTPClient;
    NetRequest: TNetHTTPRequest;
    Splitter1: TSplitter;
    DataGrid: TStringGrid;
    LimitSpEdit: TSpinEdit;
    Label2: TLabel;
    SB: TStatusBar;
    procedure SearchBtnClick(Sender: TObject);
    procedure StartsRBtnClick(Sender: TObject);
    procedure ExactRBtnClick(Sender: TObject);
    procedure NetRequestRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);
    procedure FormCreate(Sender: TObject);
    procedure SBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
  private
    FtypeSearch: string;
    { Private declarations }
    procedure SettypeSearch(const Value: string);
    procedure SetColNames(Data: TStringGrid);
    procedure SetDefaultParams();
    procedure InsToGrid(Nickname, id_account: string);
    procedure ParseSearchResults(strJSON: string);

    function getRagion(Index: smallint): string;
  public
    { Public declarations }
    function SearchReq(l_AppKey, l_NickName, l_language, l_limit, l_type: string): Boolean;
  published
    property typeSearch: string read FtypeSearch write SettypeSearch;
  end;

var
  SearchForm: TSearchForm;

implementation

{$R *.dfm}

uses Globals, SConsts;

{ TSearchForm }

procedure TSearchForm.ExactRBtnClick(Sender: TObject);
begin
  typeSearch := Exact;
end;

procedure TSearchForm.FormCreate(Sender: TObject);
begin
  SetColNames(DataGrid);
end;

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

procedure TSearchForm.InsToGrid(Nickname, id_account: string);
var
  index: integer;
begin
  if DataGrid.Cells[0,1] = EmptyStr then
    Begin
      DataGrid.Cells[0,1] := '1';
      DataGrid.Cells[1,1] := Nickname;
      DataGrid.Cells[2,1] := id_account;
    End
  else
    Begin
      index := DataGrid.RowCount + 1;
      DataGrid.RowCount := index;
      DataGrid.Cells[0, index-1] := (index-1).ToString;
      DataGrid.Cells[1, index-1] := Nickname;
      DataGrid.Cells[2, index-1] := id_account;
    End;
end;

procedure TSearchForm.NetRequestRequestCompleted(const Sender: TObject;
  const AResponse: IHTTPResponse);
begin
  ParseSearchResults(AResponse.ContentAsString());
end;

procedure TSearchForm.ParseSearchResults(strJSON: string);
var
  JSON: TJSONObject;
  dataArr: TJSONArray;
  Count: integer;
  curAccount: TJSONObject;
  I: Integer;
begin
 JSON := TJSONObject.ParseJSONValue(strJSON) as TJSONObject;

  try
    Count := ((JSON.Get('meta').JsonValue as TJSONObject).Get('count')).JsonValue.Value.ToInteger;
    SB.Panels[0].Text := Format('���������� �����������: %d', [Count]);
    dataArr := JSON.GetValue('data') as TJSONArray;

    for I := 0 to Count-1 do
      Begin
        curAccount := dataArr.Items[i] as TJSONObject;
        InsToGrid(curAccount.Get('nickname').JsonValue.Value, curAccount.Get('account_id').JsonValue.Value);
      End;
  finally
    FreeAndNil(JSON);
  end;
end;

procedure TSearchForm.SBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  with StatusBar.Canvas do
    Begin
       Font.Style := Font.Style + [fsBold];

       if Panel = StatusBar.Panels[0] then
         Font.Color := clTeal;

       TextOut(Rect.Left, Rect.Top, Panel.Text);
    end;
end;

procedure TSearchForm.SearchBtnClick(Sender: TObject);
begin
   SetDefaultParams;
   SearchReq(AppKey, NikcknameLE.Text, getRagion(RegionCB.ItemIndex), LimitSpEdit.Value.ToString, typeSearch);
end;

function TSearchForm.SearchReq(l_AppKey, l_NickName, l_language, l_limit,
  l_type: string): Boolean;
var
  strReq: string;
begin
  if l_NickName.IsEmpty then
    Begin
      raise Exception.Create('������� �� ������ ���� ������.' + #13 + '���������� ��������� ��������������� ����.');
      Exit;
    End;

  strReq := Format(SearchURL, [l_AppKey,
                               l_NickName,
                               l_language,
                               l_limit,
                               l_type]);
  try
    NetRequest.MethodString := 'GET';
    NetRequest.URL := strReq;
    NetRequest.Execute();
  finally
  end;
end;

procedure TSearchForm.SetColNames(Data: TStringGrid);
begin
  Data.Cells[0,0] := '�';
  Data.Cells[1,0] := 'NickName';
  Data.Cells[2,0] := 'Id_Account';

  Data.ColWidths[0] := 25;
  Data.ColWidths[1] := 147;
  Data.ColWidths[2] := 147;
end;

procedure TSearchForm.SetDefaultParams;
var
  j, i: Integer;
begin
  for I := 0 to DataGrid.ColCount-1 do
    for j := 0 to DataGrid.RowCount - 1 do
      DataGrid.Cells[i,j] := EmptyStr;

  DataGrid.RowCount := 2;
  SetColNames(DataGrid);
end;

procedure TSearchForm.SettypeSearch(const Value: string);
begin
  FtypeSearch := Value;
end;

procedure TSearchForm.StartsRBtnClick(Sender: TObject);
begin
  typeSearch := StartsWith;
end;

end.
