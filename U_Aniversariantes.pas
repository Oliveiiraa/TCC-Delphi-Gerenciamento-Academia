unit U_Aniversariantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, pngimage, ExtCtrls;

type
  Tfrm_aniversariantes = class(TForm)
    ADOQueryAniversariantes: TADOQuery;
    DataSourceAniversariantes: TDataSource;
    ADOConnectionAniversariantes: TADOConnection;
    DBGrid1: TDBGrid;
    Image1: TImage;
    ADOQueryAniversariantesCOD_CLI: TAutoIncField;
    ADOQueryAniversariantesNM_CLI: TStringField;
    ADOQueryAniversariantesEND_CLI: TStringField;
    ADOQueryAniversariantesCPF_CLI: TStringField;
    ADOQueryAniversariantesRG_CLI: TStringField;
    ADOQueryAniversariantesTEL_CLI: TStringField;
    ADOQueryAniversariantesDTMATRI_CLI: TWideStringField;
    ADOQueryAniversariantesDTNASC_CLI: TWideStringField;
    ADOQueryAniversariantesEML_CLI: TStringField;
    ADOQueryAniversariantesSTA_CLI: TBooleanField;
    ADOQueryAniversariantesSX_CLI: TStringField;
    ADOQueryAniversariantesFT_CLI: TStringField;
    ADOQueryAniversariantesTPT_CLI: TStringField;
    ADOQueryAniversariantesCOD_USU: TIntegerField;
    Edit1: TEdit;
    Image9: TImage;
    procedure FormShow(Sender: TObject);
    procedure ADOQueryAniversariantesSTA_CLIGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure ADOQueryAniversariantesSX_CLIGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure Image6Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Image9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_aniversariantes: Tfrm_aniversariantes;

implementation

{$R *.dfm}

procedure Tfrm_aniversariantes.ADOQueryAniversariantesSTA_CLIGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  begin
  if Sender.AsString = 'False' then
       Text := 'Ativo'
    else
       if Sender.AsString = 'True' then
          Text := 'Inativo'
  end;
end;

procedure Tfrm_aniversariantes.ADOQueryAniversariantesSX_CLIGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
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

procedure Tfrm_aniversariantes.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    var
  datac,ano1,dia1,mes1,data,diac : string;
begin
      dia1 := copy(Edit1.Text,1,2);
      mes1 := copy(Edit1.Text,4,2);
      ano1 := copy(Edit1.Text,7,4);
      datac := ano1 + '-' + mes1 + '-' + dia1;
      data := ADOQueryAniversariantesDTNASC_CLI.asstring;
      diac := copy(data,9,2);
  if ( dia1 = diac) then
 begin
    TDBGrid(Sender).Canvas.Brush.Color:= clLtGray;
    //Font.Style := [fsbold];
 end

 else
 begin
     TDBGrid(Sender).Canvas.Brush.Color:= clWhite;
     //Font.Color := clRed;
 end;

   TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].field, State);
end;

procedure Tfrm_aniversariantes.FormShow(Sender: TObject);
begin
    Edit1.text := datetostr(Date);
   U_Aniversariantes.frm_aniversariantes.ADOQueryAniversariantes.Close;
    U_Aniversariantes.frm_aniversariantes.ADOQueryAniversariantes.Open;
    U_Aniversariantes.frm_aniversariantes.ADOQueryAniversariantes.Refresh;
end;

procedure Tfrm_aniversariantes.Image6Click(Sender: TObject);
begin
 close;
end;

procedure Tfrm_aniversariantes.Image9Click(Sender: TObject);
begin
  close;
end;

end.
