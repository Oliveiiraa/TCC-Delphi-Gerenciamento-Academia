unit U_Info_Sistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  Tfrm_infosistema = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Image9: TImage;
    Label24: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    procedure Image6Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_infosistema: Tfrm_infosistema;

implementation

{$R *.dfm}

procedure Tfrm_infosistema.Image6Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_infosistema.Image9Click(Sender: TObject);
begin
 close;
end;

end.
