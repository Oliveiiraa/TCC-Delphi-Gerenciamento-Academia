unit U_Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, jpeg, pngimage, ExtCtrls, DB, ADODB;

type
  Tfrm_principal = class(TForm)
    MainMenu1: TMainMenu;
    cadastr1: TMenuItem;
    Cliente1: TMenuItem;
    Funcionrio1: TMenuItem;
    Usuario1: TMenuItem;
    Consulta1: TMenuItem;
    Cliente2: TMenuItem;
    Funcionrio2: TMenuItem;
    Backup1: TMenuItem;
    Sair1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Despesas1: TMenuItem;
    Despesas2: TMenuItem;
    Aniversariantes1: TMenuItem;
    Image4: TImage;
    imgbalanco: TImage;
    ADOCommandBackup: TADOCommand;
    ADOConnectionBackup: TADOConnection;
    Label1: TLabel;
    Edit_hora: TEdit;
    Timer1: TTimer;
    Image10: TImage;
    ImageOpcoes: TImage;
    Mensalidades1: TMenuItem;
    Relatrio2: TMenuItem;
    Balano1: TMenuItem;
    Despesas3: TMenuItem;
    Opes1: TMenuItem;
    Image8: TImage;
    InformaesdoSistema1: TMenuItem;
    Clientes1: TMenuItem;
    Despesas4: TMenuItem;
    Funcionrios1: TMenuItem;
    Mensalidades2: TMenuItem;
    imgimc: TImage;
    Cadastrar1: TMenuItem;
    Consultar1: TMenuItem;
    procedure bnt_cadastrarClick(Sender: TObject);
    procedure bnt_consultasClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cliente1Click(Sender: TObject);
    procedure Funcionrio1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure btn_despesasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bnt_calcularimcClick(Sender: TObject);
    procedure bnt_aniversariantesClick(Sender: TObject);
    procedure bnt_mensalidadesatrasadasClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Despesas1Click(Sender: TObject);
    procedure Funcionrio2Click(Sender: TObject);
    procedure Mensalidades2Click(Sender: TObject);
    procedure Despesas2Click(Sender: TObject);
    procedure CalcularIMC1Click(Sender: TObject);
    procedure Aniversariantes1Click(Sender: TObject);
    procedure relatrio1Click(Sender: TObject);
    procedure imgbalancoClick(Sender: TObject);
    procedure Backup1Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image10Click(Sender: TObject);
    procedure ImageOpcoesClick(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Mensalidades1Click(Sender: TObject);
    procedure Relatrio2Click(Sender: TObject);
    procedure Balano1Click(Sender: TObject);
    procedure Despesas3Click(Sender: TObject);
    procedure Opes1Click(Sender: TObject);
    procedure InformaesdoSistema1Click(Sender: TObject);
    procedure cadastr1Click(Sender: TObject);
    procedure Consulta1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Despesas4Click(Sender: TObject);
    procedure Funcionrios1Click(Sender: TObject);
    procedure imgimcClick(Sender: TObject);
    procedure Cadastrar1Click(Sender: TObject);
    procedure Consultar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

uses U_Login_Sistema, U_Cadastrar, U_Consultar, U_Cadastrar_Cliente,
  U_Cadastrar_Funcionario, U_Cadastrar_Login, U_Consultar_Cliente,
  U_Consultar_Funcionario, U_Despesas, U_Cadastrar_Mensalidades, U_Calcular_IMC,
  U_Aniversariantes, U_Consultar_Mensalidades, U_Cadastrar_Despesas,
  U_Consultar_Despesas, U_Relatorio, U_Cadastrar_Usuario, U_Esta, U_Opcoess,
  U_Info_Sistema, U_Relatorio_Func_Comum;

{$R *.dfm}

procedure Tfrm_principal.Aniversariantes1Click(Sender: TObject);
begin
  U_Aniversariantes.frm_aniversariantes.ShowModal;
end;

procedure Tfrm_principal.Backup1Click(Sender: TObject);
var
    ADOCommand : TADOCommand;
    data_atual : string;
    ano, mes, dia : string;
begin
  data_atual := DateToStr(Date);
   ano :=  Copy(data_atual,7,4) ;
   mes :=  Copy(data_atual,4,2) ;
   dia := Copy(data_atual,1,2) ;

   ADOCommand := TADOCommand.Create(nil); //Cria o objeto de comando para executar a rotina de backup do SQL SERVER 2000
  with ADOCommand do
  begin
     ADOCommand.Name := 'ADOGeraBackup'; //Nome do objeto
     ADOCommand.ConnectionString := ADOConnectionBackup.ConnectionString; //Cria a conex�o com o Provider do SQL Server
     ADOCommand.CommandType := cmdText; //Define como command Text para execu��o de linhas de comando
     ADOCommand.CommandText := 'BACKUP DATABASE TCC TO DISK =''C:\Sistema Bio Ritmo\Backup\Backup'+dia + '_' + mes + '_' + ano +'.bak'' ';
     ADOCommand.Execute; //Executa a linha de comando
  end;

  MessageDlg('Backup realizado com sucesso!',mtConfirmation,[mbOK],0);

end;

procedure Tfrm_principal.Balano1Click(Sender: TObject);
begin
    if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_esta.ShowModal;
  end
  else
  begin
    MessageDlg('Voc� n�o tem permiss�o para visualizar estes dados!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_principal.bnt_aniversariantesClick(Sender: TObject);
begin
  U_Aniversariantes.frm_aniversariantes.ShowModal;
end;

procedure Tfrm_principal.bnt_cadastrarClick(Sender: TObject);
begin
  frm_cadastrar.ShowModal;
end;

procedure Tfrm_principal.bnt_calcularimcClick(Sender: TObject);
begin
  U_Calcular_IMC.frm_calimc.ShowModal;
end;

procedure Tfrm_principal.bnt_consultasClick(Sender: TObject);
begin
  frm_consultar.ShowModal;
end;

procedure Tfrm_principal.bnt_mensalidadesatrasadasClick(Sender: TObject);
begin
  frm_consultmensa.ShowModal;
end;

procedure Tfrm_principal.btn_despesasClick(Sender: TObject);
begin
  frm_despesas.ShowModal;
end;

procedure Tfrm_principal.cadastr1Click(Sender: TObject);
begin
 if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    Funcionrio1.Visible := true;
    Usuario1.Visible := true;
  end
  else
  begin
    Funcionrio1.Visible := False;
    Usuario1.Visible := False;
  end;
end;

procedure Tfrm_principal.Cadastrar1Click(Sender: TObject);
begin
 frm_cadasdespesas.ShowModal;
end;

procedure Tfrm_principal.CalcularIMC1Click(Sender: TObject);
begin
  frm_calimc.ShowModal;
end;

procedure Tfrm_principal.Cliente1Click(Sender: TObject);
begin
  frm_cadastrarcli.ShowModal;
end;

procedure Tfrm_principal.Cliente2Click(Sender: TObject);
begin
  frm_consultacli.ShowModal;
end;

procedure Tfrm_principal.Clientes1Click(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  U_Relatorio.frm_relatorios.RvProjectRelatoCli.Execute;
end;

procedure Tfrm_principal.Consulta1Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    Funcionrio2.Visible := true;
    Despesas2.Visible := true;
  end
  else
  begin
    Funcionrio2.Visible := False;
    Despesas2.Visible := False;
  end;
end;

procedure Tfrm_principal.Consultar1Click(Sender: TObject);
begin
 frm_consultadespesas.ShowModal;
end;

procedure Tfrm_principal.Despesas1Click(Sender: TObject);
begin
  frm_cadasdespesas.ShowModal;
end;

procedure Tfrm_principal.Despesas2Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultadespesas.ShowModal;
  end
  else
  begin
    MessageDlg('Voc� n�o tem permiss�o para consultar despesas!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_principal.Despesas3Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin

  end

  else
  begin
    frm_cadasdespesas.ShowModal;
  end;
end;

procedure Tfrm_principal.Despesas4Click(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  U_Relatorio.frm_relatorios.RvProjectRelatorioDespesas.Execute;
end;

procedure Tfrm_principal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key= vk_f1 then
   begin
     Image1Click(self);
   end

   else if key= vk_f2 then
   begin
     Image2Click(self);
   end

    else if key= vk_f3 then
   begin
     Image6Click(self);
   end

       else if key= vk_f4 then
   begin
     ImageOpcoesClick(self);
   end

       else if key= vk_f5 then
   begin
     Image3Click(self);
   end

       else if key= vk_f6 then
   begin
     Image5Click(self);
   end

       else if key= vk_f7 then
   begin
     Image7Click(self);
   end ;



end;

procedure Tfrm_principal.FormShow(Sender: TObject);
var
ano,mes,dia,data,a : string;
begin
  //BorderStyle := bsNone;
  //Top := 0; Left:= 0;
  //Width := Screen.Width;
  //Height:= Screen.Height;

  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = True then
  begin
    Despesas3.Visible := False;
    Balano1.Visible := False;
    imgbalanco.Visible := False;
    imgimc.Visible := true;
  end

  else
  begin
    imgimc.Visible := False;
    imgbalanco.Visible := true;
    Despesas3.Visible := true;
    Balano1.Visible := true;
  end;

  Label1.Caption := U_Login_Sistema.frm_loginsistema.ADOQueryLoginNM_USU.AsString;

  data := datetostr(Date);

  dia := copy(data,1,2);

  //mes := copy(date,4,2);

  if dia = '01' then
  begin
    MessageDlg('Fa�a o relat�rio das mensalidades do m�s anterior!',mtInformation,[mbOK],0);
    frm_relatorios.RvProjectRelatoMensalidades.Execute;
  end

end;

procedure Tfrm_principal.Funcionrio1Click(Sender: TObject);
begin
////  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  ////begin
  frm_cadasfunc.ShowModal;
  ////end
  ///else
  ///begin
   //// Funcionrio1.Visible := False;
  ////end;
end;

procedure Tfrm_principal.Funcionrio2Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultafunc.ShowModal;
  end
  else
  begin
    MessageDlg('Voc� n�o tem permiss�o para consultar funcion�rio!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_principal.Funcionrios1Click(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  U_Relatorio.frm_relatorios.RvProjectRelatoFuncionarios.Execute;
end;

procedure Tfrm_principal.Image10Click(Sender: TObject);
begin
  close;
  U_Login_Sistema.frm_loginsistema.edt_usuario.Clear;
  U_Login_Sistema.frm_loginsistema.edt_usuario.SetFocus;
end;

procedure Tfrm_principal.Image1Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_cadastrar.ShowModal;
  end
  else
  begin
    frm_cadastrarcli.ShowModal;
  end;
end;

procedure Tfrm_principal.Image2Click(Sender: TObject);
begin
    if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_consultar.ShowModal;
  end
  else
  begin
    frm_consultacli.ShowModal;
  end;
end;

procedure Tfrm_principal.Image3Click(Sender: TObject);
begin
  frm_consultmensa.ShowModal;
end;

procedure Tfrm_principal.Image5Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_despesas.ShowModal;
  end

  else
  begin
    frm_cadasdespesas.ShowModal;
  end;
end;

procedure Tfrm_principal.Image6Click(Sender: TObject);
begin
  U_Aniversariantes.frm_aniversariantes.ShowModal;
end;

procedure Tfrm_principal.Image7Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_relatorios.ShowModal;
  end

  else
  begin
    frm_relatofunccomum.ShowModal;
  end;
end;

procedure Tfrm_principal.Image8Click(Sender: TObject);
var
    ADOCommand : TADOCommand;
    data_atual : string;
    ano, mes, dia : string;
begin
  ///if Application.MessageBox('Voc� j� realizou o backup hoje?','Aten��o',MB_ICONQUESTION + MB_YESNO) = IDNO then
 ///begin
  data_atual := DateToStr(Date);
   ano :=  Copy(data_atual,7,4) ;
   mes :=  Copy(data_atual,4,2) ;
   dia := Copy(data_atual,1,2) ;

   ADOCommand := TADOCommand.Create(nil); //Cria o objeto de comando para executar a rotina de backup do SQL SERVER 2000
  with ADOCommand do
  begin
     ADOCommand.Name := 'ADOGeraBackup'; //Nome do objeto
     ADOCommand.ConnectionString := ADOConnectionBackup.ConnectionString; //Cria a conex�o com o Provider do SQL Server
     ADOCommand.CommandType := cmdText; //Define como command Text para execu��o de linhas de comando
     ADOCommand.CommandText := 'BACKUP DATABASE TCC TO DISK =''C:\Sistema Bio Ritmo\Backup\Backup'+dia + '_' + mes + '_' + ano +'.bak'' ';
     ADOCommand.Execute; //Executa a linha de comando
  end;

  ////MessageDlg('Backup realizado com sucesso!',mtConfirmation,[mbOK],0);

  U_Principal.frm_principal.Close;
  U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Close;
  U_Login_Sistema.frm_loginsistema.close;

 ///end


 ///else
 ///begin
  //close;
  ///frm_loginsistema.close;
 ///end;
end;

procedure Tfrm_principal.imgbalancoClick(Sender: TObject);
begin
   if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    frm_esta.ShowModal;
  end
  else
  begin
    MessageDlg('Voc� n�o tem permiss�o para visualizar estes dados!',mtError,[mbOK],0);
  end;
end;

procedure Tfrm_principal.imgimcClick(Sender: TObject);
begin
  frm_calimc.ShowModal;
end;

procedure Tfrm_principal.ImageOpcoesClick(Sender: TObject);
begin
  frm_opcoess.ShowModal;
end;

procedure Tfrm_principal.InformaesdoSistema1Click(Sender: TObject);
begin
 frm_infosistema.ShowModal;
end;

procedure Tfrm_principal.Usuario1Click(Sender: TObject);
begin
  ///if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  ///begin
    frm_cadasusu.ShowModal;
  ///end
  ///else
  ///begin
    ///Usuario1.Visible := False;
  ////end;
end;

procedure Tfrm_principal.Mensalidades1Click(Sender: TObject);
begin
   frm_consultmensa.ShowModal;
end;

procedure Tfrm_principal.Mensalidades2Click(Sender: TObject);
begin
  MessageDlg('Ligue a impressora',mtInformation,[mbOK],0);
  U_Relatorio.frm_relatorios.RvProjectRelatoMensalidades.Execute;
end;

procedure Tfrm_principal.Opes1Click(Sender: TObject);
begin
 frm_opcoess.ShowModal;
end;

procedure Tfrm_principal.relatrio1Click(Sender: TObject);
begin
  frm_relatorios.ShowModal;
end;

procedure Tfrm_principal.Relatrio2Click(Sender: TObject);
begin
  if U_Login_Sistema.frm_loginsistema.ADOQueryLoginTP_USU.AsBoolean = False then
  begin
    Despesas4.Visible := true;
    Funcionrios1.Visible := true;
  end

  else
  begin
    Despesas4.Visible := False;
    Funcionrios1.Visible := False;
  end;
end;

procedure Tfrm_principal.Sair1Click(Sender: TObject);
var
    ADOCommand : TADOCommand;
    data_atual : string;
    ano, mes, dia : string;
begin
  ///if Application.MessageBox('Voc� j� realizou o backup hoje?','Aten��o',MB_ICONQUESTION + MB_YESNO) = IDNO then
 ///begin
  data_atual := DateToStr(Date);
   ano :=  Copy(data_atual,7,4) ;
   mes :=  Copy(data_atual,4,2) ;
   dia := Copy(data_atual,1,2) ;

   ADOCommand := TADOCommand.Create(nil); //Cria o objeto de comando para executar a rotina de backup do SQL SERVER 2000
  with ADOCommand do
  begin
     ADOCommand.Name := 'ADOGeraBackup'; //Nome do objeto
     ADOCommand.ConnectionString := ADOConnectionBackup.ConnectionString; //Cria a conex�o com o Provider do SQL Server
     ADOCommand.CommandType := cmdText; //Define como command Text para execu��o de linhas de comando
     ADOCommand.CommandText := 'BACKUP DATABASE TCC TO DISK =''C:\Sistema Bio Ritmo\Backup\Backup'+dia + '_' + mes + '_' + ano +'.bak'' ';
     ADOCommand.Execute; //Executa a linha de comando
  end;

  ////MessageDlg('Backup realizado com sucesso!',mtConfirmation,[mbOK],0);
  close;
  U_Login_Sistema.frm_loginsistema.ADOQueryLogin.Close;
  frm_loginsistema.close;
 ///end

/// else
 ///begin
  ///close;
  ///frm_loginsistema.close;
 ///end;
end;

procedure Tfrm_principal.Timer1Timer(Sender: TObject);
begin
 Edit_hora.Text := TimeToStr(time);
end;

end.