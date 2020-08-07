unit U_Calcular_IMC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, pngimage;

type
  Tfrm_calimc = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ed_pc: TEdit;
    ed_alt: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    ed_result: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Image1: TImage;
    ImageCancelar: TImage;
    Image2: TImage;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure ImageCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_calimc: Tfrm_calimc;

implementation

{$R *.dfm}

function IMC(massa, altura: real): real;
begin
  IMC := massa / (altura * altura);
end;

function faixaIMC(vlrIMC: real): integer;
begin
  if (vlrIMC < 18.5)
     then faixaIMC := 1
  else if ((vlrIMC >= 18.5) and (vlrIMC < 25.0))
          then faixaIMC := 2
       else if ((vlrIMC >= 25.0) and (vlrIMC < 30.0))
               then faixaIMC := 3
            else if ((vlrIMC >= 30.0) and (vlrIMC < 35.0))
                    then faixaIMC := 4
                 else if ((vlrIMC >= 35.0) and (vlrIMC < 40.0))
                         then faixaIMC := 5
                     // Valor de IMC maior ou igual a 40,0
                     else faixaIMC := 6;
end;


procedure Tfrm_calimc.BitBtn1Click(Sender: TObject);
begin
  ed_pc.Clear;
  ed_alt.Clear;
  ed_result.Clear;
end;

procedure Tfrm_calimc.btn_fecharClick(Sender: TObject);
begin
  ed_pc.Clear;
  ed_alt.Clear;
  ed_result.Clear;
  Panel1.Visible := False;
  Panel2.Visible := False;
  panel3.Visible := False;
  Panel4.Visible := False;
  Panel5.Visible := False;
  Panel6.Visible := False;
  close;
end;

procedure Tfrm_calimc.Button1Click(Sender: TObject);
var massa, altura, vlrIMC: real;
                    faixa: integer;
begin
  try
    massa := StrToFloat(ed_pc.Text);
    altura := StrToFloat(ed_alt.Text);

    vlrIMC := IMC(massa, altura);
    faixa := faixaIMC(vlrIMC);

    ed_result.Text := FloatToStr(vlrIMC);
  except
  end;

  if vlrIMC < 18.5 then
  begin
    Panel1.Visible := True;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 18.5) and (vlrIMC < 25.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := True;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 25.0) and (vlrIMC < 30.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := True;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 30.0) and (vlrIMC < 35.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := True;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 35.0) and (vlrIMC < 40.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := True;
    Panel6.Visible := False;
  end

  else
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := True;
  end;

end;

procedure Tfrm_calimc.GroupBox1Click(Sender: TObject);
var massa, altura, vlrIMC: real;
                    faixa: integer;
begin
  try
    massa := StrToFloat(ed_pc.Text);
    altura := StrToFloat(ed_alt.Text);

    vlrIMC := IMC(massa, altura);
    faixa := faixaIMC(vlrIMC);

    ed_result.Text := FloatToStr(vlrIMC);
  except
  end;

  if vlrIMC < 18.5 then
  begin
    Panel1.Visible := True;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 18.5) and (vlrIMC < 25.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := True;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 25.0) and (vlrIMC < 30.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := True;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 30.0) and (vlrIMC < 35.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := True;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 35.0) and (vlrIMC < 40.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := True;
    Panel6.Visible := False;
  end

  else
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := True;
  end;

end;


procedure Tfrm_calimc.Image2Click(Sender: TObject);
var massa, altura, vlrIMC: real;
                    faixa: integer;
begin
  try
    massa := StrToFloat(ed_pc.Text);
    altura := StrToFloat(ed_alt.Text);

    vlrIMC := IMC(massa, altura);
    faixa := faixaIMC(vlrIMC);

    ed_result.Text := FloatToStr(vlrIMC);
  except
  end;

  if vlrIMC < 18.5 then
  begin
    Panel1.Visible := True;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 18.5) and (vlrIMC < 25.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := True;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 25.0) and (vlrIMC < 30.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := True;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 30.0) and (vlrIMC < 35.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := True;
    Panel5.Visible := False;
    Panel6.Visible := False;
  end

  else if (vlrIMC >= 35.0) and (vlrIMC < 40.0) then
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := True;
    Panel6.Visible := False;
  end

  else
  begin
    Panel1.Visible := False;
    Panel2.Visible := False;
    Panel3.Visible := False;
    Panel4.Visible := False;
    Panel5.Visible := False;
    Panel6.Visible := True;
  end
end;

procedure Tfrm_calimc.ImageCancelarClick(Sender: TObject);
begin
     ed_pc.Clear;
  ed_alt.Clear;
  ed_result.Clear;
  Panel1.Visible := False;
  Panel2.Visible := False;
  panel3.Visible := False;
  Panel4.Visible := False;
  Panel5.Visible := False;
  Panel6.Visible := False;
  close;
end;

end.
