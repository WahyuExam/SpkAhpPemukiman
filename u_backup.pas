unit u_backup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_backup = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    btnpanggil: TBitBtn;
    btnsalin: TBitBtn;
    btnkeluar: TBitBtn;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnsalinClick(Sender: TObject);
    procedure btnpanggilClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_backup: Tf_backup;
  a,b,c : string;

implementation

uses
  u_datamodule;

{$R *.dfm}

procedure Tf_backup.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_backup.FormShow(Sender: TObject);
begin
 a:=GetCurrentDir+'\db_ahp.mdb';
end;

procedure Tf_backup.btnsalinClick(Sender: TObject);
begin
 dlgSave1.Execute;
 If dlgSave1.filename <> '' Then
   b:=dlgSave1.FileName
  else
 Exit;

  CopyFile(Pchar(A),Pchar(B+'.mdb'),True);
  MessageDlg('Salin Data Berhasil',mtInformation,[mbOK],0);
end;

procedure Tf_backup.btnpanggilClick(Sender: TObject);
begin
dlgOpen1.Execute;
 dlgOpen1.Filter:=A;
 If dlgOpen1.FileName <> '' Then
  c:=dlgOpen1.FileName
  else
  Exit;

  if MessageDlg('Panggil Data "'+ExtractFileName(C)+'"  ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      dm.con1.Connected:=false;
      RenameFile(C,'db_ahp.mdb');
      dm.con1.ConnectionString:=A;
      dm.con1.Connected:=true;
      dm.DataModuleCreate(sender);
      MessageDlg('Panggil Data Berhasil',mtInformation,[mbOK],0);
    end;
end;

end.
