unit U_Relatorio_Func_Comum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, RpCon, RpConDS, RpDefine, RpRave, StdCtrls, pngimage,
  ExtCtrls;

type
  Tfrm_relatofunccomum = class(TForm)
    Image1: TImage;
    Image6: TImage;
    ImageClientes: TImage;
    ImageMensa: TImage;
    btn_relatocli: TButton;
    btn_relatomensa: TButton;
    RvProjectRelatoMensalidades: TRvProject;
    RvDataSetConnectionRelatoriosMensalidades: TRvDataSetConnection;
    ADOQueryRelatoMensalidades: TADOQuery;
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
    RvProjectRelatoCli: TRvProject;
    RvDataSetConnectionRelatoriosCli: TRvDataSetConnection;
    procedure ImageClientesClick(Sender: TObject);
    procedure ImageMensaClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_relatofunccomum: Tfrm_relatofunccomum;

implementation

{$R *.dfm}

procedure Tfrm_relatofunccomum.Image6Click(Sender: TObject);
begin
  close;
end;

procedure Tfrm_relatofunccomum.ImageClientesClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoCli.Execute;
end;

procedure Tfrm_relatofunccomum.ImageMensaClick(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  RvProjectRelatoMensalidades.Execute;
end;

end.
