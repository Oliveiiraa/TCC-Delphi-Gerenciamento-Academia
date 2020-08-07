unit U_Cadastrar_Despesas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Mask, StdCtrls, Clipbrd, dblookup, pngimage, ExtCtrls;

type
  Tfrm_cadasdespesas = class(TForm)
    lbl_datadespesa: TLabel;
    lbl_despesa: TLabel;
    lbl_valor: TLabel;
    edt_dsc: TEdit;
    btn_salvar: TButton;
    MaskEditdatapag: TMaskEdit;
    ADOConnectionCadasMensali: TADOConnection;
    ADOStoredProcCadasDespesas: TADOStoredProc;
    lbl_func: TLabel;
    ADOQueryCadasDespesas: TADOQuery;
    DataSourceCadasDespesas: TDataSource;
    ComboBoxCadasDespesas: TComboBox;
    Image1: TImage;
    Image6: TImage;
    Image3: TImage;
    Image2: TImage;
    ADOQueryCadasDespesasCOD_FUNC: TAutoIncField;
    ADOQueryCadasDespesasNM_FUNC: TStringField;
    ADOQueryCadasDespesasEND_FUNC: TStringField;
    ADOQueryCadasDespesasCPF_FUNC: TStringField;
    ADOQueryCadasDespesasRG_FUNC: TStringField;
    ADOQueryCadasDespesasTEL_FUNC: TStringField;
    ADOQueryCadasDespesasDTNASC_FUNC: TWideStringField;
    ADOQueryCadasDespesasEML_FUNC: TStringField;
    ADOQueryCadasDespesasSX_FUNC: TStringField;
    ADOQueryCadasDespesasSTA_FUNC: TBooleanField;
    ADOQueryCadasDespesasFT_FUNC: TStringField;
    ADOQueryCadasDespesasCOD_USU: TIntegerField;
    edt_valor: TEdit;
    edt_usu: TEdit;
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure ComboBoxCadasDespesasKeyPress(Sender: TObject; var Key: Char);
    procedure edt_valorChange(Sender: TObject);
    procedure edt_valorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadasdespesas: Tfrm_cadasdespesas;

implementation

uses U_Consultar_Despesas, U_Login_Sistema;

{$R *.dfm}

procedure Tfrm_cadasdespesas.btn_limparClick(Sender: TObject);
begin
  edt_dsc.Clear;
  edt_valor.Clear;
  MaskEditdatapag.Clear;
end;

procedure Tfrm_cadasdespesas.btn_salvarClick(Sender: TObject);
var
ano, mes, dia : string;
begin
  if edt_dsc.Text = EmptyStr then
  begin
    MessageDlg('Digite a despesa!',mtInformation,[mbOK],0);
  end

  else if MaskEditdatapag.Text = EmptyStr then
  begin
    MessageDlg('Digite a data!',mtInformation,[mbOK],0);
  end

  else if edt_valor.Text = EmptyStr then
  begin
    MessageDlg('Digite o valor!',mtInformation,[mbOK],0);
  end;

  try
  begin
    ADOStoredProcCadasDespesas.Parameters[1].Value := edt_dsc.Text;
    ano := Copy(MaskEditdatapag.Text,7,4);
    mes := Copy(MaskEditdatapag.Text,4,2);
    dia := Copy(MaskEditdatapag.Text,1,2);
    ADOStoredProcCadasDespesas.Parameters[2].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProcCadasDespesas.Parameters[3].Value := edt_valor.Text;
    ADOStoredProcCadasDespesas.Parameters[4].Value := ComboBoxCadasDespesas.Text;
    ADOStoredProcCadasDespesas.Parameters[5].Value := edt_usu.Text;

    ADOStoredProcCadasDespesas.ExecProc;

    MessageDlg('Despesa cadastrada com sucesso!',mtInformation,[mbOK],0);

    frm_cadasdespesas.Close;

    frm_consultadespesas.ADOQueryConsultaDespesas.Close;
    frm_consultadespesas.ADOQueryConsultaDespesas.Open;
    frm_consultadespesas.ADOQueryConsultaDespesas.Refresh;

    //U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Close;
    //U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Open;
    //U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Last;

    edt_dsc.Clear;
    edt_valor.Clear;
    MaskEditdatapag.Clear;
    ComboBoxCadasDespesas.ItemIndex := -1;
  end;

  finally

  end;
end;

procedure Tfrm_cadasdespesas.ComboBoxCadasDespesasKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_cadasdespesas.edt_valorChange(Sender: TObject);
var
  s : string;
  v : double;
  I : integer;
