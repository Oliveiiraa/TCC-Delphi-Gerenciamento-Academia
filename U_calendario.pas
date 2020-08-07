unit U_calendario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, pngimage, ExtCtrls;

type
  Tfrm_calendario = class(TForm)
    Image1: TImage;
    MonthCalendar1: TMonthCalendar;
    Image9: TImage;
    procedure Image7Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_calendario: Tfrm_calendario;

implementation

{$R *.dfm}

procedure Tfrm_calendario.Image7Click(Sender: TObject);
begin
 close;
end;

procedure Tfrm_calendario.Image9Click(Sender: TObject);
begin
 close;
end;

end.
