object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 345
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object sGroupBox1: TsGroupBox
    Left = 0
    Top = 0
    Width = 284
    Height = 118
    Align = alTop
    Caption = 'Download from'
    TabOrder = 0
    DesignSize = (
      284
      118)
    object sRadioButton1: TsRadioButton
      Left = 3
      Top = 17
      Width = 105
      Height = 19
      Caption = 'Local computer'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object sEdit1: TsEdit
      Left = 10
      Top = 36
      Width = 263
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      TextHint = 'C:\Path'
      OnClick = sEdit1Click
      BoundLabel.Caption = 'C:\Path'
    end
    object sRadioButton2: TsRadioButton
      Left = 3
      Top = 65
      Width = 74
      Height = 19
      Caption = 'From URL'
      TabOrder = 2
    end
    object sEdit2: TsEdit
      Left = 10
      Top = 84
      Width = 263
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      TextHint = 'https://example.com/file.exe'
      BoundLabel.Caption = 'https://example.com/file.exe'
    end
  end
  object sGroupBox2: TsGroupBox
    Left = 0
    Top = 118
    Width = 284
    Height = 51
    Align = alTop
    Caption = 'Execution method'
    TabOrder = 1
    object sRadioButton3: TsRadioButton
      Left = 9
      Top = 21
      Width = 114
      Height = 19
      Caption = 'Download to disk'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
  end
  object sButton1: TsButton
    Left = 0
    Top = 310
    Width = 284
    Height = 35
    Align = alBottom
    Caption = 'Download n'#39' Execute'
    TabOrder = 2
    OnClick = sButton1Click
  end
  object sMemo1: TsMemo
    Left = 0
    Top = 169
    Width = 284
    Height = 141
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    ExplicitTop = 193
    ExplicitHeight = 117
  end
end
