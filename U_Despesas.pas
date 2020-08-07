unit U_Despesas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  Tfrm_despesas = class(TForm)
    Image1: TImage;
    Image6: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure btn_cadastrardespesasClick(Sender: TObject);
    procedure btn_consultardespesasClick(Sender: TObject);
    procedure btn_cancelardespesasClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_despesas: Tfrm_despesas;

implementation

uses U_Cadastrar_Despesas, U_Consultar_Despesas, U_Login_Sistema;

{$R *.dfm}

procedure Tfrm_despesas.btn_cadastrardespesasClick(Sender: TObject);
begin
  frm_cadasdespesas.ShowModal;
end;

procedure Tfrm_despesas.btn_cancelardespesasClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_despesas.btn_consultardespesasClick(Sender: TObject);
begin
  U_Consultar_Despesas.frm_consultadespesas.ADOQueryConsultaDespesas.Close;
  U_Consultar_Despesas.frm_consultadespesas.ADOQueryConsultaDespesas.Open;
  U_Consultar_Despesas.frm_consultadespesas.ADOQueryConsultaDespesas.Refresh;
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultadespesas.ShowModal;
  end
  else
  begin
    MessageDlg('Você não tem permissão para consultar despesas!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_despesas.Image2Click(Sender: TObject);
begin
 frm_cadasdespesas.ShowModal;
end;

procedure Tfrm_despesas.Image3Click(Sender: TObject);
begin
  U_Consultar_Despesas.frm_consultadespesas.ADOQueryConsultaDespesas.Close;
  U_Consultar_Despesas.frm_consultadespesas.ADOQueryConsultaDespesas.Open;
  U_Consultar_Despesas.frm_consultadespesas.ADOQueryConsultaDespesas.Refresh;
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultadespesas.ShowModal;
  end
  else
  begin
    MessageDlg('Você não tem permissão para consultar despesas!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_despesas.Image6Click(Sender: TObject);
begin
 close;
end;

end.
