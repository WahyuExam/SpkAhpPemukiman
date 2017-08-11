unit u_gantisandi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_gantisandi = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    edtpengguna: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    edtsandillama: TEdit;
    edtsandibaru: TEdit;
    grp3: TGroupBox;
    btnubah: TBitBtn;
    btnkeluar: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure edtsandibaruKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_gantisandi: Tf_gantisandi;

implementation

uses
  u_datamodule;

{$R *.dfm}

procedure Tf_gantisandi.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_gantisandi.FormShow(Sender: TObject);
begin
 edtpengguna.Text:=dm.tbladmin.fieldbyname('pengguna').AsString;
 edtsandillama.Text:=dm.tbladmin.fieldbyname('sandi').AsString;

 edtsandibaru.Clear;
 edtsandibaru.SetFocus;
end;

procedure Tf_gantisandi.btnubahClick(Sender: TObject);
begin
 if MessageDlg('Yakin Kata Sandi Akan Diubah ?',mtConfirmation,[mbYes,mbno],0)=mryes then
  begin
    dm.tbladmin.Edit;
    dm.tbladmin.FieldByName('sandi').AsString := edtsandibaru.Text;
    dm.tbladmin.Post;

    FormShow(Sender);
    MessageDlg('Kata Sandi Sudah Diubah',mtInformation,[mbOK],0);
  end;
end;

procedure Tf_gantisandi.edtsandibaruKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key=#13 then btnubah.Click;
end;

end.
