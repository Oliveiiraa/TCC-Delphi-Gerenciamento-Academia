unit U_opcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls;

type
  Tfrm_opcoes = class(TForm)
    procedure Image7Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_opcoes: Tfrm_opcoes;

implementation

uses U_Calcular_IMC, U_Principal;

{$R *.dfm}

procedure Tfrm_opcoes.Image4Click(Sender: TObject);
begin
  U_Calcular_IMC.frm_calimc.ShowModal;
end;

procedure Tfrm_opcoes.Image7Click(Sender: TObject);
begin
 close;
end;

end.
