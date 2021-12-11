object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'DeepStack DEMO'
  ClientHeight = 589
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 889
    Height = 570
    Align = alClient
    AutoSize = True
    Center = True
    Proportional = True
    Stretch = True
    ExplicitTop = -6
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 570
    Width = 889
    Height = 19
    Panels = <
      item
        Text = 'Copy an Image to the Clipboard'
        Width = 50
      end>
  end
end
