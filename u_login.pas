unit u_login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_login = class(TForm)
    img1: TImage;
    btn1: TBitBtn;
    edtsandi: TEdit;
    btn2: TBitBtn;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtsandiKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_login: Tf_login;

implementation

uses
  u_datamodule, u_menuutama;

{$R *.dfm}

procedure Tf_login.btn2Click(Sender: TObject);
begin
 close;
end;

procedure Tf_login.btn1Click(Sender: TObject);
begin
 if edtsandi.Text='' then
  begin
    MessageDlg('Sandi Belum Diisi',mtInformation,[mbOK],0);
    Exit;
  end;

 if edtsandi.Text = dm.tbladmin.FieldByName('sandi').AsString then
  begin
    MessageDlg('Anda Berhasil Login',mtInformation,[mbOK],0);
    f_menu.ShowModal;
    Self.Close;
  end
  else
  begin
    MessageDlg('Kata Sandi yang Anda Masukkan Salah',mtError,[mbOK],0);
    edtsandi.SetFocus;
    Exit;
  end;
end;

procedure Tf_login.FormShow(Sender: TObject);
begin
 edtsandi.Clear;
 edtsandi.SetFocus;
end;

procedure Tf_login.edtsandiKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then btn1.Click;
end;

end.
