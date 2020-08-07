unit U_Cadastrar_Cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, DB, ADODB, StdCtrls, Mask, ExtCtrls, jpeg, pngimage;

type
  Tfrm_cadastrarcli = class(TForm)
    lbl_nomecli: TLabel;
    lbl_datanasccli: TLabel;
    lbl_cpfcli: TLabel;
    lbl_rgcli: TLabel;
    lbl_enderecocli: TLabel;
    lbl_telefonecli: TLabel;
    lbl_datamatriculacli: TLabel;
    lbl_emailcli: TLabel;
    Image_cadastrocli: TImage;
    lbl_sexocli: TLabel;
    edt_nomecli: TEdit;
    edt_enderecocli: TEdit;
    edt_emailcli: TEdit;
    btn_carrerfotocli: TButton;
    btn_salvarcasdastrocli: TButton;
    btn_limpar: TButton;
    MaskEditdatanasc: TMaskEdit;
    MaskEditdatamatric: TMaskEdit;
    MaskEdittelefone: TMaskEdit;
    edt_foto: TEdit;
    ComboBoxsexocli: TComboBox;
    ComboBoxstatuscli: TComboBox;
    ADOConnectionCadasCli: TADOConnection;
    ADOStoredProcCadasCli: TADOStoredProc;
    ADOQueryCadascli: TADOQuery;
    OpenPictureDialogCadascli: TOpenPictureDialog;
    edt_usuario: TEdit;
    lbl_tipot: TLabel;
    ComboBoxTipoTreino: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image5: TImage;
    Image6: TImage;
    Image3: TImage;
    MaskEdit1: TMaskEdit;
    MaskEditRG: TMaskEdit;
    ADOQueryCadascliCOD_CLI: TAutoIncField;
    ADOQueryCadascliNM_CLI: TStringField;
    ADOQueryCadascliEND_CLI: TStringField;
    ADOQueryCadascliCPF_CLI: TStringField;
    ADOQueryCadascliRG_CLI: TStringField;
    ADOQueryCadascliTEL_CLI: TStringField;
    ADOQueryCadascliDTMATRI_CLI: TWideStringField;
    ADOQueryCadascliDTNASC_CLI: TWideStringField;
    ADOQueryCadascliEML_CLI: TStringField;
    ADOQueryCadascliSTA_CLI: TBooleanField;
    ADOQueryCadascliSX_CLI: TStringField;
    ADOQueryCadascliFT_CLI: TStringField;
    ADOQueryCadascliTPT_CLI: TStringField;
    ADOQueryCadascliCOD_USU: TIntegerField;
    procedure btn_limparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure ComboBoxTipoTreinoKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxsexocliKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxstatuscliKeyPress(Sender: TObject; var Key: Char);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure edt_nomecliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function isCPF(CPF: string): boolean;
    function imprimeCPF(CPF: string): string;
  end;

var
  frm_cadastrarcli: Tfrm_cadastrarcli;

implementation

uses U_Cadastrar, U_Cadastrar_Medidas, U_Consultar_Cliente, U_Login_Sistema,
  U_Cadastrar_Mensalidades, U_Aniversariantes;

{$R *.dfm}

procedure Tfrm_cadastrarcli.btn_limparClick(Sender: TObject);
begin
  edt_nomecli.Clear;
  MaskEdit1.Clear;
  MaskEditRG.Clear;
  edt_enderecocli.Clear;
  edt_emailcli.Clear;
  edt_foto.Clear;
  edt_usuario.Clear;
  MaskEditdatanasc.Clear;
  MaskEditdatamatric.Clear;
  MaskEdittelefone.Clear;
  ComboBoxTipoTreino.ItemIndex := -1;
  Image_cadastrocli.Picture.LoadFromFile('C:\images.PNG');
end;

procedure Tfrm_cadastrarcli.ComboBoxsexocliKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_cadastrarcli.ComboBoxstatuscliKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_cadastrarcli.ComboBoxTipoTreinoKeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure Tfrm_cadastrarcli.edt_nomecliKeyPress(Sender: TObject; var Key: Char);
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

procedure Tfrm_cadastrarcli.FormShow(Sender: TObject);
begin
  Image_cadastrocli.Picture.LoadFromFile('C:\images.PNG');
  edt_usuario.Text := IntToStr(U_Login_Sistema.frm_loginsistema.ADOQueryLoginCOD_USU.AsInteger);
end;

