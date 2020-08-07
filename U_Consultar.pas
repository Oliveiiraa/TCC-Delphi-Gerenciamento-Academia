unit U_Consultar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  Tfrm_consultar = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image6: TImage;
    procedure btn_consultarclienteClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_consultarfuncionarioClick(Sender: TObject);
    procedure btn_consultusuClick(Sender: TObject);
    procedure btn_consultarmensalidadesClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_consultar: Tfrm_consultar;

implementation

uses U_Consultar_Cliente, U_Consultar_Funcionario, U_Consultar_Usu�rio,
  U_Consultar_Mensalidades, U_Login_Sistema;

{$R *.dfm}

procedure Tfrm_consultar.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_consultar.btn_consultarclienteClick(Sender: TObject);
begin
  frm_consultacli.ShowModal;
end;

procedure Tfrm_consultar.btn_consultarfuncionarioClick(Sender: TObject);
begin
  frm_consultafunc.ShowModal;
end;

procedure Tfrm_consultar.btn_consultarmensalidadesClick(Sender: TObject);
begin
  frm_consultmensa.ShowModal;
end;

procedure Tfrm_consultar.btn_consultusuClick(Sender: TObject);
begin
  frm_consultusuario.ShowModal;
end;

procedure Tfrm_consultar.Image2Click(Sender: TObject);
begin
 frm_consultacli.ShowModal;
end;

procedure Tfrm_consultar.Image3Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultafunc.ShowModal;
  end
  else
  begin
    MessageDlg('Voc� n�o tem permiss�o para consultar funcion�rio!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_consultar.Image4Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultusuario.ShowModal;
  end
  else
  begin
    MessageDlg('Voc� n�o tem permiss�o para consultar usu�rio!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_consultar.Image5Click(Sender: TObject);
begin
  frm_consultmensa.ShowModal;
end;

procedure Tfrm_consultar.Image6Click(Sender: TObject);
begin
 close;
end;

end.
