unit U_Cadastrar_Medidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Mask, StdCtrls, pngimage, ExtCtrls;

type
  Tfrm_cadasmedidas = class(TForm)
    lbl_nomeclimedidas: TLabel;
    lbl_dataavaliacaofisica: TLabel;
    lbl_peso: TLabel;
    lbl_altura: TLabel;
    lbl_biceps: TLabel;
    lbl_triceps: TLabel;
    lbl_peitoral: TLabel;
    lbl_quadril: TLabel;
    lbl_cintura: TLabel;
    lbl_coxa: TLabel;
    lbl_ombro: TLabel;
    lbl_panturrilha: TLabel;
    Image1: TImage;
    edt_nomeclimedidas: TEdit;
    edt_peso: TEdit;
    edt_altura: TEdit;
    edt_biceps: TEdit;
    edt_triceps: TEdit;
    edt_peitoral: TEdit;
    edt_quadril: TEdit;
    edt_cintura: TEdit;
    edt_coxa: TEdit;
    edt_ombro: TEdit;
    edt_panturrilha: TEdit;
    MaskEditdataavaliacao: TMaskEdit;
    Editcodigo: TEdit;
    ADOStoredProcMedidas: TADOStoredProc;
    ADOConnectionMedidas: TADOConnection;
    Image2: TImage;
    Image3: TImage;
    Image6: TImage;
    procedure bnt_cancelarmedidasClick(Sender: TObject);
    procedure bnt_salvarmedidasClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_pesoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadasmedidas: Tfrm_cadasmedidas;

implementation

uses U_Cadastrar_Cliente, U_Cadastrar_Mensalidades;

{$R *.dfm}

procedure Tfrm_cadasmedidas.bnt_cancelarmedidasClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_cadasmedidas.bnt_salvarmedidasClick(Sender: TObject);
var
  ano,mes,dia,ano2,mes2,dia2 : string;
begin
  try
    dia := Copy(MaskEditdataavaliacao.Text,1,2);
    mes := Copy(MaskEditdataavaliacao.Text,4,2);
    ano := Copy(MaskEditdataavaliacao.Text,7,4);
    ADOStoredProcMedidas.Parameters[1].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProcMedidas.Parameters[2].Value := edt_peso.Text;
    ADOStoredProcMedidas.Parameters[3].Value := edt_altura.text;
    ADOStoredProcMedidas.Parameters[4].Value := edt_biceps.Text;
    ADOStoredProcMedidas.Parameters[5].Value := edt_triceps.Text;
    ADOStoredProcMedidas.Parameters[6].Value := edt_peitoral.Text;
    ADOStoredProcMedidas.Parameters[7].Value := edt_quadril.Text;
    ADOStoredProcMedidas.Parameters[8].Value := edt_cintura.Text;
    ADOStoredProcMedidas.Parameters[9].Value := edt_coxa.Text;
    ADOStoredProcMedidas.Parameters[10].Value := edt_ombro.Text;
    ADOStoredProcMedidas.Parameters[11].Value := edt_panturrilha.Text;
    ADOStoredProcMedidas.Parameters[12].Value := Editcodigo.Text;

    ADOStoredProcMedidas.ExecProc;

    MessageDlg('Medidas cadastradas com sucesso!',mtInformation,[mbOk],0);

    edt_nomeclimedidas.Clear;
    MaskEditdataavaliacao.Clear;
    edt_peso.Clear;
    edt_altura.Clear;
    edt_biceps.Clear;
    edt_triceps.Clear;
    edt_peitoral.Clear;
    edt_quadril.Clear;
    edt_cintura.Clear;
    edt_coxa.Clear;
    edt_ombro.Clear;
    edt_panturrilha.Clear;

    frm_cadasmensalidades.ShowModal;

    frm_cadasmedidas.Close;

  finally

  end;
end;

