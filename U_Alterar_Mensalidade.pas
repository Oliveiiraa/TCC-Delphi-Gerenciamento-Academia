unit U_Alterar_Mensalidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Mask, StdCtrls, pngimage,ComObj, ExtCtrls;

type
  Tfrm_alterarmensa = class(TForm)
    lbl_datavenc: TLabel;
    lbl_nmcli: TLabel;
    lbl_valor: TLabel;
    Label1: TLabel;
    btn_cadasmensa: TButton;
    edt_nmcli: TEdit;
    edt_codcli: TEdit;
    MaskEditDataVenc: TMaskEdit;
    MaskEditDataPag: TMaskEdit;
    ADOConnectionAlterMensa: TADOConnection;
    ADOStoredProcAlterMensa: TADOStoredProc;
    ADOQueryAlterMensa: TADOQuery;
    ADOQueryAlterMensaCOD_CLI: TAutoIncField;
    ADOQueryAlterMensaNM_CLI: TStringField;
    ADOQueryAlterMensaEND_CLI: TStringField;
    ADOQueryAlterMensaCPF_CLI: TStringField;
    ADOQueryAlterMensaRG_CLI: TStringField;
    ADOQueryAlterMensaTEL_CLI: TStringField;
    ADOQueryAlterMensaDTMATRI_CLI: TWideStringField;
    ADOQueryAlterMensaDTNASC_CLI: TWideStringField;
    ADOQueryAlterMensaEML_CLI: TStringField;
    ADOQueryAlterMensaSTA_CLI: TBooleanField;
    ADOQueryAlterMensaSX_CLI: TBooleanField;
    ADOQueryAlterMensaFT_CLI: TStringField;
    ADOQueryAlterMensaCOD_USU: TIntegerField;
    Image1: TImage;
    Image6: TImage;
    Image3: TImage;
    Image2: TImage;
    edt_valor: TEdit;
    procedure Image6Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure edt_valorClick(Sender: TObject);
    procedure edt_valorChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_alterarmensa: Tfrm_alterarmensa;

implementation

uses U_Consultar_Mensalidades, U_Cadastrar_Mensalidades;

{$R *.dfm}

procedure Tfrm_alterarmensa.edt_valorChange(Sender: TObject);
var
  s : string;
  v : double;
  I : integer;
begin
{  //1� Passo : se o edit estiver vazio, nada pode ser feito.
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
            edt_valor.SelStart := Length(edt_valor.text) ;    }
end;

procedure Tfrm_alterarmensa.edt_valorClick(Sender: TObject);
begin
 // edt_valor.SelStart := Length(edt_valor.text);
end;

procedure Tfrm_alterarmensa.FormShow(Sender: TObject);
begin
 MaskEditDataPag.SetFocus;
 // edt_valor.Text := FloatToStr(U_Consultar_Mensalidades.frm_consultmensa.ADOQueryConsultaMensaVL_MSD.AsFloat);
end;

procedure Tfrm_alterarmensa.Image3Click(Sender: TObject);
var
dia2,mes2,ano2,ano1,mes1,dia1,datac1 : string;
  datac,ano3,dia3,mes3,a,b,c,d,e,f,datap, datav : string;
  Arquivo : TStringList;
  WApp: variant; // vari�vel associada ao aplicativo Microsoft Word
    WDoc: variant; // vari�vel associada ao documento criado no Word
    path: string;
     vlr: real;
