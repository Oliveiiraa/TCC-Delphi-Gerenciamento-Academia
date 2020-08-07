unit U_Consultar_Cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, Clipbrd, pngimage, ExtCtrls;

type
  Tfrm_consultacli = class(TForm)
    DBGridconsultacli: TDBGrid;
    edt_buscacli: TEdit;
    ADOConnectionconsultcli: TADOConnection;
    ADOQueryconsultcli: TADOQuery;
    DataSourceconsultcli: TDataSource;
    ComboBoxConsultacli: TComboBox;
    Image1: TImage;
    Image6: TImage;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    Image7: TImage;
    img_altermedidas: TImage;
    ADOQueryconsultcliCOD_CLI: TAutoIncField;
    ADOQueryconsultcliNM_CLI: TStringField;
    ADOQueryconsultcliEND_CLI: TStringField;
    ADOQueryconsultcliCPF_CLI: TStringField;
    ADOQueryconsultcliRG_CLI: TStringField;
    ADOQueryconsultcliTEL_CLI: TStringField;
    ADOQueryconsultcliDTMATRI_CLI: TWideStringField;
    ADOQueryconsultcliDTNASC_CLI: TWideStringField;
    ADOQueryconsultcliEML_CLI: TStringField;
    ADOQueryconsultcliSTA_CLI: TBooleanField;
    ADOQueryconsultcliSX_CLI: TStringField;
    ADOQueryconsultcliFT_CLI: TStringField;
    ADOQueryconsultcliTPT_CLI: TStringField;
    ADOQueryconsultcliCOD_USU: TIntegerField;
    Image4: TImage;
    procedure btn_buscarconsulcliClick(Sender: TObject);
    procedure btn_cancelarconsulcliClick(Sender: TObject);
    procedure ADOQueryconsultcliSX_CLIGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure ADOQueryconsultcliSTA_CLIGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btn_alterarcliClick(Sender: TObject);
    procedure DBGridconsultacliCellClick(Column: TColumn);
    procedure btn_adcmensaClick(Sender: TObject);
    procedure ADOQueryconsultcliTPT_CLIGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure bnt_cancelarconsutacliClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure edt_buscacliChange(Sender: TObject);
    procedure img_altermedidasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure ComboBoxConsultacliKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DBGridconsultacliDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultacli: Tfrm_consultacli;

implementation

uses U_Cadastrar_Cliente, U_Alterar_Cliente, U_Cadastrar_Mensalidades,
  U_Consultar_Medidas, U_Cadastrar_Medidas, U_Cadastrar_Novas_Medidas;

{$R *.dfm}

procedure Tfrm_consultacli.ADOQueryconsultcliSTA_CLIGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  begin
    if Sender.AsString = 'False' then
       Text := 'Ativo'
    else
       if Sender.AsString = 'True' then
          Text := 'Inativo'
  end;
end;

procedure Tfrm_consultacli.ADOQueryconsultcliSX_CLIGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
   {begin
    if Sender.AsString = 'False' then
       Text := 'Masculino'
    else
       if Sender.AsString = 'True' then
          Text := 'Feminino'
       else
          Text := 'Indefinido';
  end;}
end;

procedure Tfrm_consultacli.ADOQueryconsultcliTPT_CLIGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  {begin
    if Sender.AsString = 'False' then
      Text := 'Perca de Peso'
      else
      Text := 'Ganho de Massa';
  end;}
end;

procedure Tfrm_consultacli.bnt_cancelarconsutacliClick(Sender: TObject);
begin
 close;
end;

procedure Tfrm_consultacli.btn_adcmensaClick(Sender: TObject);
var
ano1, mes1, dia1, dt1 : string;
begin
  U_Cadastrar_Mensalidades.frm_cadasmensalidades.edt_nmcli.text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliNM_CLI.AsString;
  U_Cadastrar_Mensalidades.frm_cadasmensalidades.edt_codcli.text := IntToStr(U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_CLI.AsInteger);
    {dt1 := ADOQueryconsultcliDTMATRI_CLI.AsString;

    dia1 := COPY(dt1,9,2);
    mes1 := COPY(dt1,6,2);
    ano1 := COPY(dt1,1,4);

    U_Cadastrar_Mensalidades.frm_cadasmensalidades.MaskEditDataVenc.Text := dia1 + '/' + mes1 + '/' +ano1 ;}
  frm_cadasmensalidades.ShowModal;
end;

procedure Tfrm_consultacli.btn_alterarcliClick(Sender: TObject);
var
  dia1,dia2,mes1,mes2,ano1,ano2,dt1,dt2 : string;
