unit U_Cadastrar_Funcionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, DB, ADODB, StdCtrls, Mask, ExtCtrls, jpeg, pngimage;

type
  Tfrm_cadasfunc = class(TForm)
    lbl_nomefunc: TLabel;
    lbl_enderecofunc: TLabel;
    lbl_cpffunc: TLabel;
    lbl_rgfunc: TLabel;
    lbl_telefonefunc: TLabel;
    lbl_datanascfunc: TLabel;
    lbl_emailfunc: TLabel;
    lbl_sexofunc: TLabel;
    edt_nomefunc: TEdit;
    edt_enderecofunc: TEdit;
    edt_emailfunc: TEdit;
    btn_carregarfotofunc: TButton;
    btn_salvarcadfun: TButton;
    btn_limpar: TButton;
    edt_foto: TEdit;
    MaskEditdatanasc: TMaskEdit;
    MaskEdittel: TMaskEdit;
    ComboBoxsexofunc: TComboBox;
    ComboBoxstatusfunc: TComboBox;
    ADOConnection1: TADOConnection;
    ADOStoredProc1: TADOStoredProc;
    OpenPictureDialog1: TOpenPictureDialog;
    OpenDialog1: TOpenDialog;
    edt_codusu: TEdit;
    Image_cadastrofunc: TImage;
    Image1: TImage;
    Image3: TImage;
    Image6: TImage;
    Image2: TImage;
    Image4: TImage;
    MaskEditRGFuncCadas: TMaskEdit;
    MaskEditCPFFuncCadas: TMaskEdit;
    procedure btn_salvarcadfunClick(Sender: TObject);
    procedure btn_limparClick(Sender: TObject);
    procedure btn_carregarfotofuncClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure ComboBoxsexofuncKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxstatusfuncKeyPress(Sender: TObject; var Key: Char);
    procedure MaskEditCPFFuncCadasExit(Sender: TObject);
    procedure edt_nomefuncKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function isCPF(CPF: string): boolean;
    function imprimeCPF(CPF: string): string;
  end;

var
  frm_cadasfunc: Tfrm_cadasfunc;

implementation

uses U_Cadastrar, U_Consultar_Funcionario, U_Verifica_CPF, U_Login_Sistema,
  U_Cadastrar_Despesas;

{$R *.dfm}

procedure Tfrm_cadasfunc.btn_carregarfotofuncClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    Image_cadastrofunc.Picture.LoadFromFile(OpenDialog1.FileName);
    edt_foto.Text := OpenDialog1.FileName;
    Image_cadastrofunc.Visible := True;
  end;
end;

procedure Tfrm_cadasfunc.btn_limparClick(Sender: TObject);
begin
  edt_nomefunc.Clear;
  edt_enderecofunc.Clear;
  MaskEditRGFuncCadas.Clear;
  MaskEditCPFFuncCadas.Clear;
  MaskEdittel.Clear;
  edt_emailfunc.Clear;
  edt_foto.Clear;
  ComboBoxsexofunc.ItemIndex := -1;
  ComboBoxstatusfunc.ItemIndex := -1;
  MaskEditdatanasc.Clear;
end;

