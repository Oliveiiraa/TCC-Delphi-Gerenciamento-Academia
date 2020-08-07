unit U_Medidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, pngimage, ExtCtrls;

type
  Tfrm_medidas = class(TForm)
    Image2: TImage;
    lbl_nomeclimedidas: TLabel;
    lbl_dataavaliacaofisica: TLabel;
    lbl_peso: TLabel;
    lbl_altura: TLabel;
    lbl_biceps: TLabel;
    lbl_triceps: TLabel;
    lbl_peitoral: TLabel;
    lbl_quadril: TLabel;
    lbl_cintura: TLabel;
    lbl_coxa: TLabel;
    lbl_ombro: TLabel;
    lbl_panturrilha: TLabel;
    Image1: TImage;
    edt_nomeclimedidas: TEdit;
    edt_peso: TEdit;
    edt_altura: TEdit;
    edt_biceps: TEdit;
    edt_triceps: TEdit;
    edt_peitoral: TEdit;
    edt_quadril: TEdit;
    edt_cintura: TEdit;
    edt_coxa: TEdit;
    edt_ombro: TEdit;
    edt_panturrilha: TEdit;
    MaskEditdataavaliacao: TMaskEdit;
    Editcodigo: TEdit;
    Image7: TImage;
    procedure Image7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_medidas: Tfrm_medidas;

implementation

{$R *.dfm}

procedure Tfrm_medidas.Image7Click(Sender: TObject);
begin
 close;
end;

end.
