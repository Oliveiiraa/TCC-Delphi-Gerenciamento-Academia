unit U_Consultar_Mensalidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Clipbrd, Menus,DateUtils,
  pngimage, ExtCtrls;

type
  Tfrm_consultmensa = class(TForm)
    ADOQueryConsultaMensa: TADOQuery;
    DBGridConsultaMensa: TDBGrid;
    DataSourceConsultaMensa: TDataSource;
    ADOConnectionConsultaMensa: TADOConnection;
    Edit1: TEdit;
    edt_buscacli: TEdit;
    ComboBoxConsultacli: TComboBox;
    ADOStoredProcAlterarSit: TADOStoredProc;
    ADOStoredProcAdicionarMensa: TADOStoredProc;
    PopupMenuPagar: TPopupMenu;
    Pagar1: TMenuItem;
    Image1: TImage;
    Image6: TImage;
    Image3: TImage;
    Button1: TButton;
    ADOQuery1: TADOQuery;
    ADOQuery1COD_CLI: TAutoIncField;
    ADOQuery1NM_CLI: TStringField;
    ADOQuery1END_CLI: TStringField;
    ADOQuery1CPF_CLI: TStringField;
    ADOQuery1RG_CLI: TStringField;
    ADOQuery1TEL_CLI: TStringField;
    ADOQuery1DTMATRI_CLI: TWideStringField;
    ADOQuery1DTNASC_CLI: TWideStringField;
    ADOQuery1EML_CLI: TStringField;
    ADOQuery1STA_CLI: TBooleanField;
    ADOQuery1SX_CLI: TStringField;
    ADOQuery1FT_CLI: TStringField;
    ADOQuery1TPT_CLI: TStringField;
    ADOQuery1COD_USU: TIntegerField;
    ADOQueryConsultaMensaCOD_CLI: TAutoIncField;
    ADOQueryConsultaMensaNM_CLI: TStringField;
    ADOQueryConsultaMensaEND_CLI: TStringField;
    ADOQueryConsultaMensaCPF_CLI: TStringField;
    ADOQueryConsultaMensaRG_CLI: TStringField;
    ADOQueryConsultaMensaTEL_CLI: TStringField;
    ADOQueryConsultaMensaDTMATRI_CLI: TWideStringField;
    ADOQueryConsultaMensaDTNASC_CLI: TWideStringField;
    ADOQueryConsultaMensaEML_CLI: TStringField;
    ADOQueryConsultaMensaSTA_CLI: TBooleanField;
    ADOQueryConsultaMensaSX_CLI: TStringField;
    ADOQueryConsultaMensaFT_CLI: TStringField;
    ADOQueryConsultaMensaTPT_CLI: TStringField;
    ADOQueryConsultaMensaCOD_USU: TIntegerField;
    ADOQueryConsultaMensaCOD_MSD: TAutoIncField;
    ADOQueryConsultaMensaDTPAG_MSD: TWideStringField;
    ADOQueryConsultaMensaDTVENC_MSD: TWideStringField;
    ADOQueryConsultaMensaVL_MSD: TBCDField;
    ADOQueryConsultaMensaCOD_CLI_1: TIntegerField;
    image_visu: TImage;
    procedure DBGridConsultaMensaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btn_buscarconsulcliClick(Sender: TObject);
    procedure ADOQueryConsultaMensaSIT_MSDGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure btn_efetuarpagClick(Sender: TObject);
    procedure Pagar1Click(Sender: TObject);
    procedure bnt_consultamensaClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure image_visuClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure edt_buscacliChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultmensa: Tfrm_consultmensa;

implementation

uses U_Cadastrar_Mensalidades, U_Alterar_Mensalidade, U_Visualizar_Cliente;

{$R *.dfm}

procedure Tfrm_consultmensa.ADOQueryConsultaMensaSIT_MSDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if SENDER.AsString = 'False' then
    text := 'N�o Pago'
  else
    Text := 'Pago'
end;