procedure Tfrm_cadastrarcli.Image3Click(Sender: TObject);
var
anomatri, mesmatri, diamatri,s,tp,a,b,c,d,e,f,datac1 : string;
anonasc, mesnasc, dianasc,fone : string;
fone1,fone2,fone3 : string;
begin
   if edt_nomecli.Text = EmptyStr then
  begin
    MessageDlg('Informe o nome!',mtInformation,[mbOK],0);
    edt_nomecli.SetFocus;
    Exit;
  end

  else if MaskEdit1.Text = '   .   .   -  ' then
  begin
    MessageDlg('Informe o CPF!',mtInformation,[mbOK],0);
    MaskEdit1.SetFocus;
    Exit;
  end

  else if MaskEditRG.Text = '  .   .   - ' then
  begin
    MessageDlg('Informe o RG!',mtInformation,[mbOK],0);
    MaskEditRG.SetFocus;
    Exit;
  end

  else if MaskEditdatanasc.Text =  '  /  /    ' then
  begin
    MessageDlg('Informe a data de nascimento!',mtInformation,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end;

  a := copy(MaskEditdatanasc.Text,1,2);
  b := copy(MaskEditdatanasc.Text,4,2);
  c := copy(MaskEditdatanasc.Text,7,4);

  if  a >= '32' then
  begin
    MessageDlg('Data inv�lida',mtError,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end

  else if b >= '13' then
  begin
    MessageDlg('Data inv�lida',mtError,[mbOK],0);
    MaskEditdatanasc.SetFocus;
    Exit;
  end

  else if edt_enderecocli.Text = EmptyStr then
  begin
    MessageDlg('Informe o endere�o!',mtInformation,[mbOK],0);
    edt_enderecocli.SetFocus;
    Exit;
  end

  else if MaskEdittelefone.Text = '(  )     -    ' then
  begin
    MessageDlg('Informe o celular!',mtInformation,[mbOK],0);
    MaskEdittelefone.SetFocus;
    Exit;
  end

  else if MaskEditdatamatric.Text =  '  /  /    ' then
  begin
    MessageDlg('Informe a data de matr�cula!',mtInformation,[mbOK],0);
    MaskEditdatamatric.SetFocus;
    Exit;
  end;

  d := copy(MaskEditdatamatric.Text,1,2);
  e := copy(MaskEditdatamatric.Text,4,2);
  f := copy(MaskEditdatamatric.Text,7,4);

  if  d >= '32' then
  begin
    MessageDlg('Data inv�lida',mtError,[mbOK],0);
    MaskEditdatamatric.SetFocus;
    Exit;
  end

  else if e >= '13' then
  begin
    MessageDlg('Data inv�lida',mtError,[mbOK],0);
    MaskEditdatamatric.SetFocus;
    Exit;
  end

  else if edt_emailcli.Text = EmptyStr then
  begin
    MessageDlg('Informe o e-mail!',mtInformation,[mbOK],0);
    edt_emailcli.SetFocus;
    Exit;
  end

  else if ComboBoxsexocli.ItemIndex = -1 then
  begin
    MessageDlg('Informe o sexo!',mtInformation,[mbOK],0);
    ComboBoxsexocli.SetFocus;
    Exit;
  end

  else if ComboBoxTipoTreino.ItemIndex = -1 then
  begin
    MessageDlg('Informe o tipo de treino!',mtInformation,[mbOK],0);
    ComboBoxTipoTreino.SetFocus;
    Exit;
  end;

  datac1 := DateToStr(Date);

   {if datac1 <= MaskEditdatanasc.Text then
    begin
      MessageDlg('Data inv�lida!',mtInformation,[mbOK],0);
      exit;
    end;}

  try
  begin
    ADOStoredProcCadasCli.Parameters[1].Value := edt_nomecli.Text;
    ADOStoredProcCadasCli.Parameters[2].Value := edt_enderecocli.Text;
    MaskEdit1.EditMask := '!999.999.999-99;1;_';  /////
    ADOStoredProcCadasCli.Parameters[3].Value := MaskEdit1.Text;
    ADOStoredProcCadasCli.Parameters[4].Value := MaskEditRG.Text;
    ADOStoredProcCadasCli.Parameters[5].Value := MaskEdittelefone.Text;
    anonasc := copy(MaskEditdatamatric.Text,7,4);
    mesnasc := copy(MaskEditdatamatric.Text,4,2);
    dianasc := copy(MaskEditdatamatric.Text,1,2);
    ADOStoredProcCadasCli.Parameters[6].Value := anonasc + '/' + mesnasc + '/' + dianasc;
    anomatri := copy(MaskEditdatanasc.Text,7,4);
    mesmatri := copy(MaskEditdatanasc.Text,4,2);
    diamatri := copy(MaskEditdatanasc.Text,1,2);
    ADOStoredProcCadasCli.Parameters[7].Value := anomatri + '/' + mesmatri + '/' + diamatri;
    ADOStoredProcCadasCli.Parameters[8].Value := edt_emailcli.Text;
    ComboBoxstatuscli.ItemIndex := 0;
    ADOStoredProcCadasCli.Parameters[9].Value := ComboBoxstatuscli.ItemIndex;
    s := ComboBoxsexocli.Text;
    ADOStoredProcCadasCli.Parameters[10].Value := ComboBoxsexocli.Text;

    ADOStoredProcCadasCli.Parameters[11].Value := edt_foto.Text;
    tp := ComboBoxTipoTreino.Text;
    ADOStoredProcCadasCli.Parameters[12].Value := ComboBoxTipoTreino.Text;
    ADOStoredProcCadasCli.Parameters[13].Value := edt_usuario.Text;

    ADOStoredProcCadasCli.ExecProc;

    U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcli.Close;
    U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcli.Open;
    ////Unit_consultacli.form_consultacli.DBGridconsultacli.Refresh;
    U_Consultar_Cliente.frm_consultacli.ADOQueryconsultcli.Refresh;

    U_Aniversariantes.frm_aniversariantes.ADOQueryAniversariantes.Close;
    U_Aniversariantes.frm_aniversariantes.ADOQueryAniversariantes.Open;
    U_Aniversariantes.frm_aniversariantes.ADOQueryAniversariantes.Refresh;

    U_Cadastrar_Mensalidades.frm_cadasmensalidades.ADOQueryCadasMensa.Close;
    U_Cadastrar_Mensalidades.frm_cadasmensalidades.ADOQueryCadasMensa.Open;
    U_Cadastrar_Mensalidades.frm_cadasmensalidades.ADOQueryCadasMensa.Refresh;

    MessageDlg('Cliente cadastrado com sucesso!',mtInformation,[mbOK],0);

    frm_cadastrarcli.Close;

    U_Cadastrar_Cliente.frm_cadastrarcli.ADOQueryCadascli.Close;
    U_Cadastrar_Cliente.frm_cadastrarcli.ADOQueryCadascli.Open;
    U_Cadastrar_Cliente.frm_cadastrarcli.ADOQueryCadascli.Last;  //// aponto para o ultimo registro, que nesse caso � o que acabei de cadastrar

    U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Close;
    U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Open;
    U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Last;

    ////ShowMessage(   'OI CAIPOIRA DO C�DIGO E�.....' + IntToStr(Unit_cadastrocli.form_cadastrocli.ADOQueryCadasclicodigo_cliente.AsInteger) );
    if Application.MessageBox('Deseja cadastrar medidas?','Aten��o',MB_ICONQUESTION + MB_YESNO) = IDNO then
    begin
      frm_cadasmensalidades.ShowModal;
    end

    else
    begin
      frm_cadasmedidas.ShowModal;
    end;


    //frm_cadasmedidas.ShowModal;
    edt_nomecli.Clear;
    MaskEdit1.Clear;
    MaskEditRG.Clear;
    edt_enderecocli.Clear;
    edt_emailcli.Clear;
    edt_foto.Clear;
    MaskEditdatanasc.Clear;
    MaskEditdatamatric.Clear;
    MaskEdittelefone.Clear;
    ComboBoxTipoTreino.ItemIndex := -1;
    Image_cadastrocli.Picture.LoadFromFile('C:\images.PNG');
    ComboBoxsexocli.ItemIndex := -1;
    ComboBoxstatuscli.ItemHeight := -1;
    ADOQueryCadascli.Close;
    ADOQueryCadascli.Open;
    ADOQueryCadascli.Refresh;
  end
  finally

  end;

end;

procedure Tfrm_cadastrarcli.Image5Click(Sender: TObject);
begin
    if OpenPictureDialogCadascli.Execute then
  begin
    Image_cadastrocli.Picture.LoadFromFile(OpenPictureDialogCadascli.FileName);
    edt_foto.Text := OpenPictureDialogCadascli.FileName;
    Image_cadastrocli.Visible := True;
  end;
end;

procedure Tfrm_cadastrarcli.Image6Click(Sender: TObject);
begin
  edt_nomecli.Clear;
  MaskEdit1.Clear;
  MaskEditRG.Clear;
  edt_enderecocli.Clear;
  edt_emailcli.Clear;
  edt_foto.Clear;
  edt_usuario.Clear;
  MaskEditdatanasc.Clear;
  MaskEditdatamatric.Clear;
  MaskEdittelefone.Clear;
  ComboBoxsexocli.ItemIndex := -1;
  ComboBoxTipoTreino.ItemIndex := -1;
  Image_cadastrocli.Picture.LoadFromFile('C:\images.PNG');
  close;
end;

function Tfrm_cadastrarcli.imprimeCPF(CPF: string): string;
begin
  imprimeCPF := copy(CPF, 1, 3) + '.' + copy(CPF, 4, 3) + '.' +
    copy(CPF, 7, 3) + '-' + copy(CPF, 10, 2);
end;

function Tfrm_cadastrarcli.isCPF(CPF: string): boolean;
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

procedure Tfrm_cadastrarcli.MaskEdit1Exit(Sender: TObject);
begin
   if (MaskEdit1.Text = '   .   .   -  ') or (MaskEdit1.Text = EmptyStr) then
   begin
     MessageDlg('� necess�rio preencher o CPF, corretamente!',mtError,[mbOK],0);
     MaskEdit1.SetFocus;
     exit;
   end;

   MaskEdit1.EditMask := '!999.999.999-99;0;_';  /////
    if isCPF(MaskEdit1.Text) then
    begin
         Exit;
    end
    else
    begin
          MessageDlg('CPF inv�lido!',mtInformation,[mbOK],0);
          MaskEdit1.SetFocus;
          Exit;
    end

end;

end.
