unit U_Relatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RpCon, RpConDS, RpDefine, RpRave, DB, ADODB, StdCtrls, pngimage,
  ExtCtrls;

type
  Tfrm_relatorios = class(TForm)
    btn_relatocli: TButton;
    RvProjectRelatoMensalidades: TRvProject;
    btn_relatomensa: TButton;
    btn_relatofunc: TButton;
    btn_relatodespe: TButton;
    RvProjectRelatoFuncionarios: TRvProject;
    RvProjectRelatorioDespesas: TRvProject;
    RvDataSetConnectionRelatoDespesas: TRvDataSetConnection;
    ADOQueryRelatoDespesas: TADOQuery;
    ADOQueryRelatoDespesasCOD_DPS: TAutoIncField;
    ADOQueryRelatoDespesasDSC_DPS: TStringField;
    ADOQueryRelatoDespesasDT_DPS: TWideStringField;
    ADOQueryRelatoDespesasVL_DPS: TBCDField;
    ADOQueryRelatoDespesasNM_FUNC: TStringField;
    Image1: TImage;
    RvDataSetConnectionRelatoriosMensalidades: TRvDataSetConnection;
    ADOQueryRelatoMensalidades: TADOQuery;
    ADOConnectionRelatorios: TADOConnection;
    ADOQueryRelatoCLi: TADOQuery;
    ADOQueryRelatoCLiCOD_CLI: TAutoIncField;
    ADOQueryRelatoCLiNM_CLI: TStringField;
    ADOQueryRelatoCLiEND_CLI: TStringField;
    ADOQueryRelatoCLiCPF_CLI: TStringField;
    ADOQueryRelatoCLiRG_CLI: TStringField;
    ADOQueryRelatoCLiTEL_CLI: TStringField;
    ADOQueryRelatoCLiDTMATRI_CLI: TWideStringField;
    ADOQueryRelatoCLiDTNASC_CLI: TWideStringField;
    ADOQueryRelatoCLiEML_CLI: TStringField;
    ADOQueryRelatoCLiSTA_CLI: TBooleanField;
    ADOQueryRelatoCLiSX_CLI: TStringField;
    ADOQueryRelatoCLiFT_CLI: TStringField;
    ADOQueryRelatoCLiTPT_CLI: TStringField;
    ADOQueryRelatoCLiCOD_USU: TIntegerField;
    ADOQueryRelatorioFuncionários: TADOQuery;
    ADOQueryRelatorioFuncionáriosCOD_FUNC: TAutoIncField;
    ADOQueryRelatorioFuncionáriosNM_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosEND_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosCPF_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosRG_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosTEL_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosDTNASC_FUNC: TWideStringField;
    ADOQueryRelatorioFuncionáriosEML_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosSX_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosSTA_FUNC: TBooleanField;
    ADOQueryRelatorioFuncionáriosFT_FUNC: TStringField;
    ADOQueryRelatorioFuncionáriosCOD_USU: TIntegerField;
    RvDataSetConnectionRelatorioFuncionarios: TRvDataSetConnection;
    RvProjectRelatoCli: TRvProject;
    RvDataSetConnectionRelatoriosCli: TRvDataSetConnection;
    imgclose: TImage;
    ADOQueryRelatoMensalidadesCOD_MSD: TAutoIncField;
    ADOQueryRelatoMensalidadesDTPAG_MSD: TWideStringField;
    ADOQueryRelatoMensalidadesDTVENC_MSD: TWideStringField;
    ADOQueryRelatoMensalidadesVL_MSD: TBCDField;
    ADOQueryRelatoMensalidadesCOD_CLI: TIntegerField;
    ADOQueryRelatoMensalidadesCOD_CLI_1: TAutoIncField;
    ADOQueryRelatoMensalidadesNM_CLI: TStringField;
    ADOQueryRelatoMensalidadesEND_CLI: TStringField;
    ADOQueryRelatoMensalidadesCPF_CLI: TStringField;
    ADOQueryRelatoMensalidadesRG_CLI: TStringField;
    ADOQueryRelatoMensalidadesTEL_CLI: TStringField;
    ADOQueryRelatoMensalidadesDTMATRI_CLI: TWideStringField;
    ADOQueryRelatoMensalidadesDTNASC_CLI: TWideStringField;
    ADOQueryRelatoMensalidadesEML_CLI: TStringField;
    ADOQueryRelatoMensalidadesSTA_CLI: TBooleanField;
    ADOQueryRelatoMensalidadesSX_CLI: TStringField;
    ADOQueryRelatoMensalidadesFT_CLI: TStringField;
    ADOQueryRelatoMensalidadesTPT_CLI: TStringField;
    ADOQueryRelatoMensalidadesCOD_USU: TIntegerField;
    ImageDespesas: TImage;
    ImageClientes: TImage;
    ImageFunc: TImage;
    ImageMensa: TImage;
    //procedure btn_relacliClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    //procedure Button1Click(Sender: TObject);
    procedure btn_relatomensaClick(Sender: TObject);
    procedure btn_relatofuncClick(Sender: TObject);
    procedure btn_relatodespeClick(Sender: TObject);
    procedure btn_relatocliClick(Sender: TObject);
    procedure imgcloseClick(Sender: TObject);
    procedure ImageDespesasClick(Sender: TObject);
    procedure ImageMensaClick(Sender: TObject);
    procedure ImageFuncClick(Sender: TObject);
    procedure ImageClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_relatorios: Tfrm_relatorios;

