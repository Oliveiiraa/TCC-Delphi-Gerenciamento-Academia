object frm_esqueceusuasenha: Tfrm_esqueceusuasenha
  Left = 0
  Top = 0
  Caption = 'Esqueceu sua Senha'
  ClientHeight = 359
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_frase: TLabel
    Left = 16
    Top = 56
    Width = 125
    Height = 13
    Caption = 'Senha para Recupera'#231#227'o:'
  end
  object edt_frase: TEdit
    Left = 152
    Top = 48
    Width = 361
    Height = 21
    TabOrder = 0
  end
  object btn_esq: TButton
    Left = 176
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 1
    OnClick = btn_esqClick
  end
  object MemoSenha: TMemo
    Left = 16
    Top = 200
    Width = 241
    Height = 151
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 368
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 392
    Top = 131
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object ADOQueryEsqueceuSenha: TADOQuery
    Active = True
    Connection = ADOConnectionEsqueceuSenha
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT*FROM TB_USUARIOS')
    Left = 344
    Top = 136
    object ADOQueryEsqueceuSenhaCOD_USU: TAutoIncField
      FieldName = 'COD_USU'
      ReadOnly = True
    end
    object ADOQueryEsqueceuSenhaLG_USU: TStringField
      FieldName = 'LG_USU'
      Size = 30
    end
    object ADOQueryEsqueceuSenhaSN_USU: TStringField
      FieldName = 'SN_USU'
      Size = 15
    end
    object ADOQueryEsqueceuSenhaTP_USU: TBooleanField
      FieldName = 'TP_USU'
    end
  end
  object ADOConnectionEsqueceuSenha: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=TCC;Data Source=(local)'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 344
    Top = 208
  end
end
