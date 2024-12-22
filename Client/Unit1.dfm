object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 79
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMinimized
  StyleElements = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object ClientSource: TncClientSource
    Compression = zcFastest
    Encryption = etRijndael
    EncryptionKey = 'EncryptionKey123'
    OnConnected = ClientSourceConnected
    OnHandleCommand = ClientSourceHandleCommand
    Host = 'LocalHost'
    Left = 32
    Top = 16
  end
end