implementation

uses U_Login_Sistema;

{$R *.dfm}



procedure Tfrm_relatorios.btn_relatocliClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoCli.Execute;
end;

procedure Tfrm_relatorios.btn_relatodespeClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatorioDespesas.Execute;
end;

procedure Tfrm_relatorios.btn_relatofuncClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoFuncionarios.Execute;
end;

procedure Tfrm_relatorios.btn_relatomensaClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoMensalidades.Execute;
end;

procedure Tfrm_relatorios.FormShow(Sender: TObject);
begin
  ADOQueryRelatoCLi.Close;
  ADOQueryRelatoCLi.Open;
  ADOQueryRelatoCLi.Refresh;
  ADOQueryRelatorioFuncionários.Close;
  ADOQueryRelatorioFuncionários.Open;
  ADOQueryRelatorioFuncionários.Refresh;
  ADOQueryRelatoDespesas.Close;
  ADOQueryRelatoDespesas.Open;
  ADOQueryRelatoDespesas.Refresh;
  ADOQueryRelatoMensalidades.Close;
  ADOQueryRelatoMensalidades.Open;
  ADOQueryRelatoMensalidades.Refresh;
end;

procedure Tfrm_relatorios.ImageDespesasClick(Sender: TObject);
begin
      if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
      MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatorioDespesas.Execute;
  end
  else
  begin
    MessageDlg('Você não tem permissão para realizar este relatório!',mtError,[mbOK],0);
  end;
///  MessageDlg('Ligue a Impressora',mtInformation,[mbOK],0);
  ////RvProjectRelatorioDespesas.Execute;
end;

procedure Tfrm_relatorios.ImageFuncClick(Sender: TObject);
begin
     if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
     MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoFuncionarios.Execute;
  end
  else
  begin
    MessageDlg('Você não tem permissão para realizar este relatório!',mtError,[mbOK],0);
  end;
  ///MessageDlg('Ligue a Impressora',mtInformation,[mbOK],0);
  ////RvProjectRelatoFuncionarios.Execute;
end;

procedure Tfrm_relatorios.ImageMensaClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoMensalidades.Execute;
end;

procedure Tfrm_relatorios.imgcloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_relatorios.ImageClientesClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoCli.Execute;
end;

end.
