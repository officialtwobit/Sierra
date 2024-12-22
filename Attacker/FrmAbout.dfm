object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'About'
  ClientHeight = 361
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  DesignSize = (
    246
    361)
  TextHeight = 15
  object sLabelFX1: TsLabelFX
    Left = 25
    Top = 8
    Width = 192
    Height = 51
    Alignment = taCenter
    Caption = 'Sierra Loader'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -2
    Shadow.OffsetKeeper.RightBottom = 4
  end
  object sSpeedButton1: TsSpeedButton
    Left = 8
    Top = 217
    Width = 230
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Github'
    ImageIndex = 0
    Images = sCharImageList1
    OnClick = sSpeedButton1Click
  end
  object sSpeedButton2: TsSpeedButton
    Left = 8
    Top = 265
    Width = 230
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Youtube'
    ImageIndex = 1
    Images = sCharImageList1
    OnClick = sSpeedButton2Click
  end
  object sSpeedButton3: TsSpeedButton
    Left = 8
    Top = 313
    Width = 230
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Telegram'
    ImageIndex = 2
    Images = sCharImageList1
    OnClick = sSpeedButton3Click
  end
  object sMemo1: TsMemo
    Left = 8
    Top = 65
    Width = 230
    Height = 146
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Made by twobit'
      ''
      'Server: Delphi'
      'Client: Delphi'
      ''
      'Credits to CodePulze for his AntiDebug '
      'methods etc!'
      ''
      'Made with <3 by twobit in delphi')
    ReadOnly = True
    TabOrder = 0
    Text = 
      'Made by twobit'#13#10#13#10'Server: Delphi'#13#10'Client: Delphi'#13#10#13#10'Credits to C' +
      'odePulze for his AntiDebug methods etc!'#13#10#13#10'Made with <3 by twobi' +
      't in delphi'#13#10
  end
  object sCharImageList1: TsCharImageList
    EmbeddedFonts = <
      item
        FontName = 'FontAwesome'
        FontData = {}
      end>
    Items = <
      item
        Char = 61586
      end
      item
        Char = 61798
      end
      item
        Char = 61912
      end>
    Left = 200
    Top = 56
    Bitmap = {}
  end
end