procedure Tfrm_cadasmedidas.edt_pesoKeyPress(Sender: TObject; var Key: Char);
begin
  if key in ['0'..'9',',',#8] then
  begin
     key := key;

  end
  else
  begin
    key := #0;
  end;
end;

procedure Tfrm_cadasmedidas.FormShow(Sender: TObject);
begin
  edt_nomeclimedidas.Text := U_Cadastrar_Cliente.frm_cadastrarcli.edt_nomecli.Text;
  Editcodigo.Text := U_Cadastrar_Cliente.frm_cadastrarcli.ADOQueryCadascliCOD_CLI.AsString;
end;

procedure Tfrm_cadasmedidas.Image3Click(Sender: TObject);
var
  ano,mes,dia,ano2,mes2,dia2,a,b,c : string;
begin
  if edt_peso.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida do peso!',mtInformation,[mbOK],0);
    edt_peso.SetFocus;
    Exit;
  end

  else if edt_altura.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida da altura!',mtInformation,[mbOK],0);
    edt_altura.SetFocus;
    Exit;
  end

  else if edt_biceps.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida do b�ceps!',mtInformation,[mbOK],0);
    edt_biceps.SetFocus;
    Exit;
  end

  else if edt_triceps.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida do tr�ceps!',mtInformation,[mbOK],0);
    edt_triceps.SetFocus;
    Exit;
  end

  else if edt_peitoral.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida do peitoral!',mtInformation,[mbOK],0);
    edt_peitoral.SetFocus;
    Exit;
  end

  else if edt_quadril.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida do quadril!',mtInformation,[mbOK],0);
    edt_quadril.SetFocus;
    Exit;
  end

  else if edt_cintura.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida da cintura!',mtInformation,[mbOK],0);
    edt_cintura.SetFocus;
    Exit;
  end

  else if edt_coxa.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida da coxa!',mtInformation,[mbOK],0);
    edt_coxa.SetFocus;
    Exit;
  end

  else if edt_ombro.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida do ombro!',mtInformation,[mbOK],0);
    edt_ombro.SetFocus;
    Exit;
  end

  else if edt_panturrilha.Text = EmptyStr then
  begin
    MessageDlg('Informe a medida da panturrilha!',mtInformation,[mbOK],0);
    edt_panturrilha.SetFocus;
    Exit;
  end

  else if MaskEditdataavaliacao.Text = '  /  /    ' then
  begin
    MessageDlg('Informe a data da avalia��o!',mtInformation,[mbOK],0);
    MaskEditdataavaliacao.SetFocus;
    Exit;
  end;

  a := copy(MaskEditdataavaliacao.Text,1,2);
  b := copy(MaskEditdataavaliacao.Text,4,2);
  c := copy(MaskEditdataavaliacao.Text,7,4);

  if  a >= '32' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditdataavaliacao.SetFocus;
    Exit;
  end

  else if b >= '13' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditdataavaliacao.SetFocus;
    Exit;
  end;

  try
    dia := Copy(MaskEditdataavaliacao.Text,1,2);
    mes := Copy(MaskEditdataavaliacao.Text,4,2);
    ano := Copy(MaskEditdataavaliacao.Text,7,4);
    ADOStoredProcMedidas.Parameters[1].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProcMedidas.Parameters[2].Value := edt_peso.Text;
    ADOStoredProcMedidas.Parameters[3].Value := edt_altura.text;
    ADOStoredProcMedidas.Parameters[4].Value := edt_biceps.Text;
    ADOStoredProcMedidas.Parameters[5].Value := edt_triceps.Text;
    ADOStoredProcMedidas.Parameters[6].Value := edt_peitoral.Text;
    ADOStoredProcMedidas.Parameters[7].Value := edt_quadril.Text;
    ADOStoredProcMedidas.Parameters[8].Value := edt_cintura.Text;
    ADOStoredProcMedidas.Parameters[9].Value := edt_coxa.Text;
    ADOStoredProcMedidas.Parameters[10].Value := edt_ombro.Text;
    ADOStoredProcMedidas.Parameters[11].Value := edt_panturrilha.Text;
    ADOStoredProcMedidas.Parameters[12].Value := Editcodigo.Text;

    ADOStoredProcMedidas.ExecProc;

    MessageDlg('Medidas cadastradas com sucesso!',mtInformation,[mbOk],0);

    frm_cadasmedidas.Close;

    edt_nomeclimedidas.Clear;
    MaskEditdataavaliacao.Clear;
    edt_peso.Clear;
    edt_altura.Clear;
    edt_biceps.Clear;
    edt_triceps.Clear;
    edt_peitoral.Clear;
    edt_quadril.Clear;
    edt_cintura.Clear;
    edt_coxa.Clear;
    edt_ombro.Clear;
    edt_panturrilha.Clear;

    frm_cadasmensalidades.ShowModal;


  finally

  end;
end;

procedure Tfrm_cadasmedidas.Image6Click(Sender: TObject);
begin
  Close;
  frm_cadasmensalidades.ShowModal;
end;

end.
