unit Garage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg;

const
  // ����� ����������
  OutMastery = '�����������';   // 0 � �����������
  ThirdDegree = '3 - �������';  // 1 � 3 �������
  SecondDegree = '2 - �������'; // 2 � 2 �������
  FirstDegree = '1 - �������';  // 3 � 1 �������
  MasterDegree = '������';      // 4 � ������

  MachinesURL = 'https://api.worldoftanks.ru/wot/account/tanks/?application_id=%s&account_id=%s&language=%s&access_token=%s';
type
  TGarageFrame = class(TFrame)
    BackGroundImage: TImage;
  private
    { Private declarations }
    function getDegree(index: byte): String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TGarageFrame }

function TGarageFrame.getDegree(index: byte): String;
var
  strRes: string;
begin
  try
    case index of
      0: strRes := OutMastery;
      1: strRes := ThirdDegree;
      2: strRes := SecondDegree;
      3: strRes := FirstDegree;
      4: strRes := MasterDegree;
    end;
  finally
    Result := strRes;
  end;
end;

end.
