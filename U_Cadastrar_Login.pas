unit U_Cadastrar_Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, pngimage;

type
  Tfrm_cadaslogin = class(TForm)
    lbl_nomelogin: TLabel;
    lbl_login: TLabel;
    lbl_senhalogin: TLabel;
    edt_nomelogin: TEdit;
    edt_login: TEdit;
    edt_senhalogin: TEdit;
    bnt_salvarlogin: TButton;
    bnt_cancelarlogin: TButton;
    rdg_tipousuario: TRadioGroup;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Image1: TImage;
    procedure bnt_cancelarloginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cadaslogin: Tfrm_cadaslogin;

implementation

uses U_Cadastrar;

{$R *.dfm}

procedure Tfrm_cadaslogin.bnt_cancelarloginClick(Sender: TObject);
begin
  Close;
end;

end.
