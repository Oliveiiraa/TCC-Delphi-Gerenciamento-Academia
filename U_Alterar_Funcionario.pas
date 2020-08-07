unit U_Alterar_Funcionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, DB, ADODB, StdCtrls, Mask, ExtCtrls, ComCtrls, jpeg,
  pngimage;

type
  Tfrm_alterafunc = class(TForm)
    lbl_nomefunc: TLabel;
    lbl_enderecofunc: TLabel;
    lbl_cpffunc: TLabel;
    lbl_rgfunc: TLabel;
    lbl_telefonefunc: TLabel;
    lbl_alterdatanascfunc: TLabel;
    lbl_emailfunc: TLabel;
    Image_AlterFunc: TImage;
    lbl_sexofunc: TLabel;
    lbl_statusfunc: TLabel;
    edt_nomefunc: TEdit;
    edt_enderecofunc: TEdit;
    edt_emailfunc: TEdit;
    btn_carregarfotofunc: TButton;
    btn_salvarcadfun: TButton;
    edt_foto: TEdit;
    MaskEdittel: TMaskEdit;
    ComboBoxsexofunc: TComboBox;
    ComboBoxstatusfunc: TComboBox;
    ADOConnectionAlterFunc: TADOConnection;
    ADOStoredProcAlterFunc: TADOStoredProc;
    edt_codfunc: TEdit;
    MaskEditdataNasc: TMaskEdit;
    OpenPictureDialogAlterFunc: TOpenPictureDialog;
    edt_codusu: TEdit;
    Image1: TImage;
    Image2: TImage;
    btn_limpar: TButton;
    Image6: TImage;
    Image3: TImage;
    Image4: TImage;
    MaskEditRGFunc: TMaskEdit;
    MaskEditCPFFUNC: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_salvarcadfunClick(Sender: TObject);
    procedure btn_carregarfotofuncClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure ComboBoxstatusfuncKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxsexofuncKeyPress(Sender: TObject; var Key: Char);
    procedure MaskEditCPFFUNCExit(Sender: TObject);
    procedure edt_nomefuncKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function isCPF(CPF: string): boolean;
    function imprimeCPF(CPF: string): string;
  end;

var
  frm_alterafunc: Tfrm_alterafunc;

implementation

uses U_Consultar_Funcionario;

{$R *.dfm}

procedure Tfrm_alterafunc.btn_carregarfotofuncClick(Sender: TObject);
begin
   if OpenPictureDialogAlterFunc.Execute then
  begin
    Image_AlterFunc.Picture.LoadFromFile(OpenPictureDialogAlterFunc.FileName);
    edt_foto.Text := OpenPictureDialogAlterFunc.FileName;
    Image_AlterFunc.Visible := True;
  end;
end;

procedure Tfrm_alterafunc.btn_salvarcadfunClick(Sender: TObject);
var
  ano, mes, dia : string;
begin
  try
  begin
    ADOStoredProcAlterFunc.Parameters[1].Value := edt_codfunc.Text;
    ADOStoredProcAlterFunc.Parameters[2].Value := edt_nomefunc.Text;
    ADOStoredProcAlterFunc.Parameters[3].Value := edt_enderecofunc.Text;
    ADOStoredProcAlterFunc.Parameters[4].Value := MaskEditCPFFUNC.Text;
    ADOStoredProcAlterFunc.Parameters[5].Value := MaskEditRGFunc.Text;
    ADOStoredProcAlterFunc.Parameters[6].Value := MaskEdittel.Text;
    ano := copy(MaskEditdataNasc.Text,7,4);
    mes := copy(MaskEditdataNasc.Text,4,2);
    dia := copy(MaskEditdataNasc.Text,1,2);
    ADOStoredProcAlterFunc.Parameters[7].Value := ano + mes + dia;
    ADOStoredProcAlterFunc.Parameters[8].Value := edt_emailfunc.Text;
    ADOStoredProcAlterFunc.Parameters[9].Value := ComboBoxsexofunc.Text;
    ADOStoredProcAlterFunc.Parameters[10].Value := ComboBoxstatusfunc.ItemIndex;
    ADOStoredProcAlterFunc.Parameters[11].Value := edt_foto.Text;
    ADOStoredProcAlterFunc.Parameters[12].Value := edt_codusu.Text;
    ADOStoredProcAlterFunc.ExecProc;

    MessageDlg('Funcion�rio alterado com sucesso !',mtConfirmation,[mbOK],0);

    edt_foto.Clear;
    Image_AlterFunc.visible := false;
    frm_alterafunc.Close;
    frm_consultafunc.ADOQueryconsultafunc.Close;
    frm_consultafunc.ADOQueryconsultafunc.Open;
    frm_consultafunc.DBGridconsultafunc.Refresh;
    frm_consultafunc.ADOQueryconsultafunc.Refresh;
  end
  finally

  end;
