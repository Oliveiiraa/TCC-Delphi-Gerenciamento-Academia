unit U_Consultar_Medidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, Mask, StdCtrls, DB, Grids, DBGrids, ADODB, Clipbrd;

type
  Tfrm_consultarmedi = class(TForm)
    ADOConnectionConsultMedidas: TADOConnection;
    DataSourceConsultMedidas: TDataSource;
    ADOQueryConsultMedidas: TADOQuery;
    DBGrid1: TDBGrid;
    ADOQueryConsultMedidasCOD_CLI: TAutoIncField;
    ADOQueryConsultMedidasNM_CLI: TStringField;
    ADOQueryConsultMedidasEND_CLI: TStringField;
    ADOQueryConsultMedidasCPF_CLI: TStringField;
    ADOQueryConsultMedidasRG_CLI: TStringField;
    ADOQueryConsultMedidasTEL_CLI: TStringField;
    ADOQueryConsultMedidasDTMATRI_CLI: TWideStringField;
    ADOQueryConsultMedidasDTNASC_CLI: TWideStringField;
    ADOQueryConsultMedidasEML_CLI: TStringField;
    ADOQueryConsultMedidasSTA_CLI: TBooleanField;
    ADOQueryConsultMedidasSX_CLI: TStringField;
    ADOQueryConsultMedidasFT_CLI: TStringField;
    ADOQueryConsultMedidasTPT_CLI: TStringField;
    ADOQueryConsultMedidasCOD_USU: TIntegerField;
    ADOQueryConsultMedidasCOD_MD: TAutoIncField;
    ADOQueryConsultMedidasDTAVF_MD: TWideStringField;
    ADOQueryConsultMedidasPS_MD: TBCDField;
    ADOQueryConsultMedidasAT_MD: TBCDField;
    ADOQueryConsultMedidasBC_MD: TBCDField;
    ADOQueryConsultMedidasTC_MD: TBCDField;
    ADOQueryConsultMedidasPT_MD: TBCDField;
    ADOQueryConsultMedidasQD_MD: TBCDField;
    ADOQueryConsultMedidasCT_MD: TBCDField;
    ADOQueryConsultMedidasCX_MD: TBCDField;
    ADOQueryConsultMedidasOB_MD: TBCDField;
    ADOQueryConsultMedidasPTR_MD: TBCDField;
    ADOQueryConsultMedidasCOD_CLI_1: TIntegerField;
    btn_adcmedidas: TButton;
    btn_visumedi: TButton;
    edt_buscar: TEdit;
    Image1: TImage;
    Image6: TImage;
    Image2: TImage;
    procedure btn_adcmedidasClick(Sender: TObject);
    procedure edt_buscarChange(Sender: TObject);
    procedure btn_visumediClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultarmedi: Tfrm_consultarmedi;

implementation

uses U_Cadastrar_Medidas, U_Medidas, U_Cadastrar_Novas_Medidas;

{$R *.dfm}

procedure Tfrm_consultarmedi.btn_adcmedidasClick(Sender: TObject);
begin
  frm_cadasnovasmedidas.ShowModal;
end;

procedure Tfrm_consultarmedi.btn_visumediClick(Sender: TObject);
var
ano1,mes1,dia1 : string;
begin
  U_Medidas.frm_medidas.edt_nomeclimedidas.Text := ADOQueryConsultMedidasNM_CLI.AsString;
  U_Medidas.frm_medidas.edt_peso.Text := ADOQueryConsultMedidasPS_MD.AsString;
  U_Medidas.frm_medidas.edt_altura.Text := ADOQueryConsultMedidasAT_MD.AsString;
  U_Medidas.frm_medidas.edt_biceps.Text := ADOQueryConsultMedidasBC_MD.AsString;
  U_Medidas.frm_medidas.edt_triceps.Text := ADOQueryConsultMedidasTC_MD.AsString;
  U_Medidas.frm_medidas.edt_peitoral.Text := ADOQueryConsultMedidasPT_MD.AsString;
  U_Medidas.frm_medidas.edt_quadril.Text := ADOQueryConsultMedidasQD_MD.AsString;
  U_Medidas.frm_medidas.edt_cintura.Text := ADOQueryConsultMedidasCT_MD.AsString;
  U_Medidas.frm_medidas.edt_coxa.Text := ADOQueryConsultMedidasCX_MD.AsString;
  U_Medidas.frm_medidas.edt_ombro.Text := ADOQueryConsultMedidasOB_MD.AsString;
  U_Medidas.frm_medidas.edt_panturrilha.Text := ADOQueryConsultMedidasPTR_MD.AsString;
  ano1 := copy(ADOQueryConsultMedidasDTAVF_MD.AsString,1,4);
  mes1 := copy(ADOQueryConsultMedidasDTAVF_MD.AsString,6,2);
  dia1 := copy(ADOQueryConsultMedidasDTAVF_MD.AsString,9,2);
  U_Medidas.frm_medidas.MaskEditdataavaliacao.Text := dia1 + '/' + mes1 + '/' + ano1;

  frm_medidas.ShowModal;
