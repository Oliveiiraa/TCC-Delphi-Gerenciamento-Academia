unit U_Visualizar_Cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Mask, ExtCtrls, pngimage;

type
  Tfrm_visualizarcli = class(TForm)
    lbl_nomecli: TLabel;
    lbl_datanasccli: TLabel;
    lbl_cpfcli: TLabel;
    lbl_rgcli: TLabel;
    lbl_enderecocli: TLabel;
    lbl_telefonecli: TLabel;
    lbl_datamatriculacli: TLabel;
    lbl_emailcli: TLabel;
    Image_cli: TImage;
    lbl_sexocli: TLabel;
    lbl_tipot: TLabel;
    edt_nomecli: TEdit;
    edt_enderecocli: TEdit;
    edt_emailcli: TEdit;
    MaskEditdatanasc: TMaskEdit;
    MaskEditdatamatric: TMaskEdit;
    MaskEdittelefone: TMaskEdit;
    edt_foto: TEdit;
    ComboBoxsexocli: TComboBox;
    ComboBoxstatuscli: TComboBox;
    ComboBoxTipoTreino: TComboBox;
    MaskEdit1: TMaskEdit;
    MaskEditRG: TMaskEdit;
    ADOConnectionCadasCli: TADOConnection;
    ADOQueryCadascli: TADOQuery;
    ADOQueryCadascliCOD_CLI: TAutoIncField;
    ADOQueryCadascliNM_CLI: TStringField;
    ADOQueryCadascliEND_CLI: TStringField;
    ADOQueryCadascliCPF_CLI: TStringField;
    ADOQueryCadascliRG_CLI: TStringField;
    ADOQueryCadascliTEL_CLI: TStringField;
    ADOQueryCadascliDTMATRI_CLI: TWideStringField;
    ADOQueryCadascliDTNASC_CLI: TWideStringField;
    ADOQueryCadascliEML_CLI: TStringField;
    ADOQueryCadascliSTA_CLI: TBooleanField;
    ADOQueryCadascliSX_CLI: TStringField;
    ADOQueryCadascliFT_CLI: TStringField;
    ADOQueryCadascliTPT_CLI: TStringField;
    ADOQueryCadascliCOD_USU: TIntegerField;
    Image1: TImage;
    Image6: TImage;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure ComboBoxsexocliKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxTipoTreinoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_visualizarcli: Tfrm_visualizarcli;

implementation

{$R *.dfm}

procedure Tfrm_visualizarcli.ComboBoxsexocliKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_visualizarcli.ComboBoxTipoTreinoKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_visualizarcli.FormShow(Sender: TObject);
begin
  if (edt_foto.Text = EmptyStr) and (Image_cli.Visible = false) then
  begin
    Image_cli.Visible := True;
    Image_cli.Picture.LoadFromFile('C:\images.PNG');
  end
  else if (edt_foto.Text = EmptyStr) and (Image_cli.Visible = True) then
  begin
    Image_cli.Picture.LoadFromFile('C:\images.PNG');
  end
  else
  begin
    Image_cli.Visible := True;
    Image_cli.Picture.LoadFromFile(edt_foto.Text);
  end;
end;

procedure Tfrm_visualizarcli.Image6Click(Sender: TObject);
begin
 close;
end;

end.
