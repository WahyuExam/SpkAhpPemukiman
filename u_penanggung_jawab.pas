unit u_penanggung_jawab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_penanggung_jawab = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    img1: TImage;
    grp2: TGroupBox;
    lbl2: TLabel;
    edtkode: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtnama: TEdit;
    rb1: TRadioButton;
    rb2: TRadioButton;
    mmoalamat: TMemo;
    edttelp: TEdit;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    grp4: TGroupBox;
    dbgrd1: TDBGrid;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    btnkeluar: TBitBtn;
    edtnamabantu: TEdit;
    edtalamatbantu: TEdit;
    procedure btncampurClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnkeluarClick(Sender: TObject);
    procedure edttelpKeyPress(Sender: TObject; var Key: Char);
    procedure edtnamaKeyPress(Sender: TObject; var Key: Char);
    procedure mmoalamatKeyPress(Sender: TObject; var Key: Char);
    procedure btnsimpanClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_penanggung_jawab: Tf_penanggung_jawab;
  kode, status, jk : string;

implementation

uses
  u_datamodule, StrUtils, DB;

{$R *.dfm}

procedure Tf_penanggung_jawab.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
    with dm.qry_jawab do
     begin
       DisableControls;
       close;
       sql.Clear;
       SQL.Text:='select * from tbl_jawab order by kd_jawab asc';
       Open;
       EnableControls;


       if IsEmpty then kode:='001' else
        begin
          Last;
          kode := RightStr(fieldbyname('kd_jawab').AsString,3);
          kode := IntToStr(StrToInt(kode)+1);
        end;
     end;

     edtkode.Text:='PGJ-'+Format('%.3d',[StrToInt(kode)]);

     edtnama.Enabled:=True; edtnama.SetFocus;
     rb1.Enabled:=True; rb2.Enabled:=True;
     mmoalamat.Enabled:=True; edttelp.Enabled:=True;

     btncampur.Enabled:=True; btncampur.Caption:='Batal';
     btnsimpan.Enabled:=True; btnubah.Enabled:=false;
     btnhapus.Enabled:=False; btnkeluar.Enabled:=false;

     status:='tambah';
  end
  else
 if btncampur.Caption='Batal' then FormShow(Sender);
end;

procedure Tf_penanggung_jawab.FormShow(Sender: TObject);
begin
 edtkode.Enabled:=false; edtkode.Clear;
 edtnama.Enabled:=false; edtnama.Clear;
 rb1.Enabled:=false; rb1.Checked:=false;
 rb2.Enabled:=false; rb2.Checked:=false;
 mmoalamat.Enabled:=false; mmoalamat.Clear;
 edttelp.Enabled:=false; edttelp.Clear;

 dbgrd1.Enabled:=True;

 btncampur.Enabled:=false; btncampur.Caption:='Batal';
 btnsimpan.Enabled:=false; btnubah.Enabled:=false;
 btnhapus.Enabled:=False; btnkeluar.Enabled:=True;
end;