end;

procedure Tfrm_consultarmedi.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure Tfrm_consultarmedi.edt_buscarChange(Sender: TObject);
begin
  with ADOQueryConsultMedidas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('SELECT*FROM TB_CLIENTES,TB_MEDIDAS WHERE TB_CLIENTES.COD_CLI=TB_MEDIDAS.COD_CLI    AND');
    sql.Add(' NM_CLI LIKE ''%' + edt_buscar.Text + '%''                                            ');
    Clipboard.AsText := ADOQueryConsultMedidas.SQL.Text;
    Open;
    Active := True;
  end;
end;

procedure Tfrm_consultarmedi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  edt_buscar.Clear;
  DBGrid1.Refresh;
end;

procedure Tfrm_consultarmedi.FormShow(Sender: TObject);
begin
  ADOQueryConsultMedidas.Close;
  ADOQueryConsultMedidas.Open;
  ADOQueryConsultMedidas.Refresh;
end;

procedure Tfrm_consultarmedi.Image2Click(Sender: TObject);
var
ano1,mes1,dia1 : string;
begin
  U_Medidas.frm_medidas.edt_nomeclimedidas.Text := ADOQueryConsultMedidasNM_CLI.AsString;
  U_Medidas.frm_medidas.edt_peso.Text := ADOQueryConsultMedidasPS_MD.AsString;
  U_Medidas.frm_medidas.edt_altura.Text := ADOQueryConsultMedidasAT_MD.AsString;
  U_Medidas.frm_medidas.edt_biceps.Text := ADOQueryConsultMedidasBC_MD.AsString;
  U_Medidas.frm_medidas.edt_triceps.Text := ADOQueryConsultMedidasTC_MD.AsString;
  U_Medidas.frm_medidas.edt_peitoral.Text := ADOQueryConsultMedidasPT_MD.AsString;
  U_Medidas.frm_medidas.edt_quadril.Text := ADOQueryConsultMedidasQD_MD.AsString;
  U_Medidas.frm_medidas.edt_cintura.Text := ADOQueryConsultMedidasCT_MD.AsString;
  U_Medidas.frm_medidas.edt_coxa.Text := ADOQueryConsultMedidasCX_MD.AsString;
  U_Medidas.frm_medidas.edt_ombro.Text := ADOQueryConsultMedidasOB_MD.AsString;
  U_Medidas.frm_medidas.edt_panturrilha.Text := ADOQueryConsultMedidasPTR_MD.AsString;
  ano1 := copy(ADOQueryConsultMedidasDTAVF_MD.AsString,1,4);
  mes1 := copy(ADOQueryConsultMedidasDTAVF_MD.AsString,6,2);
  dia1 := copy(ADOQueryConsultMedidasDTAVF_MD.AsString,9,2);
  U_Medidas.frm_medidas.MaskEditdataavaliacao.Text := dia1 + '/' + mes1 + '/' + ano1;

  frm_medidas.ShowModal;
end;

procedure Tfrm_consultarmedi.Image3Click(Sender: TObject);
begin
  U_Cadastrar_Novas_Medidas.frm_cadasnovasmedidas.edt_nomeclimedidas.Text := ADOQueryConsultMedidasNM_CLI.AsString;
  U_Cadastrar_Novas_Medidas.frm_cadasnovasmedidas.Editcodigo.Text := IntToStr(ADOQueryConsultMedidasCOD_CLI.AsInteger);
  frm_cadasnovasmedidas.ShowModal;
end;

procedure Tfrm_consultarmedi.Image6Click(Sender: TObject);
begin
 close;
end;

end.
