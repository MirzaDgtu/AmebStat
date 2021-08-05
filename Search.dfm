object SearchForm: TSearchForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'SearchForm'
  ClientHeight = 465
  ClientWidth = 342
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 331
    Width = 342
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 116
    ExplicitWidth = 137
  end
  object SearchGB: TGroupBox
    Left = 0
    Top = 0
    Width = 342
    Height = 116
    Align = alTop
    Caption = '&'#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1080#1089#1082#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 341
    object Label1: TLabel
      Left = 209
      Top = 16
      Width = 40
      Height = 13
      Caption = '&'#1056#1077#1075#1080#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 207
      Top = 63
      Width = 68
      Height = 13
      Caption = '&'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object NikcknameLE: TLabeledEdit
      Left = 16
      Top = 32
      Width = 180
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = '&'#1053#1080#1082#1085#1077#1081#1084
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clRed
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      TabOrder = 0
    end
    object RegionCB: TComboBox
      Left = 207
      Top = 32
      Width = 127
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 1
      TabOrder = 1
      Text = '"ru" '#8212' '#1056#1091#1089#1089#1082#1080#1081
      Items.Strings = (
        '"en" '#8212' English'
        '"ru" '#8212' '#1056#1091#1089#1089#1082#1080#1081
        '"pl" '#8212' Polski'
        '"de" '#8212' Deutsch'
        '"fr" '#8212' Fran'#231'ais'
        '"es" '#8212' Espa'#241'ol'
        '"zh-cn" '#8212' '#31616#20307#20013#25991
        '"zh-tw" '#8212' '#32321#39636#20013#25991
        '"tr" '#8212' T'#252'rk'#231'e'
        '"cs" '#8212' '#268'e'#353'tina'
        '"th" '#8212' '#3652#3607#3618
        '"vi" '#8212' Ti'#7871'ng Vi'#7879't'
        '"ko" '#8212' '#54620#44397#50612)
    end
    object SearchBtn: TBitBtn
      Left = 221
      Top = 88
      Width = 92
      Height = 22
      Caption = '&'#1053#1072#1081#1090#1080
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5F5F2F2F1FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDDDC7972
        6C756E68EEEDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFE2E1DF7A736DD8D6D478716CF4F3F3FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE8E7E6D3D0CFE6E5E4FEFEFEFFFFFF9C9792BBB7B47972
        6CE2E1DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDBDA7C756F8E8883AB9A8791
        83747A726AD7D5D38C86829C9793E4E2E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        DDDCDA7E7771F0EFEEFFFFFFFFF4E6FFE7C6F4C58683786DD5D3D2FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF827C77EDECEBFFFFFFFFFFFFFFFFFFFF
        FFFFFFFBF6F4C78A7E7670FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEDED
        847D78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7C7918273E5E3E2FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFDEDCDB9A9591FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF0DCA8957DD3D1CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0EFEF
        817A75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5E88E8277E8E6E5FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF857F7AE4E3E2FFFFFFFFFFFFFFFFFFFF
        FFFFFFFCF7F0E7DC827B76FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        E4E2E17A736DE3E1E0FFFFFFFFFFFFFFFFFFEEE9E27F766FDDDCDAFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E3E288827D88827D98928E82
        7C7788817CE0DFDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF4F3F3DEDCDBF3F2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 2
      OnClick = SearchBtnClick
    end
    object SwichRBG: TRadioGroup
      Left = 16
      Top = 54
      Width = 180
      Height = 59
      Caption = '&'#1055#1086#1080#1089#1082' '#1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object StartsRBtn: TRadioButton
      Left = 24
      Top = 69
      Width = 126
      Height = 17
      Caption = '&'#1085#1072#1095#1072#1083#1091' '#1085#1080#1082#1085#1077#1081#1084#1072
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = StartsRBtnClick
    end
    object ExactRBtn: TRadioButton
      Left = 24
      Top = 88
      Width = 153
      Height = 17
      Caption = '&'#1087#1086#1083#1085#1086#1084#1091' '#1085#1080#1082#1085#1077#1081#1084#1091
      TabOrder = 5
      OnClick = ExactRBtnClick
    end
    object LimitSpEdit: TSpinEdit
      Left = 290
      Top = 60
      Width = 44
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 6
      Value = 10
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 431
    Width = 342
    Height = 34
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 216
    ExplicitWidth = 316
  end
  object LogMemo: TMemo
    Left = 0
    Top = 334
    Width = 342
    Height = 97
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitWidth = 341
  end
  object DataGrid: TStringGrid
    Left = 0
    Top = 116
    Width = 342
    Height = 215
    Align = alClient
    ColCount = 3
    DefaultColWidth = 120
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object NetClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    HandleRedirects = True
    AllowCookies = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 281
    Top = 120
  end
  object NetRequest: TNetHTTPRequest
    Asynchronous = True
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = NetClient
    OnRequestCompleted = NetRequestRequestCompleted
    Left = 281
    Top = 176
  end
end
