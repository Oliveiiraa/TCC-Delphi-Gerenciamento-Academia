unit U_Esqueceu_Senha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls;

type
  Tfrm_esqueceusuasenha = class(TForm)
    edt_frase: TEdit;
    lbl_frase: TLabel;
    btn_esq: TButton;
    MemoSenha: TMemo;
    ADOQueryEsqueceuSenha: TADOQuery;
    ADOConnectionEsqueceuSenha: TADOConnection;
    ADOQueryEsqueceuSenhaCOD_USU: TAutoIncField;
    ADOQueryEsqueceuSenhaLG_USU: TStringField;
    ADOQueryEsqueceuSenhaSN_USU: TStringField;
    ADOQueryEsqueceuSenhaTP_USU: TBooleanField;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure btn_esqClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_esqueceusuasenha: Tfrm_esqueceusuasenha;

implementation

{$R *.dfm}

procedure Tfrm_esqueceusuasenha.btn_esqClick(Sender: TObject);
begin
  if edt_frase.Text = 'Suco de Laranja' then
  begin
    MemoSenha.Lines.SaveToFile('C:\Sistema Bio Ritmo\Esqueceu sua Senha\Senhas.txt');
  end
  else
  begin
    MessageDlg('Senha Incorreta!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_esqueceusuasenha.FormShow(Sender: TObject);
begin
  ADOQueryEsqueceuSenha.Close;
  ADOQueryEsqueceuSenha.Open;
  ADOQueryEsqueceuSenha.Refresh;


end;

end.