procedure Tfrm_cadasfunc.btn_salvarcadfunClick(Sender: TObject);
var
ano, mes, dia : string;
begin
  if edt_nomefunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o nome!',mtError,[mbOK],0);
    edt_nomefunc.SetFocus;
    Exit;
  end

  else if edt_enderecofunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o endere�o!',mtError,[mbOK],0);
    edt_enderecofunc.SetFocus;
    Exit;
  end

  else if MaskEditCPFFuncCadas.Text = EmptyStr then
  begin
    MessageDlg('Entre com o CPF!',mtError,[mbOK],0);
    MaskEditCPFFuncCadas.SetFocus;
    Exit;
  end

  else if MaskEditRGFuncCadas.Text = EmptyStr then
  begin
    MessageDlg('Entre com o RG!',mtError,[mbOK],0);
    MaskEditRGFuncCadas.SetFocus;
    Exit;
  end

  else if MaskEdittel.Text = EmptyStr then
  begin
    MessageDlg('Entre com o telefone!',mtError,[mbOK],0);
    MaskEdittel.SetFocus;
    Exit;
  end

  else if MaskEditdatanasc.Text = EmptyStr then
  begin
    MessageDlg('Entre com a data de nascimento!',mtError,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end

  else if edt_emailfunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o e-mail!',mtError,[mbOK],0);
    edt_emailfunc.SetFocus;
    Exit;
  end

  else if ComboBoxsexofunc.ItemIndex = -1 then
  begin
    MessageDlg('Selecione o sexo!',mtError,[mbOK],0);
    ComboBoxsexofunc.SetFocus;
    Exit;
  end;

  {if isCPF(edt_cpffunc.Text)
     then Result.Caption := imprimeCPF(CPF.Text)
  else
  begin
  showmessage ('Erro: CPF inv�lido !!!');
  end;}

  try
  begin
    ADOStoredProc1.Parameters[1].Value := edt_nomefunc.Text;
    ADOStoredProc1.Parameters[2].Value := edt_enderecofunc.Text;
    ADOStoredProc1.Parameters[3].Value := MaskEditCPFFuncCadas.Text;
    ADOStoredProc1.Parameters[4].Value := MaskEditRGFuncCadas.Text;
    ADOStoredProc1.Parameters[5].Value := MaskEdittel.Text;
    ano := copy(MaskEditdatanasc.Text,7,4);
    mes := copy(MaskEditdatanasc.Text,4,2);
    dia := copy(MaskEditdatanasc.Text,1,2);
    ADOStoredProc1.Parameters[6].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProc1.Parameters[7].Value := edt_emailfunc.Text;
    ADOStoredProc1.Parameters[8].Value := ComboBoxsexofunc.Text;
    ComboBoxstatusfunc.ItemIndex := 0;
    ADOStoredProc1.Parameters[9].Value := ComboBoxstatusfunc.ItemIndex;
    ADOStoredProc1.Parameters[10].Value := edt_foto.Text;
    ADOStoredProc1.Parameters[11].Value := edt_codusu.Text;

    ///////////ADOQueryconsultafunc.Close;
    ///Form_consultafunc.ADOQueryconsultafunc.Open;
    ///Form_consultafunc.DBGridconsultafunc.Update;

    U_Cadastrar_Despesas.frm_cadasdespesas.ADOQueryCadasDespesas.Close;
    U_Cadastrar_Despesas.frm_cadasdespesas.ADOQueryCadasDespesas.Open;
    U_Cadastrar_Despesas.frm_cadasdespesas.ADOQueryCadasDespesas.Refresh;

    ADOStoredProc1.ExecProc;

    MessageDlg('Funcion�rio cadastrado com sucesso!',mtConfirmation,[mbOK],0);

    frm_cadasfunc.Close;
    edt_nomefunc.Clear;
    edt_enderecofunc.Clear;
    MaskEditCPFFuncCadas.Clear;
    MaskEditRGFuncCadas.Clear;
    edt_emailfunc.Clear;
    edt_foto.Clear;
    MaskEditdatanasc.Clear;
    MaskEdittel.Clear;
    edt_codusu.Clear;
    Image_cadastrofunc.Picture.LoadFromFile('C:\images.PNG');
  end
  finally

  end;
end;

procedure Tfrm_cadasfunc.ComboBoxsexofuncKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_cadasfunc.ComboBoxstatusfuncKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_cadasfunc.edt_nomefuncKeyPress(Sender: TObject; var Key: Char);
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

procedure Tfrm_cadasfunc.FormShow(Sender: TObject);
begin
  Image_cadastrofunc.Picture.LoadFromFile('C:\images.PNG');
  U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Last;
  U_Cadastrar_Funcionario.frm_cadasfunc.edt_codusu.Text := U_Login_Sistema.frm_loginsistema.ADOQueryLoginCOD_USU.AsString;
end;

procedure Tfrm_cadasfunc.Image2Click(Sender: TObject);
begin
     if OpenDialog1.Execute then
  begin
    Image_cadastrofunc.Picture.LoadFromFile(OpenDialog1.FileName);
    edt_foto.Text := OpenDialog1.FileName;
    Image_cadastrofunc.Visible := True;
  end;
end;

procedure Tfrm_cadasfunc.Image3Click(Sender: TObject);
var
ano, mes, dia, a, b, c,datac1 : string;
begin
   if edt_nomefunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o nome!',mtInformation,[mbOK],0);
    edt_nomefunc.SetFocus;
    Exit;
  end

  else if MaskEditCPFFuncCadas.Text = '   .   .   -  ' then
  begin
    MessageDlg('Entre com o CPF!',mtInformation,[mbOK],0);
    MaskEditCPFFuncCadas.SetFocus;
    Exit;
  end

  else if MaskEditRGFuncCadas.Text = '  .   .   - ' then
  begin
    MessageDlg('Entre com o RG!',mtInformation,[mbOK],0);
    MaskEditRGFuncCadas.SetFocus;
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

  else if ComboBoxsexofunc.ItemIndex = -1 then
  begin
    MessageDlg('Selecione o sexo!',mtInformation,[mbOK],0);
    ComboBoxsexofunc.SetFocus;
    Exit;
  end

  else if edt_emailfunc.Text = EmptyStr then
  begin
    MessageDlg('Entre com o e-mail!',mtInformation,[mbOK],0);
    edt_emailfunc.SetFocus;
    Exit;
  end;

  datac1 := DateToStr(Date);

   {if datac1 <= MaskEditdatanasc.Text then
    begin
      MessageDlg('Data inv�lida!',mtInformation,[mbOK],0);
      exit;
    end;}

  {if isCPF(edt_cpffunc.Text)
     then Result.Caption := imprimeCPF(CPF.Text)
  else
  begin
  showmessage ('Erro: CPF inv�lido !!!');
  end;}

  try
  begin
    ADOStoredProc1.Parameters[1].Value := edt_nomefunc.Text;
    ADOStoredProc1.Parameters[2].Value := edt_enderecofunc.Text;
    MaskEditCPFFuncCadas.EditMask := '!999.999.999-99;1;_';  /////
    ADOStoredProc1.Parameters[3].Value := MaskEditCPFFuncCadas.Text;
    ADOStoredProc1.Parameters[4].Value := MaskEditRGFuncCadas.Text;
    ADOStoredProc1.Parameters[5].Value := MaskEdittel.Text;
    ano := copy(MaskEditdatanasc.Text,7,4);
    mes := copy(MaskEditdatanasc.Text,4,2);
    dia := copy(MaskEditdatanasc.Text,1,2);
    ADOStoredProc1.Parameters[6].Value := ano + '/' + mes + '/' + dia;
    ADOStoredProc1.Parameters[7].Value := edt_emailfunc.Text;
    ADOStoredProc1.Parameters[8].Value := ComboBoxsexofunc.Text;
    ComboBoxstatusfunc.ItemIndex := 0;
    ADOStoredProc1.Parameters[9].Value := ComboBoxstatusfunc.ItemIndex;
    ADOStoredProc1.Parameters[10].Value := edt_foto.Text;
    ADOStoredProc1.Parameters[11].Value := edt_codusu.Text;

    ///////////ADOQueryconsultafunc.Close;
    ///Form_consultafunc.ADOQueryconsultafunc.Open;
    ///Form_consultafunc.DBGridconsultafunc.Update;

    ADOStoredProc1.ExecProc;

    MessageDlg('Funcion�rio cadastrado com sucesso!',mtConfirmation,[mbOK],0);

   U_Cadastrar_Despesas.frm_cadasdespesas.ADOQueryCadasDespesas.Close;
  U_Cadastrar_Despesas.frm_cadasdespesas.ADOQueryCadasDespesas.Open;
  U_Cadastrar_Despesas.frm_cadasdespesas.ADOQueryCadasDespesas.Refresh;
    frm_cadasfunc.Close;
    edt_nomefunc.Clear;
    edt_enderecofunc.Clear;
    MaskEditCPFFuncCadas.Clear;
    MaskEditRGFuncCadas.Clear;
    edt_emailfunc.Clear;
    edt_foto.Clear;
    MaskEditdatanasc.Clear;
    MaskEdittel.Clear;
    edt_codusu.Clear;
    Image_cadastrofunc.Picture.LoadFromFile('C:\images.PNG');
    ComboBoxsexofunc.ItemIndex := -1;
    ComboBoxstatusfunc.ItemIndex := -1;
  end
  finally

  end;
end;

procedure Tfrm_cadasfunc.Image6Click(Sender: TObject);
begin
  edt_nomefunc.Clear;
  edt_enderecofunc.Clear;
  MaskEditCPFFuncCadas.Clear;
  MaskEditRGFuncCadas.Clear;
  MaskEdittel.Clear;
  edt_emailfunc.Clear;
  edt_foto.Clear;
  ComboBoxsexofunc.ItemIndex := -1;
  ComboBoxstatusfunc.ItemIndex := -1;
  MaskEditdatanasc.Clear;
 close;
end;

function Tfrm_cadasfunc.imprimeCPF(CPF: string): string;
begin
  imprimeCPF := copy(CPF, 1, 3) + '.' + copy(CPF, 4, 3) + '.' +
    copy(CPF, 7, 3) + '-' + copy(CPF, 10, 2);
end;

function Tfrm_cadasfunc.isCPF(CPF: string): boolean;
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

procedure Tfrm_cadasfunc.MaskEditCPFFuncCadasExit(Sender: TObject);
begin
     if (MaskEditCPFFuncCadas.Text = '   .   .   -  ') or (MaskEditCPFFuncCadas.Text = EmptyStr) then
   begin
     MessageDlg('� necess�rio preencher o CPF, corretamente!',mtError,[mbOK],0);
     MaskEditCPFFuncCadas.SetFocus;
     exit;
   end;

    MaskEditCPFFuncCadas.EditMask := '!999.999.999-99;0;_';  /////
    if isCPF(MaskEditCPFFuncCadas.Text) then
    begin
         Exit;
    end
    else
    begin
          MessageDlg('CPF inv�lido!',mtInformation,[mbOK],0);
          MaskEditCPFFuncCadas.SetFocus;
          Exit;
    end
end;

end.
