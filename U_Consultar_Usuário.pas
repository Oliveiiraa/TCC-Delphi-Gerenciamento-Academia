unit U_Consultar_Usu�rio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, Clipbrd, pngimage, ExtCtrls;

type
  Tfrm_consultusuario = class(TForm)
    DataSourceConsultUsu: TDataSource;
    ADOConnectionConsultUsu: TADOConnection;
    ADOQueryConsultUsu: TADOQuery;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    edt_buscar: TEdit;
    ComboBoxConsultUsu: TComboBox;
    Image1: TImage;
    Image6: TImage;
    ADOQueryConsultUsuCOD_USU: TAutoIncField;
    ADOQueryConsultUsuNM_USU: TStringField;
    ADOQueryConsultUsuLG_USU: TStringField;
    ADOQueryConsultUsuSN_USU: TStringField;
    ADOQueryConsultUsuTP_USU: TBooleanField;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ADOQueryConsultUsuTP_USUGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btn_excluirClick(Sender: TObject);
    procedure bnt_cancelarconsultausuClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure edt_buscarChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxConsultUsuKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultusuario: Tfrm_consultusuario;

implementation

{$R *.dfm}

procedure Tfrm_consultusuario.ADOQueryConsultUsuTP_USUGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  begin
    if Sender.AsString = 'False' then
       Text := 'Administrador'
    else
      Text := 'Usu�rio Comum'
  end;
end;

procedure Tfrm_consultusuario.bnt_cancelarconsultausuClick(Sender: TObject);
begin
 close;
end;

procedure Tfrm_consultusuario.btn_excluirClick(Sender: TObject);
begin
  ADOQueryConsultUsu.Delete;
end;

procedure Tfrm_consultusuario.ComboBoxConsultUsuKeyPress(Sender: TObject;
  var Key: Char);
begin
key:=#0;
end;

procedure Tfrm_consultusuario.DBGrid1CellClick(Column: TColumn);
begin
  Memo1.Text := Memo1.Text + ' ' + IntToStr(ADOQueryConsultUsuCOD_USU.AsInteger);

  Memo1.Text := Memo1.Text + ' ' + ADOQueryConsultUsuLG_USU.AsString;

  Memo1.Text := Memo1.Text + ' ' + ADOQueryConsultUsuSN_USU.AsString;

  if ADOQueryConsultUsuTP_USU.AsBoolean = False then
  begin
    Memo1.Text := Memo1.Text + ' ' + 'Administrador';
  end

  else
  begin
    Memo1.Text := Memo1.Text + ' ' + 'Usu�rio Comum';
  end;
end;

procedure Tfrm_consultusuario.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure Tfrm_consultusuario.edt_buscarChange(Sender: TObject);
begin
   case ComboBoxConsultUsu.ItemIndex of
  0: with ADOQueryConsultUsu do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_USUARIOS                                           ');
    sql.Add('Where COD_USU LIKE ''%' +  edt_buscar.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultUsu.SQL.Text;
    Open;
    Active := True;
    end;
   1:with ADOQueryConsultUsu do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_USUARIOS                                           ');
    sql.Add('Where LG_USU LIKE ''%' +  edt_buscar.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultUsu.SQL.Text;
    Open;
    Active := True;
    end;
    2:with ADOQueryConsultUsu do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_USUARIOS                                           ');
    sql.Add('Where TP_USU LIKE ''%' +  edt_buscar.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultUsu.SQL.Text;
    Open;
    Active := True;
    end
  end;
end;

procedure Tfrm_consultusuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  edt_buscar.Clear;
  //ComboBoxConsultUsu.Text := 'Filtrar por:';
  DBGrid1.Refresh;
end;

procedure Tfrm_consultusuario.Image2Click(Sender: TObject);
begin
  case ComboBoxConsultUsu.ItemIndex of
  0: with ADOQueryConsultUsu do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_USUARIOS                                           ');
    sql.Add('Where COD_USU LIKE ''%' +  edt_buscar.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultUsu.SQL.Text;
    Open;
    Active := True;
    end;
   1:with ADOQueryConsultUsu do
    begin
      Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select*from TB_USUARIOS                                           ');
    sql.Add('Where LG_USU LIKE ''%' +  edt_buscar.text + '%''              ');
    Clipboard.AsText := ADOQueryConsultUsu.SQL.Text;
    Open;
    Active := True;
    end;
  end;
end;

procedure Tfrm_consultusuario.Image3Click(Sender: TObject);
begin
 close;
end;

procedure Tfrm_consultusuario.Image6Click(Sender: TObject);
begin
close;
end;

end.