begin
  if MaskEditDataPag.Text = '  /  /    ' then
  begin
   MessageDlg('Preencha a data de pagamento!',mtInformation,[mbOK],0);
   MaskEditDataPag.SetFocus;
   Exit;
  end;

  d := copy(MaskEditDataPag.Text,1,2);
  e := copy(MaskEditDataPag.Text,4,2);
  f := copy(MaskEditDataPag.Text,7,4);

  if  a >= '32' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditDataPag.SetFocus;
    Exit;
  end

  else if b >= '13' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditDataPag.SetFocus;
    Exit;
  end

  else if MaskEditDataVenc.Text = '  /  /    ' then
  begin
   MessageDlg('Preencha a data de vencimento!',mtInformation,[mbOK],0);
   MaskEditDataVenc.SetFocus;
   Exit;
  end;

  a := copy(MaskEditDataVenc.Text,1,2);
  b := copy(MaskEditDataVenc.Text,4,2);
  c := copy(MaskEditDataVenc.Text,7,4);

  if  a >= '32' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditDataVenc.SetFocus;
    Exit;
  end

  else if b >= '13' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditDataVenc.SetFocus;
    Exit;
  end

  else if edt_valor.Text = EmptyStr then
  begin
    MessageDlg('Preencha o valor da mensalidade!',mtInformation,[mbOK],0);
    edt_valor.SetFocus;
    Exit;
  end;

  datac1 := DateToStr(Date);

   {if datac1 < MaskEditDataPag.Text then
    begin
      MessageDlg('Data inv�lida!',mtInformation,[mbOK],0);
      exit;
    end;}

  datap := MaskEditDataPag.Text;
  datav := MaskEditDataVenc.Text;

 /// if datap > datav  then
  ///begin
    ///MessageDlg('Data inv�lida',mtError,[mbOK],0);
    ///MaskEditDataVenc.SetFocus;
    ///Exit;
  ///end;

    try
    begin
      dia1 := Copy(MaskEditDataPag.Text,1,2);
      mes1 := Copy(MaskEditDataPag.Text,4,2);
      ano1 := Copy(MaskEditDataPag.Text,7,4);
      ADOStoredProcAlterMensa.Parameters[2].Value := ano1 + '/' + mes1 + '/' + dia1;
      dia2 := Copy(MaskEditDataVenc.Text,1,2);
      mes2 := Copy(MaskEditDataVenc.Text,4,2);
      ano2 := Copy(MaskEditDataVenc.Text,7,4);
      ADOStoredProcAlterMensa.Parameters[3].Value := ano2 + '/' + mes2 + '/' + dia2;
      ADOStoredProcAlterMensa.Parameters[4].Value := edt_valor.Text;
      ADOStoredProcAlterMensa.Parameters[1].Value := edt_codcli.Text;

      ADOStoredProcAlterMensa.ExecProc;

      MessageDlg('Novo pagamento efetuado com sucesso!',mtInformation,[mbOK],0);

               if Application.MessageBox('Deseja imprimir o recibo?','Aten��o',MB_ICONQUESTION + MB_YESNO) = IDNO then
    begin
      Close;
      edt_nmcli.Clear;
      MaskEditDataVenc.Clear;
      MaskEditDataPag.Clear;
      edt_valor.Clear;
    end

    else
    begin

    //Arquivo := TStringList.Create();

    //Arquivo.LoadFromFile('C:\Sistema Bio Ritmo\RECIBO DE PAGAMENTO.dotx'); // Carrega o arquivo de origem

    //Arquivo.SaveToFile ('C:\Sistema Bio Ritmo\RECIBO DE PAGAMENTO.dotx'); //salva o arquivo em outro lugar, como o mesmo nome, mas n�o necess�ria precisar ser com o mesmo nome.

    ///CopyFile('C:\Sistema Bio Ritmo\RECIBO DE PAGAMENTO.dotx','C:\Sistema Bio Ritmo\Recibos\RECIBO DE PAGAMENTO' + ' ' +edt_nmcli.Text + ' ' + MaskEditDataPag.Text + '.dotx',True);
      // verifica se o Microsoft Word j� est� aberto
  if (VarIsEmpty(WApp))
  then   MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
     WApp := CreateOleObject('Word.Application');

  path := ExtractFilePath(Application.ExeName);
// cria um documento no Word a partir do modelo do recibo
  WDoc := WApp.Documents.Open('C:\Sistema Bio Ritmo\RECIBO DE PAGAMENTO.dotx');
  WApp.Visible := True;

  try
    vlr := StrToFloat(edt_valor.Text);
// move os componentes de entrada da aplicacao Delphi
// para os campos de texto do recibo no Microsoft Word
    WDoc.FormFields.Item('Texto1').Result := edt_nmcli.Text;
    ///WDoc.FormFields.Item('Pagador').Result := edPagador.Text;
    WDoc.FormFields.Item('Texto2').Result := MaskEditDataPag.Text;
    WDoc.FormFields.Item('Texto3').Result := MaskEditDataVenc.Text;
    WDoc.FormFields.Item('Texto4').Result := Format('%m', [vlr]);
    WDoc.FormFields.Item('Texto5').Result := edt_nmcli.Text;
    ///WDoc.FormFields.Item('Pagador').Result := edPagador.Text;
    WDoc.FormFields.Item('Texto6').Result := MaskEditDataPag.Text;
    WDoc.FormFields.Item('Texto7').Result := MaskEditDataVenc.Text;
    WDoc.FormFields.Item('Texto8').Result := Format('%m', [vlr]);
    CLOSE;
    edt_nmcli.Clear;
    MaskEditDataVenc.Clear;
    edt_valor.clear;
    MaskEditDataPag.Clear;
  finally

  end;
    ///WDoc.FormFields.Item('Extenso').Result := valorPorExtenso(vlr);
    ///WDoc.FormFields.Item('Referente').Result := edReferente.Text;
    ///WDoc.FormFields.Item('Local').Result := edLocal.Text;
    ///WDoc.FormFields.Item('Assina').Result := edAssina.Text;
    end;

    ////frm_alterarmensa.Close;
    U_Consultar_Mensalidades.frm_consultmensa.ADOQueryConsultaMensa.Close;
    U_Consultar_Mensalidades.frm_consultmensa.ADOQueryConsultaMensa.Open;
    U_Consultar_Mensalidades.frm_consultmensa.ADOQueryConsultaMensa.Refresh;
    U_Consultar_Mensalidades.frm_consultmensa.DBGridConsultaMensa.Refresh;

    //U_Consultar_Mensalidades.frm_consultmensa.DBGridConsultaMensaDrawColumnCell;
    end
  finally

  end;
end;

procedure Tfrm_alterarmensa.Image6Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente sair? Nenhum pagamento ser� realizado!','Aten��o',MB_ICONQUESTION + MB_YESNO) = IDNO then
 begin

 end

 else
 begin
   frm_alterarmensa.Close;
 end;
end;

end.