procedure Tfrm_consultmensa.btn_efetuarpagClick(Sender: TObject);
var
ano1, mes1, dia1,ano2, mes2, dia2 : string;
begin

    U_Alterar_Mensalidade.frm_alterarmensa.edt_nmcli.Text := ADOQueryConsultaMensaNM_CLI.AsString;
    U_Alterar_Mensalidade.frm_alterarmensa.edt_codcli.Text := ADOQueryConsultaMensaCOD_MSD.AsString;
    U_Alterar_Mensalidade.frm_alterarmensa.edt_valor.Text := ADOQueryConsultaMensaVL_MSD.AsString;
    ano1 := copy(ADOQueryConsultaMensaDTPAG_MSD.AsString,1,4);
    mes1 := copy(ADOQueryConsultaMensaDTPAG_MSD.AsString,6,2);
    dia1 := copy(ADOQueryConsultaMensaDTPAG_MSD.AsString,9,2);
    U_Alterar_Mensalidade.frm_alterarmensa.MaskEditDataPag.Text := dia1 + '/' + mes1 + '/' + ano1;
    ano2 := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,1,4);
    mes2 := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,6,2);
    dia2 := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,9,2);
    U_Alterar_Mensalidade.frm_alterarmensa.MaskEditDataVenc.Text := dia2 + '/' + mes2 + '/' + ano2;

    frm_alterarmensa.ShowModal;

    {if ADOQueryConsultaMensaDTVENC_MSD.AsString < Edit1.Text then
    begin
    ADOStoredProcAlterarSit.Parameters[1].Value := ADOQueryConsultaMensaCOD_MSD.AsString;
    ADOStoredProcAlterarSit.Parameters[2].Value := 1;
    dia1 := Copy(Edit1.Text,1,2);
    mes1 := Copy(Edit1.Text,4,2);
    ano1 := Copy(Edit1.Text,7,4);
    ADOStoredProcAlterarSit.Parameters[3].Value := ano1 + '/' + mes1 + '/' + dia1;

    ADOStoredProcAlterarSit.ExecProc;

    frm_cadasmensalidades.ShowModal;

    //datacompleto := ADOQueryConsultaMensaDTVENC_MSD.AsString;
    //dia := COPY(datacompleto,9,2);
    //mes := COPY(datacompleto,6,2);
    //ano := COPY(datacompleto,1,4);
    frm_cadasmensalidades.MaskEditDataVenc.Text :=  ADOQueryConsultaMensaDTVENC_MSD.AsString;   }

    //ADOStoredProcAdicionarMensa.Parameters[1].Value := '';
 // end;

    ///for i := 0 to ADOQueryConsultaMensaSIT_MSD.AsBoolean := 'False' do
   // with ADOQueryConsultaMensa do
   // begin
    //Active := False;
    //Close;
    //SQL.Clear;
    //SQL.Add('SELECT DATEADD(MONTH,1,DTMATRI_CLI) FROM TB_CLIENTES WHERE COD_CLI = ' + ADOQueryConsultaMensaCOD_CLI.AsString);
    //Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    //Open;
    //Active := True;
    //end;

    //a := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,6,2);
   // a := IntToStr( a + 1);
    //if a > 12 then
    //begin
      //b := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,1,4);
      //b := b + 1;
      //a := 1;
    //end
    //else if a = 2 then
    //begin
      //c := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,9,2);

    //end ;
    //ADOStoredProcAdicionarMensa.Parameters[2].Value := ADOQueryConsultaMensaDTVENC_MSD.AsString;
    //ADOStoredProcAdicionarMensa.Parameters[2].Value := b + '/' + a + '/' + c;
   //ADOStoredProcAdicionarMensa.Parameters[3].Value := ADOQueryConsultaMensaVL_MSD.AsString;
   // ADOStoredProcAdicionarMensa.Parameters[4].Value := 0;
   // ADOStoredProcAdicionarMensa.Parameters[5].Value := ADOQueryConsultaMensaCOD_CLI.AsString;
   //ADOStoredProcAdicionarMensa.ExecProc;

   // ADOQueryConsultaMensa.Close;
   // ADOQueryConsultaMensa.Open;
   // ADOQueryConsultaMensa.Refresh;
    //DBGridConsultaMensa.Refresh;

   // end;
   // end;
    //else
    //begin
    //ADOStoredProcAdicionarMensa.Parameters[1].Value := '';

    //with ADOQueryConsultaMensa do
    //begin
    //Active := False;
    //Close;
    //SQL.Clear;
    //SQL.Add('SELECT DATEADD(MONTH,1,DTMATRI_CLI) FROM TB_CLIENTES WHERE COD_CLI = ' + ADOQueryConsultaMensaCOD_CLI.AsString);
    //Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    //Open;
    //Active := True;
    //end;
    //ADOStoredProcAdicionarMensa.Parameters[2].Value := ADOQueryConsultaMensaDTVENC_MSD.AsString;
    //ADOStoredProcAdicionarMensa.Parameters[3].Value := ADOQueryConsultaMensaVL_MSD.AsString;
    //ADOStoredProcAdicionarMensa.Parameters[4].Value := 0;
    //ADOStoredProcAdicionarMensa.Parameters[5].Value := ADOQueryConsultaMensaCOD_CLI.AsString;
    //ADOStoredProcAdicionarMensa.ExecProc;

    //ADOQueryConsultaMensa.Close;
    //ADOQueryConsultaMensa.Open;
    //ADOQueryConsultaMensa.Refresh;
    //DBGridConsultaMensa.Refresh;
  //end;