begin
  //1� Passo : se o edit estiver vazio, nada pode ser feito.
    If (edt_valor.Text = emptystr) then
      Begin
        edt_valor.Text := '0,00';
        Exit;
      End;
    //2� Passo : obter o texto do edit, SEM a virgula e SEM o ponto decimal:
    s := '';
    for I := 1 to length(edt_valor.Text) do
        if (edt_valor.text[I] in ['0'..'9']) then
            s := s + edt_valor.text[I];

            //3� Passo : fazer com que o conte�do do edit apresente 2 casas decimais:
            v := strtofloat(s);
            v := (v /100); // para criar 2 casa decimais

            //4� Passo : Formata o valor de (V) para aceitar valores do tipo 0,10.
            edt_valor.text := FormatFloat('#####0.00',v);
            edt_valor.SelStart := Length(edt_valor.text) ;
end;

procedure Tfrm_cadasdespesas.edt_valorClick(Sender: TObject);
begin
  edt_valor.SelStart := Length(edt_valor.text);
end;

procedure Tfrm_cadasdespesas.FormShow(Sender: TObject);
begin
  //ja pensou em fazer um loop
  {while not ADOQueryCadasDespesas.eof do
  begin
  ComboBoxCadasDespesas.items.add(ADOQueryCadasDespesasNM_FUNC.Value);
  ADOQueryCadasDespesas.next;
  end}

  With ADOQueryCadasDespesas do
  begin
       if not IsEmpty then
        begin
             While not Eof do
              begin
                    ComboBoxCadasDespesas.Items.Add(FieldByName('NM_FUNC').AsString);
                   Next;
              end;
        end;
  end;

  edt_usu.Text := U_Login_Sistema.frm_loginsistema.ADOQueryLoginCOD_USU.AsString;

end;

procedure Tfrm_cadasdespesas.Image3Click(Sender: TObject);
var
ano, mes, dia,a,b,c : string;
begin
  if edt_dsc.Text = EmptyStr then
  begin
    MessageDlg('Digite a despesa!',mtInformation,[mbOK],0);
    edt_dsc.SetFocus;
    Exit;
  end

  else if MaskEditdatapag.Text = '  /  /    ' then
  begin
    MessageDlg('Digite a data!',mtInformation,[mbOK],0);
    MaskEditdatapag.SetFocus;
    Exit;
  end;

  a := copy(MaskEditdatapag.Text,1,2);
  b := copy(MaskEditdatapag.Text,4,2);
  c := copy(MaskEditdatapag.Text,7,4);

  if  a >= '32' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditdatapag.SetFocus;
    Exit;
  end

  else if b >= '13' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditdatapag.SetFocus;
    Exit;
  end

  else if edt_valor.Text = EmptyStr then
  begin
    MessageDlg('Digite o valor!',mtInformation,[mbOK],0);
    edt_valor.SetFocus;
    Exit;
  end

  else if ComboBoxCadasDespesas.Text = EmptyStr then
  begin
    MessageDlg('Selecione o funcion�rio!',mtInformation,[mbOK],0);
  end;

  try
  begin
    ADOStoredProcCadasDespesas.Parameters[1].Value := edt_dsc.Text;
    ano := Copy(MaskEditdatapag.Text,7,4);
    mes := Copy(MaskEditdatapag.Text,4,2);
    dia := Copy(MaskEditdatapag.Text,1,2);
    ADOStoredProcCadasDespesas.Parameters[2].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProcCadasDespesas.Parameters[3].Value := edt_valor.Text;
    ADOStoredProcCadasDespesas.Parameters[4].Value := ComboBoxCadasDespesas.Text;
    ADOStoredProcCadasDespesas.Parameters[5].Value := edt_usu.Text;

    ADOStoredProcCadasDespesas.ExecProc;

    MessageDlg('Despesa cadastrada com sucesso!',mtInformation,[mbOK],0);

    frm_cadasdespesas.Close;

    frm_consultadespesas.ADOQueryConsultaDespesas.Close;
    frm_consultadespesas.ADOQueryConsultaDespesas.Open;
    frm_consultadespesas.ADOQueryConsultaDespesas.Refresh;

    //U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Close;
    //U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Open;
    //U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Last;

    edt_dsc.Clear;
    edt_valor.Clear;
    MaskEditdatapag.Clear;
    ComboBoxCadasDespesas.ItemIndex := -1;
    edt_usu.Clear;
    Close;
  end;

  finally

  end;
end;

procedure Tfrm_cadasdespesas.Image6Click(Sender: TObject);
begin
 edt_dsc.Clear;
  edt_valor.Clear;
  MaskEditdatapag.Clear;
  ComboBoxCadasDespesas.ItemIndex := -1;
 close;
end;

end.
