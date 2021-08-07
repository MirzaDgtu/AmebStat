object GarageFrame: TGarageFrame
  Left = 0
  Top = 0
  Width = 862
  Height = 657
  TabOrder = 0
  object SB: TStatusBar
    Left = 0
    Top = 638
    Width = 862
    Height = 19
    Panels = <>
    ExplicitLeft = 432
    ExplicitTop = 320
    ExplicitWidth = 0
  end
  object ParamsPanel: TPanel
    Left = 712
    Top = 41
    Width = 150
    Height = 597
    Align = alRight
    TabOrder = 1
    ExplicitTop = 0
    ExplicitHeight = 638
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 336
    ExplicitTop = 312
    ExplicitWidth = 185
  end
  object DataLV: TListView
    Left = 0
    Top = 41
    Width = 712
    Height = 597
    Align = alClient
    Color = clBtnFace
    Columns = <
      item
        Caption = 'id_Tank'
        Width = 100
      end
      item
        Caption = 'battles'
        Width = 70
      end
      item
        Caption = 'wins'
        Width = 70
      end
      item
        Caption = 'mark_of_mastery'
        Width = 150
      end
      item
        Caption = 'PercentWins'
        Width = 90
      end>
    GridLines = True
    MultiSelect = True
    OwnerData = True
    OwnerDraw = True
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 3
    ViewStyle = vsReport
    ExplicitTop = 35
  end
end
