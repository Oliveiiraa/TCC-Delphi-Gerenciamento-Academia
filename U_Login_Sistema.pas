unit U_Login_Sistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Clipbrd, ExtCtrls, pngimage, jpeg;

type
  Tfrm_loginsistema = class(TForm)
    lbl_usuario: TLabel;
    lbl_senha: TLabel;
    edt_usuario: TEdit;
    edt_senha: TEdit;
    Button1: TButton;
    ADOQueryLogin: TADOQuery;
    ADOConnectionLogin: TADOConnection;
    ImageLoginSistema: TImage;
    Image1: TImage;
    lbl_esqueceusuasenha: TLabel;
    SaveDialogEsqueceuSenha: TSaveDialog;
    ADOQueryEsqueceSenha: TADOQuery;
    ADOQueryLoginCOD_USU: TAutoIncField;
    ADOQueryLoginNM_USU: TStringField;
    ADOQueryLoginLG_USU: TStringField;
    ADOQueryLoginSN_USU: TStringField;
    ADOQueryLoginTP_USU: TBooleanField;
    ADOQueryEsqueceSenhaLG_USU: TStringField;
    ADOQueryEsqueceSenhaSN_USU: TStringField;
    imgclose: TImage;
    procedure Button1Click(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure lbl_esqueceusuasenhaClick(Sender: TObject);
    procedure imgcloseClick(Sender: TObject);
  private
    { Private declarations }
    tentativas : SmallInt;

  public
    { Public declarations }
  end;

var
  frm_loginsistema: Tfrm_loginsistema;

implementation

uses U_Principal, U_Cadastrar_Despesas, U_Esqueceu_Senha;

{$R *.dfm}

procedure Tfrm_loginsistema.btn_sairClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_loginsistema.Button1Click(Sender: TObject);
begin
  edt_usuario.Text := 'ADMIN';
  edt_senha.Text := 'ADMIN';
end;

procedure Tfrm_loginsistema.FormPaint(Sender: TObject);
  //var
  //altura, coluna: Word;
begin
  //altura := (ClientHeight + 255) div 256;
  //for coluna := 0 to 255 do
    //with Canvas do
    //begin
      //Brush.Color := RGB(coluna, 02, 1); { Modifique para obter cores diferentes }
      //FillRect(Rect(0, coluna * altura, ClientWidth, (coluna + 1) * altura)) ;
    //end;
end;

procedure Tfrm_loginsistema.FormResize(Sender: TObject);
begin
  //Invalidate;
end;

procedure Tfrm_loginsistema.FormShow(Sender: TObject);
begin
  //Brush.Style := BsClear;
end;

procedure Tfrm_loginsistema.Image1Click(Sender: TObject);
begin
   if edt_usuario.Text = '' then
  begin
    MessageDlg('Preencha o campo usu�rio!',mtInformation,[mbOK],0);
    edt_usuario.SetFocus;
  end

  else if edt_senha.Text = '' then
  begin
    MessageDlg('Preencha o campo senha!',mtInformation,[mbOK],0);
    edt_senha.SetFocus;
  end;

  //if ADOQueryLogin.locate('LG_USU',edt_usuario.text,[locaseinsensitive]) and
    //ADOQueryLogin.locate('SN_USU',edt_senha.text,[]) then
  //begin
    //edt_usuario.Clear;
    //edt_senha.Clear;
    //frm_principal.show;
   // frm_loginsistema.Close;
 // end

 // else
 // begin
 //   showmessage('Usuario ou senha incorretos');
 // end

  with ADOQueryLogin do
  Begin
    Active := False;
    Close;
    SQL.Clear;
    SQL.Add('Select *                                                         ');
    SQL.Add('From TB_USUARIOS                                                 ');
    SQL.Add('Where LG_USU LIKE ''' + edt_usuario.Text + '''         and       ');
    SQL.Add('      SN_USU LIKE ''' + edt_senha.Text + '''                     ');
    Clipboard.AsText := ADOQueryLogin.SQL.Text;
    Open;
    Active := True;
  end;

  if ADOQueryLogin.RecordCount > 0 then
  begin
    frm_principal.ShowModal;
    edt_senha.Clear;
  end

  else
  begin
    MessageDlg('Usu�rio e/ou senha errado(s)',mtInformation,[mbOK],0);
  end;

end;

procedure Tfrm_loginsistema.Image6Click(Sender: TObject);
begin
  U_Login_Sistema.frm_loginsistema.Close;
end;

procedure Tfrm_loginsistema.imgcloseClick(Sender: TObject);
begin
  ADOQueryLogin.Close;
  Close;
end;

procedure Tfrm_loginsistema.lbl_esqueceusuasenhaClick(Sender: TObject);
var
senha,nomearquivo : string;
Text : TStringList;
  i : integer;
begin
  senha := InputBox('Confirma��o','Digite o c�digo de acesso','');

  if senha = 'BIORITMO' then
  BEGIN
      Text := TStringList.Create;

      try

        while not ADOQueryEsqueceSenha.Eof do
          begin
            for i := 0 to ADOQueryEsqueceSenha.Fields.Count - 1 do
               Text.add(ADOQueryEsqueceSenha.Fields[i].AsString + '');
               Text.add('');
               ADOQueryEsqueceSenha.Next;
          end;

          SaveDialogEsqueceuSenha.Execute;
          nomearquivo := SaveDialogEsqueceuSenha.FileName;
          Text.savetofile(nomearquivo);

          if SaveDialogEsqueceuSenha.FileName = '' then
          begin
            Application.MessageBox('Nome do arquivo n�o informado','Erro',MB_OK + MB_ICONERROR);
            exit;
          end;

      finally

      end;
  END;

  if senha <> 'BIORITMO' then
    BEGIN
      Application.MessageBox('C�digo inv�lido','Erro',MB_OK +MB_ICONERROR);
      exit;
    END;

    ADOQueryEsqueceSenha.First;
end;

end.
