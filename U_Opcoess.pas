unit U_Opcoess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, Shellapi;

type
  Tfrm_opcoess = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image4: TImage;
    Image5: TImage;
    Image3: TImage;
    Image8: TImage;
    Image10: TImage;
    imgclose: TImage;
    imgoogle: TImage;
    procedure Image7Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
   // procedure img6Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure imgcloseClick(Sender: TObject);
    procedure imgoogleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_opcoess: Tfrm_opcoess;

implementation

uses U_Calcular_IMC, U_calendario, U_Info_Sistema;

{$R *.dfm}

procedure Tfrm_opcoess.Image10Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, 'C:\Sistema Bio Ritmo\MANUAL DO USUARIO.pdf',nil,nil,SW_SHOWNORMAL);
end;

procedure Tfrm_opcoess.Image2Click(Sender: TObject);
begin
  WinExec('Calc.Exe',SW_Show);
end;

procedure Tfrm_opcoess.Image3Click(Sender: TObject);
begin
   ShellExecute(0, Nil, PChar('www.facebook.com.br'), Nil, Nil, 0);
end;

procedure Tfrm_opcoess.Image4Click(Sender: TObject);
begin
 frm_calimc.ShowModal;
end;

procedure Tfrm_opcoess.Image5Click(Sender: TObject);
begin
 frm_calendario.ShowModal;
end;
procedure Tfrm_opcoess.Image7Click(Sender: TObject);
begin
 close;
end;

procedure Tfrm_opcoess.Image8Click(Sender: TObject);
begin
  frm_infosistema.ShowModal;
end;

procedure Tfrm_opcoess.Image9Click(Sender: TObject);
begin
 close;
end;

procedure Tfrm_opcoess.imgcloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_opcoess.imgoogleClick(Sender: TObject);
begin
   ShellExecute(0, Nil, PChar('www.google.com.br'), Nil, Nil, 0);
end;

end.
