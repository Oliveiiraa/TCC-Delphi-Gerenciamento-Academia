unit U_Consultar_Funcionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Clipbrd,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, pngimage, ExtCtrls;

type
  Tfrm_consultafunc = class(TForm)
    edt_buscafunc: TEdit;
    DBGridconsultafunc: TDBGrid;
    DataSourceconsultafunc: TDataSource;
    ADOQueryconsultafunc: TADOQuery;
    ADOStoredProc1: TADOStoredProc;
    ADOConnectionconsultafunc: TADOConnection;
    ComboBoxConsultafunc: TComboBox;
    Image1: TImage;
    Image6: TImage;
    Image3: TImage;
    ADOQueryconsultafuncCOD_FUNC: TAutoIncField;
    ADOQueryconsultafuncNM_FUNC: TStringField;
    ADOQueryconsultafuncEND_FUNC: TStringField;
    ADOQueryconsultafuncCPF_FUNC: TStringField;
    ADOQueryconsultafuncRG_FUNC: TStringField;
    ADOQueryconsultafuncTEL_FUNC: TStringField;
    ADOQueryconsultafuncDTNASC_FUNC: TWideStringField;
    ADOQueryconsultafuncEML_FUNC: TStringField;
    ADOQueryconsultafuncSX_FUNC: TStringField;
    ADOQueryconsultafuncSTA_FUNC: TBooleanField;
    ADOQueryconsultafuncFT_FUNC: TStringField;
    ADOQueryconsultafuncCOD_USU: TIntegerField;
    procedure bnt_buscafuncClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bnt_editarfuncClick(Sender: TObject);
    procedure ADOQueryconsultafuncSX_FUNCGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure ADOQueryconsultafuncSTA_FUNCGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure bnt_cancelarconsultafuncClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure edt_buscafuncChange(Sender: TObject);
    procedure ComboBoxConsultafuncKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridconsultafuncDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultafunc: Tfrm_consultafunc;

implementation

uses U_Alterar_Funcionario;

{$R *.dfm}

procedure Tfrm_consultafunc.ADOQueryconsultafuncSTA_FUNCGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if SENDER.AsString = 'False' then
    text := 'Ativo'
  else
    Text := 'Inativo'
end;

procedure Tfrm_consultafunc.ADOQueryconsultafuncSX_FUNCGetText(Sender: TField;
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

procedure Tfrm_consultafunc.bnt_buscafuncClick(Sender: TObject);
begin
  case ComboBoxConsultafunc.ItemIndex of
  0:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where COD_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  1:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where NM_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  2:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where RG_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  3:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where CPF_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  end;
end;

procedure Tfrm_consultafunc.bnt_cancelarconsultafuncClick(Sender: TObject);
begin
 close;
end;

procedure Tfrm_consultafunc.bnt_editarfuncClick(Sender: TObject);
var
ano, mes, dia, datacompleto : string;
begin
  U_Alterar_Funcionario.frm_alterafunc.edt_codfunc.Text := IntToStr(ADOQueryconsultafuncCOD_FUNC.AsInteger);
  U_Alterar_Funcionario.frm_alterafunc.edt_nomefunc.Text := ADOQueryconsultafuncNM_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_enderecofunc.Text := ADOQueryconsultafuncEND_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.MaskEditCPFFUNC.Text := ADOQueryconsultafuncCPF_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.MaskEditRGFunc.Text := ADOQueryconsultafuncRG_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_emailfunc.Text := ADOQueryconsultafuncEML_FUNC.AsString;
  /////U_Alterar_Funcionario.frm_alterafunc.edt_complementofunc.Text := ADOQueryconsultafunccomplemento.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_foto.Text := ADOQueryconsultafuncFT_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_codusu.Text := ADOQueryconsultafuncCOD_USU.AsString;

  datacompleto := ADOQueryconsultafuncDTNASC_FUNC.AsString ;



  ////U_Alterar_Funcionario.frm_alterafunc.MaskEditdatapag.Clear;

  dia := COPY(datacompleto,9,2);
  mes := COPY(datacompleto,6,2);
  ano := COPY(datacompleto,1,4);

  U_Alterar_Funcionario.frm_alterafunc.MaskEditdataNasc.Text := dia + '/' + mes + '/' +ano ;
  ////ShowMessage(dia + '/' + mes + '/' + ano);

  U_Alterar_Funcionario.frm_alterafunc.MaskEdittel.Text := ADOQueryconsultafuncTEL_FUNC.AsString;

  U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.Text := ADOQueryconsultafuncSX_FUNC.AsString;

  if ADOQueryconsultafuncSTA_FUNC.AsBoolean = True then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 1;
  end

  else
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 0;
  end;

  {if (ADOQueryconsultafuncSX_FUNC.AsBoolean = True) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = True) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 1;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 1;
  end

  else if (ADOQueryconsultafuncSX_FUNC.AsBoolean = False) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = False) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 0;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 0;
  end

  else if (ADOQueryconsultafuncSX_FUNC.AsBoolean = False) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = True) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 1;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 0;
  end

  else if (ADOQueryconsultafuncSX_FUNC.AsBoolean = True) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = False) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 0;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 1;
  end;}

  frm_alterafunc.ShowModal;
