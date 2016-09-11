object Form1: TForm1
  Left = 0
  Top = 0
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Ipler'
  ClientHeight = 112
  ClientWidth = 204
  Color = clBtnFace
  Constraints.MaxHeight = 150
  Constraints.MaxWidth = 220
  Constraints.MinHeight = 101
  Constraints.MinWidth = 220
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 127
    Top = 0
    Width = 34
    Height = 22
    Caption = 'copy'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 167
    Top = 0
    Width = 34
    Height = 22
    Caption = 'http'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 8
    Top = 27
    Width = 27
    Height = 13
    Caption = 'Land:'
  end
  object Label2: TLabel
    Left = 8
    Top = 46
    Width = 37
    Height = 13
    Caption = 'Region:'
  end
  object Label3: TLabel
    Left = 61
    Top = 27
    Width = 44
    Height = 13
    Caption = 'Unknown'
  end
  object Label4: TLabel
    Left = 61
    Top = 46
    Width = 44
    Height = 13
    Caption = 'Unknown'
  end
  object Label5: TLabel
    Left = 8
    Top = 71
    Width = 45
    Height = 13
    Caption = 'Shortcut:'
  end
  object SpeedButton3: TSpeedButton
    Left = 127
    Top = 90
    Width = 74
    Height = 22
    Caption = 'set Timer'
    OnClick = SpeedButton3Click
  end
  object Label6: TLabel
    Left = 41
    Top = 93
    Width = 45
    Height = 13
    Caption = 'minute(s)'
  end
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 513
    Width = 193
    Height = 48
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object HotKey1: THotKey
    Left = 80
    Top = 65
    Width = 121
    Height = 19
    HotKey = 16465
    Modifiers = [hkCtrl]
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 8
    Top = 90
    Width = 27
    Height = 21
    TabOrder = 3
    Text = '10'
    OnKeyPress = Edit2KeyPress
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 792
    Top = 632
  end
  object TrayIcon1: TTrayIcon
    OnDblClick = TrayIcon1DblClick
    OnMouseUp = TrayIcon1MouseUp
    Left = 792
    Top = 584
  end
  object Timer1: TTimer
    Interval = 600000
    OnTimer = Timer1Timer
    Left = 88
    Top = 456
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 456
    object Info1: TMenuItem
      Caption = 'Info'
      OnClick = Info1Click
    end
    object showForm11: TMenuItem
      Caption = 'Show Form1'
      OnClick = showForm11Click
    end
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
  end
end