procedure Tf_penanggung_jawab.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_penanggung_jawab.edttelpKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Not (key in ['0'..'9',#13,#8,#9]) then Key:=#0;
end;

procedure Tf_penanggung_jawab.edtnamaKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['a'..'z','A'..'Z','''','.',',',#13,#8,#9,#32]) then Key:=#0;
 if Key=#13 then rb1.SetFocus;
end;

procedure Tf_penanggung_jawab.mmoalamatKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9','A'..'Z','a'..'z',',','.','/','-',#13,#32,#8,#9]) then key:=#0;
  if key=#13 then edttelp.SetFocus;

end;

procedure Tf_penanggung_jawab.btnsimpanClick(Sender: TObject);
begin
 if Trim(edtnama.Text)='' then
  begin
    MessageDlg('Nama Penangung Jawab Belum Diisi',mtInformation,[mbok],0);
    edtnama.SetFocus;
    Exit;
  end;

 if Trim(mmoalamat.Text)='' then
  begin
    MessageDlg('Alamat Belum Diisi',mtInformation,[mbok],0);
    mmoalamat.SetFocus;
    Exit;
  end;

 if edttelp.Text='' then
  begin
    MessageDlg('No Telp Belum Diisi',mtInformation,[mbok],0);
    edttelp.SetFocus;
    Exit;
  end;

 if (rb1.Checked=false) and (rb2.Checked=false) then
  begin
    MessageDlg('Jenis Kelamin Belum Dipilih',mtInformation,[mbok],0);
    rb1.SetFocus;
    Exit;
  end;

  if rb1.Checked=True then jk:=rb1.Caption else
  if rb2.Checked=True then jk:=rb2.Caption;

  with dm.qry_jawab do
   begin
     if status='tambah' then
      begin
        if Locate('nm_jawab;almt;jk',VarArrayOf([edtnama.Text,mmoalamat.Text,jk]),[]) then
         begin
           MessageDlg('Data Sudah Ada',mtInformation,[mbOK],0);
           edtnama.SetFocus;
           Exit;
         end
         else
         begin
           Append;
           FieldByName('kd_jawab').AsString := edtkode.Text;
         end;
      end
      else
     if status='ubah' then
      begin
        if (edtnama.Text=edtnamabantu.Text) and (mmoalamat.Text=edtalamatbantu.Text) then
         begin
          if Locate('kd_jawab',edtkode.Text,[]) then Edit;
         end
         else
         if (edtnama.Text<>edtnamabantu.Text) or (mmoalamat.Text<>edtalamatbantu.Text) then
          begin
            if Locate('nm_jawab;almt;jk',VarArrayOf([edtnama.Text,mmoalamat.Text,jk]),[]) then
             begin
               MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
               edtnama.SetFocus;
               Exit;
             end
             else
            if Locate('kd_jawab',edtkode.Text,[]) then Edit;
          end;
      end;

      FieldByName('nm_jawab').AsString := edtnama.Text;
      FieldByName('jk').AsString := jk;
      FieldByName('almt').AsString := mmoalamat.Text;
      FieldByName('no_hp').AsString := edttelp.Text;
      Post;

      FormShow(Sender);
      MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
   end;
end;

procedure Tf_penanggung_jawab.dbgrd1DblClick(Sender: TObject);
begin
 edtkode.Text := dbgrd1.Fields[0].AsString;
 edtnama.Text := dbgrd1.Fields[1].AsString;
 edtnamabantu.Text := dbgrd1.Fields[1].AsString;

 if dbgrd1.Fields[2].AsString='L' then rb1.Checked:=True else
 if dbgrd1.Fields[2].AsString='P' then rb2.Checked:=True;

 mmoalamat.Text:=dbgrd1.Fields[3].AsString;
 edtalamatbantu.Text := dbgrd1.Fields[3].AsString;
 edttelp.Text:=dbgrd1.Fields[4].AsString;

 btncampur.Enabled:=True; btncampur.Caption:='Batal';
 btnsimpan.Enabled:=false;
 btnubah.Enabled:=True; btnhapus.Enabled:=True; btnkeluar.Enabled:=false;


end;

procedure Tf_penanggung_jawab.btnubahClick(Sender: TObject);
begin
 status:='ubah';

 edtnama.Enabled:=True; edtnama.SetFocus;
 rb2.Enabled:=True; rb1.Enabled:=True;
 mmoalamat.Enabled:=True;
 edttelp.Enabled:=True;

 btncampur.Enabled:=True; btncampur.Caption:='Batal';
 btnsimpan.Enabled:=True;
 btnubah.Enabled:=False; btnhapus.Enabled:=false; btnkeluar.Enabled:=false;
end;

procedure Tf_penanggung_jawab.btnhapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Data Akan Dihapus ?',mtConfirmation,[mbYes,mbno],0)=mryes then
  begin
    dm.qry_jawab.Delete;

    FormShow(Sender);
    MessageDlg('Data Sudah Dihapus',mtInformation,[mbok],0);
  end;
end;

end.