end;

procedure Tfrm_consultafunc.ComboBoxConsultafuncKeyPress(Sender: TObject;
  var Key: Char);
begin
key:=#0;
end;

procedure Tfrm_consultafunc.DBGridconsultafuncDrawColumnCell(Sender: TObject;
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

procedure Tfrm_consultafunc.edt_buscafuncChange(Sender: TObject);
begin
  case ComboBoxConsultafunc.ItemIndex of
  0:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where COD_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  1:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where NM_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  2:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where RG_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  3:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where CPF_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  end;
end;

procedure Tfrm_consultafunc.FormShow(Sender: TObject);
begin
  ADOQueryconsultafunc.Close;
  ADOQueryconsultafunc.Open;
  ADOQueryconsultafunc.Refresh;
    edt_buscafunc.Clear;
  DBGridconsultafunc.Refresh;
  //ComboBoxConsultafunc.ItemIndex := -1;
end;
procedure Tfrm_consultafunc.Image2Click(Sender: TObject);
begin
   case ComboBoxConsultafunc.ItemIndex of
  0:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where COD_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  1:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where NM_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  2:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where RG_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  3:with ADOQueryconsultafunc do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_FUNCIONARIOS                                           ');
    sql.Add('Where CPF_FUNC LIKE ''%' + edt_buscafunc.Text + '%''                   ');
    Clipboard.AsText := ADOQueryconsultafunc.SQL.Text;
    Open;
    Active := True;
  end;
  end;
end;

procedure Tfrm_consultafunc.Image3Click(Sender: TObject);
var
ano, mes, dia, datacompleto : string;
begin
   U_Alterar_Funcionario.frm_alterafunc.edt_codfunc.Text := IntToStr(ADOQueryconsultafuncCOD_FUNC.AsInteger);
  U_Alterar_Funcionario.frm_alterafunc.edt_nomefunc.Text := ADOQueryconsultafuncNM_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_enderecofunc.Text := ADOQueryconsultafuncEND_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.MaskEditCPFFUNC.Text := ADOQueryconsultafuncCPF_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.MaskEditRGFunc.Text := ADOQueryconsultafuncRG_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_emailfunc.Text := ADOQueryconsultafuncEML_FUNC.AsString;
  /////U_Alterar_Funcionario.frm_alterafunc.edt_complementofunc.Text := ADOQueryconsultafunccomplemento.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_foto.Text := ADOQueryconsultafuncFT_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.edt_codusu.Text := ADOQueryconsultafuncCOD_USU.AsString;

  datacompleto := ADOQueryconsultafuncDTNASC_FUNC.AsString ;



  ////U_Alterar_Funcionario.frm_alterafunc.MaskEditdatapag.Clear;

  dia := COPY(datacompleto,9,2);
  mes := COPY(datacompleto,6,2);
  ano := COPY(datacompleto,1,4);

  U_Alterar_Funcionario.frm_alterafunc.MaskEditdataNasc.Text := dia + '/' + mes + '/' +ano ;
  ////ShowMessage(dia + '/' + mes + '/' + ano);

  U_Alterar_Funcionario.frm_alterafunc.MaskEdittel.Text := ADOQueryconsultafuncTEL_FUNC.AsString;
  U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.Text := ADOQueryconsultafuncSX_FUNC.AsString;

  if ADOQueryconsultafuncSTA_FUNC.AsBoolean = True then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 1;
  end

  else
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 0;
  end;
  {if (ADOQueryconsultafuncSX_FUNC.AsBoolean = True) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = True) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 1;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 1;
  end

  else if (ADOQueryconsultafuncSX_FUNC.AsBoolean = False) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = False) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 0;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 0;
  end

  else if (ADOQueryconsultafuncSX_FUNC.AsBoolean = False) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = True) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 1;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 0;
  end

  else if (ADOQueryconsultafuncSX_FUNC.AsBoolean = True) and (ADOQueryconsultafuncSTA_FUNC.AsBoolean = False) then
  begin
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxsexofunc.ItemIndex := 0;
    U_Alterar_Funcionario.frm_alterafunc.ComboBoxstatusfunc.ItemIndex := 1;
  end; }

  frm_alterafunc.ShowModal;
end;

procedure Tfrm_consultafunc.Image6Click(Sender: TObject);
begin
close;
end;

end.
