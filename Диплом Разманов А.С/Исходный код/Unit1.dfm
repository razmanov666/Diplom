object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077' '#1076#1083#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' XML'
  ClientHeight = 563
  ClientWidth = 891
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  DesignSize = (
    891
    563)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 20
    Top = 477
    Width = 121
    Height = 39
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083'...'
    DragKind = dkDock
    TabOrder = 1
    OnClick = Button1Click
    ExplicitTop = 457
  end
  object Button3: TButton
    Left = 299
    Top = 478
    Width = 113
    Height = 39
    Anchors = [akLeft, akBottom]
    BiDiMode = bdLeftToRight
    Caption = #1057#1086#1079#1076#1072#1090#1100' XML'
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = Button3Click
    ExplicitTop = 458
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 66
    Width = 865
    Height = 406
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = cl3DDkShadow
    ColCount = 12
    FixedCols = 0
    RowCount = 15
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing]
    ParentFont = False
    TabOrder = 2
    Visible = False
    ExplicitHeight = 386
  end
  object Button2: TButton
    Left = 790
    Top = 476
    Width = 91
    Height = 39
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 3
    OnClick = Button2Click
    ExplicitTop = 456
  end
  object DBGrid1: TDBGrid
    Left = 351
    Top = 82
    Width = 90
    Height = 41
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 528
    Width = 891
    Height = 16
    Align = alBottom
    Step = 1
    TabOrder = 5
    Visible = False
    ExplicitTop = 508
  end
  object Button5: TButton
    Left = 154
    Top = 478
    Width = 127
    Height = 38
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1099#1075#1088#1091#1079#1082#1080
    TabOrder = 6
    OnClick = Button5Click
    ExplicitTop = 458
  end
  object StringGrid2: TStringGrid
    Left = 695
    Top = 82
    Width = 66
    Height = 41
    TabOrder = 7
    Visible = False
  end
  object StatusBar1: TStatusBar
    Left = 9
    Top = 8
    Width = 864
    Height = 20
    AutoHint = True
    Align = alNone
    Anchors = [akLeft, akTop, akRight]
    Color = clMenuHighlight
    Panels = <
      item
        Text = #1042#1099#1073#1088#1072#1085#1085#1099#1081' '#1092#1072#1081#1083' :'
        Width = 110
      end
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
    Visible = False
  end
  object StatusBar2: TStatusBar
    Left = 9
    Top = 47
    Width = 864
    Height = 20
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    DoubleBuffered = False
    Panels = <
      item
        Text = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1074' :'
        Width = 110
      end
      item
        Width = 50
      end>
    ParentDoubleBuffered = False
    Visible = False
  end
  object StatusBar3: TStatusBar
    Left = 9
    Top = 28
    Width = 864
    Height = 19
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    Panels = <
      item
        Text = #1060#1072#1081#1083' '#1084#1072#1082#1077#1090#1072' :'
        Width = 110
      end
      item
        Width = 50
      end>
    Visible = False
  end
  object StatusBar4: TStatusBar
    Left = 0
    Top = 544
    Width = 891
    Height = 19
    Panels = <
      item
        Text = #1057#1090#1072#1090#1091#1089' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' :'
        Width = 120
      end
      item
        Width = 300
      end
      item
        Alignment = taRightJustify
        Width = 50
      end>
    ExplicitTop = 524
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All|*.*|Excel |*.xlsx;*.xls|dBase lll, lV|*.dbf'
    Left = 560
    Top = 82
  end
  object XMLDocument1: TXMLDocument
    NodeIndentStr = #9
    XML.Strings = (
      '<?xml version="1.0" encoding="UTF-8"?>')
    Left = 480
    Top = 82
    DOMVendorDesc = 'MSXML'
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=VFPOLEDB.1;Data Source=C:\Users\razma\Desktop\ForAlexey' +
      'true;Password="";Collating Sequence=MACHINE'
    LoginPrompt = False
    Provider = 'VFPOLEDB.1'
    Left = 296
    Top = 82
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'mns_1'
    Left = 232
    Top = 82
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 168
    Top = 82
  end
end
