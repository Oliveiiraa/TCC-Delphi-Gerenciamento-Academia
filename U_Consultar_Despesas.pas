unit U_Consultar_Despesas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Grids, DBGrids, Clipbrd, pngimage, ExtCtrls;

type
  Tfrm_consultadespesas = class(TForm)
    DBGrid1: TDBGrid;
    ADOConnectionConsultaDespesas: TADOConnection;
    DataSourceConsultaDespesas: TDataSource;
    ADOQueryConsultaDespesas: TADOQuery;
    edt_buscardespesas: TEdit;
    ComboBoxDespesas: TComboBox;
    Image1: TImage;
    Image6: TImage;
    ADOQueryConsultaDespesasCOD_DPS: TAutoIncField;
    ADOQueryConsultaDespesasDSC_DPS: TStringField;
    ADOQueryConsultaDespesasDT_DPS: TWideStringField;
    ADOQueryConsultaDespesasVL_DPS: TBCDField;
    ADOQueryConsultaDespesasNM_FUNC: TStringField;
    ImageExcluir: TImage;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_excluirdespesasClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure edt_buscardespesasChange(Sender: TObject);
    procedure ImageExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultadespesas: Tfrm_consultadespesas;

implementation

{$R *.dfm}

procedure Tfrm_consultadespesas.btn_cancelarClick(Sender: TObject);
begin
   Close;
end;

procedure Tfrm_consultadespesas.btn_excluirdespesasClick(Sender: TObject);
begin
  ADOQueryConsultaDespesas.Delete;

    MessageDlg('Despesa excluida com sucesso!',mtInformation,[mbOK],0);
end;

procedure Tfrm_consultadespesas.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure Tfrm_consultadespesas.edt_buscardespesasChange(Sender: TObject);
begin
  case ComboBoxDespesas.ItemIndex of
  0:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where COD_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  1:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where DSC_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  2:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where VL_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  end;
end;

procedure Tfrm_consultadespesas.FormShow(Sender: TObject);
begin
  edt_buscardespesas.Clear;
  DBGrid1.Refresh;
  //ComboBoxDespesas.ItemIndex := -1;
end;

procedure Tfrm_consultadespesas.Image2Click(Sender: TObject);
begin
   case ComboBoxDespesas.ItemIndex of
  0:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where COD_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  1:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where DSC_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  2:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where DT_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  3:with ADOQueryConsultaDespesas do
  begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_DESPESAS                                           ');
    sql.Add('Where VL_DPS LIKE ''%' + edt_buscardespesas.Text + '%''                   ');
    Clipboard.AsText := ADOQueryConsultaDespesas.SQL.Text;
    Open;
    Active := True;
  end;
  end;

end;

procedure Tfrm_consultadespesas.Image6Click(Sender: TObject);
begin
 close;
end;

procedure Tfrm_consultadespesas.ImageExcluirClick(Sender: TObject);
begin
   if Application.MessageBox('Deseja realmente excluir a despesa?','Atenção',MB_ICONQUESTION + MB_YESNO) = IDNO then
    begin

    end

    else
    begin
      ADOQueryConsultaDespesas.Delete;
      ADOQueryConsultaDespesas.Close;
      ADOQueryConsultaDespesas.Open;
      ADOQueryConsultaDespesas.Refresh;
    end;
end;

end.