begin
  U_Alterar_Cliente.frm_altercli.edt_cod.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_nomecli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliNM_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.MaskEditCPFCliAlter.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCPF_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.MaskEditRGCliAlter.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliRG_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_enderecocli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliEND_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_emailcli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliEML_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_foto.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliFT_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_usuario.Text := IntToStr(U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_USU.AsInteger);

  dt1 := ADOQueryconsultcliDTNASC_CLI.AsString;

  dia1 := COPY(dt1,9,2);
  mes1 := COPY(dt1,6,2);
  ano1 := COPY(dt1,1,4);

  U_Alterar_Cliente.frm_altercli.MaskEditdatanasc.Text := dia1 + '/' + mes1 + '/' +ano1 ;

  dt2 := ADOQueryconsultcliDTNASC_CLI.AsString;

  dia2 := COPY(dt2,9,2);
  mes2 := COPY(dt2,6,2);
  ano2 := COPY(dt2,1,4);

  U_Alterar_Cliente.frm_altercli.MaskEditdatamatric.Text := dia2 + '/' + mes2 + '/' +ano2;
  U_Alterar_Cliente.frm_altercli.MaskEdittelefone.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliTEL_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.Text := ADOQueryconsultcliSX_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.Text := ADOQueryconsultcliTPT_CLI.AsString;
  if ADOQueryconsultcliSTA_CLI.AsBoolean = True then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
  end

  else
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
  end;
 { if (ADOQueryconsultcliSX_CLI.AsBoolean = True) and (ADOQueryconsultcliSTA_CLI.AsBoolean = True) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = True) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = True) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliSTA_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliTPT_CLI.AsBoolean = FALSE) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end; }

  frm_altercli.ShowModal;

end;

procedure Tfrm_consultacli.btn_buscarconsulcliClick(Sender: TObject);
begin
  case ComboBoxConsultacli.ItemIndex of
  0: with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where COD_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
   1:with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where NM_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
    2:with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where RG_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
    3:with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where CPF_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
  end;
end;

procedure Tfrm_consultacli.btn_cancelarconsulcliClick(Sender: TObject);
begin
  Close;
end;
procedure Tfrm_consultacli.Button1Click(Sender: TObject);
begin
  frm_consultarmedi.ShowModal;
end;

procedure Tfrm_consultacli.ComboBoxConsultacliKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_consultacli.DBGridconsultacliCellClick(Column: TColumn);
var
  dia1,dia2,mes1,mes2,ano1,ano2,dt1,dt2 : string;
begin
{  U_Alterar_Cliente.frm_altercli.edt_cod.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_nomecli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliNM_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.MaskEditCPFCliAlter.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCPF_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.MaskEditRGCliAlter.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliRG_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_enderecocli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliEND_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_emailcli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliEML_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_foto.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliFT_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_usuario.Text := IntToStr(U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_USU.AsInteger);

  dt1 := ADOQueryconsultcliDTNASC_CLI.AsString;

  dia1 := COPY(dt1,9,2);
  mes1 := COPY(dt1,6,2);
  ano1 := COPY(dt1,1,4);

  U_Alterar_Cliente.frm_altercli.MaskEditdatanasc.Text := dia1 + '/' + mes1 + '/' +ano1 ;

  dt2 := ADOQueryconsultcliDTNASC_CLI.AsString;

  dia2 := COPY(dt2,9,2);
  mes2 := COPY(dt2,6,2);
  ano2 := COPY(dt2,1,4);

  U_Alterar_Cliente.frm_altercli.MaskEditdatamatric.Text := dia2 + '/' + mes2 + '/' +ano2;
  U_Alterar_Cliente.frm_altercli.MaskEdittelefone.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliTEL_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.Text := ADOQueryconsultcliSX_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.Text := ADOQueryconsultcliTPT_CLI.AsString;

  if ADOQueryconsultcliSTA_CLI.AsBoolean = True then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
  end

  else
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
  end;

    {if (ADOQueryconsultcliSX_CLI.AsBoolean = True) and (ADOQueryconsultcliSTA_CLI.AsBoolean = True) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = True) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = True) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliSTA_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliTPT_CLI.AsBoolean = FALSE) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end;

  frm_altercli.ShowModal;  }

end;

procedure Tfrm_consultacli.DBGridconsultacliDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
 begin
    TDBGrid(Sender).Canvas.Brush.Color:= $00FFA346;
 end
 else
 begin
     TDBGrid(Sender).Brush.Color:= clCream;
 end;

  TDbGrid(Sender).Canvas.font.Color:= clBlack;
    if gdSelected in State then
      with (Sender as TDBGrid).Canvas do
        begin
          Brush.Color := $0000F2F9;
          FillRect(Rect);
          Font.Style := [fsbold]
        end;

  TDbGrid(Sender).DefaultDrawDataCell(Rect, TDbGrid(Sender).columns[datacol].field, State);