end;

procedure Tfrm_alterafunc.ComboBoxsexofuncKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_alterafunc.ComboBoxstatusfuncKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_alterafunc.edt_nomefuncKeyPress(Sender: TObject; var Key: Char);
begin
  if key in ['A'..'Z','a'..'z',#32,#8,'-'] then
  begin
     key := key;

  end
  else
  begin
    key := #0;
  end;
end;

procedure Tfrm_alterafunc.FormShow(Sender: TObject);
begin
  if (edt_foto.Text = EmptyStr) and (Image_AlterFunc.Visible = false) then
  begin
    Image_AlterFunc.Visible := True;
    Image_AlterFunc.Picture.LoadFromFile('C:\images.PNG');
  end
  else if (edt_foto.Text = EmptyStr) and (Image_AlterFunc.Visible = True) then
  begin
    Image_AlterFunc.Picture.LoadFromFile('C:\images.PNG');
  end
  else
  begin
    Image_AlterFunc.Visible := True;
    Image_AlterFunc.Picture.LoadFromFile(edt_foto.Text);
  end;
end;

procedure Tfrm_alterafunc.Image2Click(Sender: TObject);
var
  ano, mes, dia,a,b,c,datac1 : string;
begin
  if edt_nomefunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o nome!',mtInformation,[mbOK],0);
    edt_nomefunc.SetFocus;
    Exit;
  end

  else if MaskEditCPFFUNC.Text = '   .   .   -  ' then
  begin
    MessageDlg('Entre com o CPF!',mtInformation,[mbOK],0);
    MaskEditCPFFUNC.SetFocus;
    Exit;
  end

  else if MaskEditRGFunc.Text = '  .   .   - ' then
  begin
    MessageDlg('Entre com o RG!',mtInformation,[mbOK],0);
    MaskEditRGFunc.SetFocus;
    Exit;
  end

  else if MaskEditdatanasc.Text = '  /  /    ' then
  begin
    MessageDlg('Entre com a data de nascimento!',mtInformation,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end;

  a := copy(MaskEditdatanasc.Text,1,2);
  b := copy(MaskEditdatanasc.Text,4,2);
  c := copy(MaskEditdatanasc.Text,7,4);

  if  a >= '32' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end

  else if b >= '13' then
  begin
    MessageDlg('Data inv�lida',mtInformation,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end

  else if edt_enderecofunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o endere�o!',mtInformation,[mbOK],0);
    edt_enderecofunc.SetFocus;
    Exit;
  end

  else if MaskEdittel.Text = '(  )     -    ' then
  begin
    MessageDlg('Entre com o celular!',mtInformation,[mbOK],0);
    MaskEdittel.SetFocus;
    Exit;
  end

  {else if ComboBoxsexofunc.ItemIndex = -1 then
  begin
    MessageDlg('Selecione o Sexo !',mtError,[mbOK],0);
    ComboBoxsexofunc.SetFocus;
    Exit;
  end}

  else if edt_emailfunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o e-mail!',mtInformation,[mbOK],0);
    edt_emailfunc.SetFocus;
    Exit;
  end;

  datac1 := DateToStr(Date);

   if datac1 <= MaskEditdataNasc.Text then
    begin
      MessageDlg('Data inv�lida!',mtInformation,[mbOK],0);
      exit;
    end;

   try
  begin
    ADOStoredProcAlterFunc.Parameters[1].Value := edt_codfunc.Text;
    ADOStoredProcAlterFunc.Parameters[2].Value := edt_nomefunc.Text;
    ADOStoredProcAlterFunc.Parameters[3].Value := edt_enderecofunc.Text;
    MaskEditCPFFUNC.EditMask := '!999.999.999-99;1;_';  /////
    ADOStoredProcAlterFunc.Parameters[4].Value := MaskEditCPFFUNC.Text;
    ADOStoredProcAlterFunc.Parameters[5].Value := MaskEditRGFunc.Text;
    ADOStoredProcAlterFunc.Parameters[6].Value := MaskEdittel.Text;
    ano := copy(MaskEditdataNasc.Text,7,4);
    mes := copy(MaskEditdataNasc.Text,4,2);
    dia := copy(MaskEditdataNasc.Text,1,2);
    ADOStoredProcAlterFunc.Parameters[7].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProcAlterFunc.Parameters[8].Value := edt_emailfunc.Text;
    ADOStoredProcAlterFunc.Parameters[9].Value := ComboBoxsexofunc.Text;
    ADOStoredProcAlterFunc.Parameters[10].Value := ComboBoxstatusfunc.ItemIndex;
    ADOStoredProcAlterFunc.Parameters[11].Value := edt_foto.Text;
    ADOStoredProcAlterFunc.Parameters[12].Value := edt_codusu.Text;

    ADOStoredProcAlterFunc.ExecProc;

    MessageDlg('Funcion�rio alterado com sucesso!',mtConfirmation,[mbOK],0);

    edt_foto.Clear;
    Image_AlterFunc.visible := false;
    frm_alterafunc.Close;
    frm_consultafunc.ADOQueryconsultafunc.Close;
    frm_consultafunc.ADOQueryconsultafunc.Open;
    frm_consultafunc.ADOQueryconsultafunc.Refresh;
    frm_consultafunc.DBGridconsultafunc.Refresh;
  end
  finally

  end;
end;

procedure Tfrm_alterafunc.Image3Click(Sender: TObject);
begin
   if OpenPictureDialogAlterFunc.Execute then
  begin
    Image_AlterFunc.Picture.LoadFromFile(OpenPictureDialogAlterFunc.FileName);
    edt_foto.Text := OpenPictureDialogAlterFunc.FileName;
    Image_AlterFunc.Visible := True;
  end;
end;

procedure Tfrm_alterafunc.Image6Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente sair? Nenhum dado ser� alterado!','Aten��o',MB_ICONQUESTION + MB_YESNO) = IDNO then
 begin

 end

 else
 begin
   frm_alterafunc.Close;
 end;
end;

function Tfrm_alterafunc.imprimeCPF(CPF: string): string;
begin
  imprimeCPF := copy(CPF, 1, 3) + '.' + copy(CPF, 4, 3) + '.' +
    copy(CPF, 7, 3) + '-' + copy(CPF, 10, 2);
end;

function Tfrm_alterafunc.isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
  // length - retorna o tamanho da string do CPF (CPF � um n�mero formado por 11 d�gitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
            isCPF := false;
            exit;
          end;

// "try" - protege o c�digo para eventuais erros de convers�o de tipo atrav�s da fun��o "StrToInt"
  try
{ *-- C�lculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-�simo caractere do CPF em um n�mero
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um n�mero no respectivo caractere num�rico

{ *-- C�lculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then isCPF := true
    else isCPF := false;
  except
    isCPF := false
  end;
end;

procedure Tfrm_alterafunc.MaskEditCPFFUNCExit(Sender: TObject);
begin
  if (MaskEditCPFFUNC.Text = '   .   .   -  ') or (MaskEditCPFFUNC.Text = EmptyStr) then
   begin
     MessageDlg('� necess�rio preencher o CPF, corretamente!',mtError,[mbOK],0);
     MaskEditCPFFUNC.SetFocus;
     exit;
   end;

    MaskEditCPFFUNC.EditMask := '!999.999.999-99;0;_';  /////
    if isCPF(MaskEditCPFFUNC.Text) then
    begin
         Exit;
    end
    else
    begin
          MessageDlg('CPF inv�lido!',mtInformation,[mbOK],0);
          MaskEditCPFFUNC.SetFocus;
          Exit;
    end
end;

end.