end;

procedure Tfrm_consultmensa.bnt_consultamensaClick(Sender: TObject);
begin
 close;
end;

procedure Tfrm_consultmensa.btn_buscarconsulcliClick(Sender: TObject);
begin

  if ADOQueryConsultaMensa.RecordCount < 1 then
  begin
    MessageDlg('Nenhum registro encontrado!',mtError,[mbOK],3);
  end;
end;

procedure Tfrm_consultmensa.DBGridConsultaMensaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
  datac,ano1,dia1,mes1,data : string;
begin
      dia1 := copy(Edit1.Text,1,2);
      mes1 := copy(Edit1.Text,4,2);
      ano1 := copy(Edit1.Text,7,4);
      datac := ano1 + '-' + mes1 + '-' + dia1;
      data := ADOQueryConsultaMensaDTVENC_MSD.AsString;
if (datac < data) then
 begin
    TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
    //Font.Style := [fsbold];
 end

 else
 begin
     TDBGrid(Sender).Canvas.Brush.Color:= clRed;
     //Font.Color := clRed;
 end;

   TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].field, State);
end;

procedure Tfrm_consultmensa.edt_buscacliChange(Sender: TObject);
begin
  case ComboBoxConsultacli.ItemIndex of
  0: with ADOQueryConsultaMensa do
    begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT*FROM TB_CLIENTES,TB_MENSALIDADES ');
    sql.Add('WHERE TB_MENSALIDADES.COD_CLI = TB_CLIENTES.COD_CLI and STA_CLI = 0 AND COD_MSD LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    Open;
    Active := True;
    end;
   1:with ADOQueryConsultaMensa do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT*FROM TB_CLIENTES,TB_MENSALIDADES ');
    sql.Add('WHERE TB_MENSALIDADES.COD_CLI = TB_CLIENTES.COD_CLI and STA_CLI = 0 AND NM_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    Open;
    Active := True;
    end;
  end;
end;



procedure Tfrm_consultmensa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  //edt_buscacli.Clear;
  DBGridConsultaMensa.Refresh;
  //ComboBoxConsultacli.ItemIndex := -1;
end;

procedure Tfrm_consultmensa.FormShow(Sender: TObject);
begin
  Edit1.text := datetostr(Date);
  ADOQueryConsultaMensa.Close;
  ADOQueryConsultaMensa.Open;
  DBGridConsultaMensa.Refresh;
end;

procedure Tfrm_consultmensa.image_visuClick(Sender: TObject);
var
dia,dia2,mes,mes2,ano,ano2,datacompleto,datacompleto2 : string;
begin
   {case ComboBoxConsultacli.ItemIndex of
  0: with ADOQueryConsultaMensa do
    begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT*FROM TB_CLIENTES ');
    sql.Add('WHERE STA_CLI = 0 AND COD_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    Open;
    Active := True;
    end;
   1:with ADOQueryConsultaMensa do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT*FROM TB_CLIENTES,TB_MENSALIDADES ');
    sql.Add('WHERE TB_MENSALIDADES.COD_CLI = TB_CLIENTES.COD_CLI and STA_CLI = 0 AND NM_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    Open;
    Active := True;
    end;
    2:with ADOQueryConsultaMensa do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT*FROM TB_CLIENTES,TB_MENSALIDADES                                           ');
    sql.Add('WHERE TB_MENSALIDADES.COD_CLI = TB_CLIENTES.COD_CLI and STA_CLI = 0 AND DTVENC_MSD LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultaMensa.SQL.Text;
    Open;
    Active := True;
    end;
  end;
  if ADOQueryConsultaMensa.RecordCount < 1 then
  begin
    MessageDlg('Nenhum registro encontrado!',mtError,[mbOK],3);
  end;}
   U_Visualizar_Cliente.frm_visualizarcli.edt_nomecli.Text := ADOQueryConsultaMensaNM_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.edt_enderecocli.Text := ADOQueryConsultaMensaEND_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.MaskEdit1.Text := ADOQueryConsultaMensaCPF_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.MaskEditRG.Text := ADOQueryConsultaMensaRG_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.MaskEdittelefone.Text := ADOQueryConsultaMensaTEL_CLI.AsString;

  datacompleto := ADOQueryConsultaMensaDTMATRI_CLI.AsString;

  dia := COPY(datacompleto,9,2);
  mes := COPY(datacompleto,6,2);
  ano := COPY(datacompleto,1,4);

  U_Visualizar_Cliente.frm_visualizarcli.MaskEditdatamatric.Text := dia + '/' + mes + '/' +ano ;

  datacompleto2 := ADOQueryConsultaMensaDTNASC_CLI.AsString;

  dia2 := COPY(datacompleto2,9,2);
  mes2 := COPY(datacompleto2,6,2);
  ano2 := COPY(datacompleto2,1,4);

  U_Visualizar_Cliente.frm_visualizarcli.MaskEditdatanasc.Text := dia2 + '/' + mes2 + '/' + ano2 ;

  U_Visualizar_Cliente.frm_visualizarcli.edt_emailcli.Text := ADOQueryConsultaMensaEML_CLI.AsString;
  //U_Visualizar_Cliente.frm_visualizarcli.COM.Text := ADOQuery1STA_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.ComboBoxsexocli.Text := ADOQueryConsultaMensaSX_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.edt_foto.Text := ADOQueryConsultaMensaFT_CLI.AsString;
  U_Visualizar_Cliente.frm_visualizarcli.ComboBoxTipoTreino.Text := ADOQueryConsultaMensaTPT_CLI.AsString;

  if ADOQueryConsultaMensaSTA_CLI.AsBoolean = False then
  begin
    U_Visualizar_Cliente.frm_visualizarcli.ComboBoxstatuscli.ItemIndex := 0;
  end

  else
  begin
    U_Visualizar_Cliente.frm_visualizarcli.ComboBoxstatuscli.ItemIndex := 1;
  end;

  frm_visualizarcli.ShowModal;
end;

procedure Tfrm_consultmensa.Image3Click(Sender: TObject);
var
ano1, mes1, dia1,ano2, mes2, dia2 : string;
begin
   U_Alterar_Mensalidade.frm_alterarmensa.edt_nmcli.Text := ADOQueryConsultaMensaNM_CLI.AsString;
    U_Alterar_Mensalidade.frm_alterarmensa.edt_codcli.Text := ADOQueryConsultaMensaCOD_MSD.AsString;
    U_Alterar_Mensalidade.frm_alterarmensa.edt_valor.Text := FloatToStr(ADOQueryConsultaMensaVL_MSD.AsFloat);
    {ano1 := copy(ADOQueryConsultaMensaDTPAG_MSD.AsString,1,4);
    mes1 := copy(ADOQueryConsultaMensaDTPAG_MSD.AsString,6,2);
    dia1 := copy(ADOQueryConsultaMensaDTPAG_MSD.AsString,9,2);
    U_Alterar_Mensalidade.frm_alterarmensa.MaskEditDataPag.Text := dia1 + '/' + mes1 + '/' + ano1;
    ano2 := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,1,4);
    mes2 := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,6,2);
    dia2 := copy(ADOQueryConsultaMensaDTVENC_MSD.AsString,9,2);
    U_Alterar_Mensalidade.frm_alterarmensa.MaskEditDataVenc.Text := dia2 + '/' + mes2 + '/' + ano2;}

    frm_alterarmensa.ShowModal;

end;

procedure Tfrm_consultmensa.Image6Click(Sender: TObject);
begin

 edt_buscacli.Clear;
close;
end;

procedure Tfrm_consultmensa.Pagar1Click(Sender: TObject);
begin
  {if ADOQueryConsultaMensaSIT_MSD.AsString = 'False' then
    begin
    ADOStoredProcAlterarSit.Parameters[1].Value := ADOQueryConsultaMensaCOD_MSD.AsString;
    ADOStoredProcAlterarSit.Parameters[2].Value := 1;
    //dia1 := Copy(Edit1.Text,1,2);
    //mes1 := Copy(Edit1.Text,4,2);
    //ano1 := Copy(Edit1.Text,7,4);
    ADOStoredProcAlterarSit.Parameters[3].Value := Edit1.Text ;

    ADOStoredProcAlterarSit.ExecProc;

    ADOQueryConsultaMensa.Close;
    ADOQueryConsultaMensa.Open;
    ADOQueryConsultaMensa.Refresh;
    DBGridConsultaMensa.Refresh;
    end; }
end;

end.