end;

procedure Tfrm_consultacli.edt_buscacliChange(Sender: TObject);
begin
  case ComboBoxConsultacli.ItemIndex of
  0: with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where COD_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
   1:with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where NM_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
    2:with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where RG_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
    3:with ADOQueryconsultcli do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_CLIENTES                                           ');
    sql.Add('Where CPF_CLI LIKE ''%' +  edt_buscacli.text + '%''              ');
    Clipboard.AsText := ADOQueryconsultcli.SQL.Text;
    Open;
    Active := True;
    end;
  end;
end;

procedure Tfrm_consultacli.FormShow(Sender: TObject);
begin
  edt_buscacli.Clear;
  //ComboBoxConsultacli.ItemIndex := -1;
  DBGridconsultacli.Refresh;
end;

procedure Tfrm_consultacli.Image4Click(Sender: TObject);
begin
  U_Cadastrar_Novas_Medidas.frm_cadasnovasmedidas.edt_nomeclimedidas.Text := ADOQueryconsultcliNM_CLI.AsString;
  U_Cadastrar_Novas_Medidas.frm_cadasnovasmedidas.Editcodigo.Text := IntToStr(ADOQueryconsultcliCOD_CLI.AsInteger);
  frm_cadasnovasmedidas.ShowModal;
end;

procedure Tfrm_consultacli.Image5Click(Sender: TObject);
var
  dia1,dia2,mes1,mes2,ano1,ano2,dt1,dt2 : string;
begin
  U_Alterar_Cliente.frm_altercli.edt_cod.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_nomecli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliNM_CLI.AsString;
  ///U_Alterar_Cliente.frm_altercli.MaskEditCPFCliAlter.EditMask := '!999.999.999-99;0;_';
  U_Alterar_Cliente.frm_altercli.MaskEditCPFCliAlter.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCPF_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.MaskEditRGCliAlter.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliRG_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_enderecocli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliEND_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_emailcli.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliEML_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_foto.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliFT_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.edt_usuario.Text := IntToStr(U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliCOD_USU.AsInteger);

  dt1 := ADOQueryconsultcliDTNASC_CLI.AsString;

  dia1 := COPY(dt1,9,2);
  mes1 := COPY(dt1,6,2);
  ano1 := COPY(dt1,1,4);

  U_Alterar_Cliente.frm_altercli.MaskEditdatanasc.Text := dia1 + '/' + mes1 + '/' +ano1 ;

  dt2 := ADOQueryconsultcliDTMATRI_CLI.AsString;

  dia2 := COPY(dt2,9,2);
  mes2 := COPY(dt2,6,2);
  ano2 := COPY(dt2,1,4);

  U_Alterar_Cliente.frm_altercli.MaskEditdatamatric.Text := dia2 + '/' + mes2 + '/' +ano2;
  U_Alterar_Cliente.frm_altercli.MaskEdittelefone.Text := U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcliTEL_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.Text := ADOQueryconsultcliSX_CLI.AsString;
  U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.Text := ADOQueryconsultcliTPT_CLI.AsString;

  if ADOQueryconsultcliSTA_CLI.AsBoolean = True then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
  end

  else
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
  end;
  {if (ADOQueryconsultcliSX_CLI.AsBoolean = True) and (ADOQueryconsultcliSTA_CLI.AsBoolean = True) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = True) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = True) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = False) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = False) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliSTA_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliTPT_CLI.AsBoolean = FALSE) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 0;
  end

  else if (ADOQueryconsultcliSX_CLI.AsBoolean = False) and (ADOQueryconsultcliSTA_CLI.AsBoolean = TRUE) and (ADOQueryconsultcliTPT_CLI.AsBoolean = True) then
  begin
    U_Alterar_Cliente.frm_altercli.ComboBoxsexocli.ItemIndex := 0;
    U_Alterar_Cliente.frm_altercli.ComboBoxstatuscli.ItemIndex := 1;
    U_Alterar_Cliente.frm_altercli.ComboBoxTipoTreino.ItemIndex := 1;
  end;}

  frm_altercli.ShowModal;

end;

procedure Tfrm_consultacli.Image6Click(Sender: TObject);
begin
  close;
end;

procedure Tfrm_consultacli.img_altermedidasClick(Sender: TObject);
begin
  frm_consultarmedi.ShowModal;
end;

end.
