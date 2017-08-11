unit u_mast_wilayah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, jpeg, ExtCtrls;

type
  Tf_mast_wil = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtkode: TEdit;
    edtnama: TEdit;
    mmoalamat: TMemo;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    grp4: TGroupBox;
    grp5: TGroupBox;
    dbgrd1: TDBGrid;
    lbl5: TLabel;
    edtpencarian: TEdit;
    btnkeluar: TBitBtn;
    mmoalamat_lama: TMemo;
    edtnama_lama: TEdit;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
    procedure edtpencarianKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtnamaKeyPress(Sender: TObject; var Key: Char);
    procedure mmoalamatKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure konek;
  end;

var
  f_mast_wil: Tf_mast_wil;
  status, kode : string;

implementation

uses
  u_datamodule, DB, StrUtils, ADODB;

{$R *.dfm}

procedure Tf_mast_wil.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_mast_wil.FormShow(Sender: TObject);
begin
 edtkode.Enabled:=false; edtkode.Clear;
 edtnama.Enabled:=false; edtnama.Clear;
 mmoalamat.Enabled:=false; mmoalamat.Clear;

 btncampur.Enabled:=True; btncampur.Caption:='Tambah';
 btnsimpan.Enabled:=false;
 btnubah.Enabled:=false;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=True;

 dbgrd1.Enabled:=True;

 edtpencarian.Clear; edtpencarian.Enabled:=True;
end;

procedure Tf_mast_wil.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
    with dm.qry_kawasan do
      begin
       if IsEmpty then kode := '001' else
        begin
         Last;
         kode := RightStr(fieldbyname('kd_kawasan').AsString,3);
         kode := IntToStr(StrToInt(kode)+1);
        end;
      end;
     edtkode.Text:='KWN-'+Format('%.3d',[StrToInt(kode)]);

     edtnama.Enabled:=True; edtnama.SetFocus;
     mmoalamat.Enabled:=True;

     btncampur.Caption:='Batal';
     btnsimpan.Enabled:=True; btnkeluar.Enabled:=false;

     dbgrd1.Enabled:=false;
     edtpencarian.Enabled:=false; edtpencarian.Clear;

     status:='tambah';
  end
  else
 if btncampur.Caption='Batal' then
  begin
    FormShow(Sender);
  end;
end;

procedure Tf_mast_wil.btnsimpanClick(Sender: TObject);
begin
 if Trim(edtnama.Text)='' then
  begin
    MessageDlg('Nama Kawasan Belum Diisi',mtInformation,[mbOK],0);
    edtnama.Clear; edtnama.SetFocus;
    Exit;
  end;

 if Trim(mmoalamat.Text)='' then
  begin
    MessageDlg('Alamat Kawasan Belum Diisi',mtInformation,[mbOK],0);
    mmoalamat.Clear; mmoalamat.SetFocus;
    Exit;
  end;

  with dm.qry_kawasan do
   begin
     if status='tambah' then
      begin
        if Locate('nm_kawasan',edtnama.Text,[]) then
         begin
           MessageDlg('Nama Kawasan Sudah Ada',mtInformation,[mbok],0);
           edtnama.SetFocus;
           Exit;
         end;

        if Locate('nm_kawasan;almt_kawasan',VarArrayOf([edtnama.Text,mmoalamat.Text]),[]) then
          begin
            MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
            edtnama.SetFocus;
            Exit;
          end
          else
          begin
            Append;
            FieldByName('kd_kawasan').AsString := edtkode.Text;
          end;
      end
      else
     if status='ubah' then
      begin
        if (edtnama.Text=edtnama_lama.Text) and (mmoalamat.Text=mmoalamat_lama.Text) then
         begin
          if Locate('kd_kawasan',edtkode.Text,[]) then Edit;
         end
         else
        if (edtnama.Text<>edtnama_lama.Text) or (mmoalamat_lama.Text<>mmoalamat.Text) then
         begin
           if edtnama.Text<>edtnama_lama.Text then
            begin
             if Locate('nm_kawasan',edtnama.Text,[]) then
               begin
                MessageDlg('Nama Kawasan Sudah Ada',mtInformation,[mbOK],0);
                edtnama.SetFocus;
                Exit;
               end; 
            end;

           if Locate('nm_kawasan;almt_kawasan',VarArrayOf([edtnama.Text,mmoalamat.Text]),[]) then
             begin
              MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
              edtnama.SetFocus;
              Exit;
             end
           else
           begin
             if Locate('kd_kawasan',edtkode.Text,[]) then Edit;
           end;
         end;
      end;

      FieldByName('nm_kawasan').AsString:=edtnama.Text;
      FieldByName('almt_kawasan').AsString:=mmoalamat.Text;
      Post;

      FormShow(Sender);
      MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
   end;

end;

procedure Tf_mast_wil.dbgrd1DblClick(Sender: TObject);
begin
 edtkode.Text := dbgrd1.Fields[0].AsString;

 if edtkode.Text = '' then Exit else
  begin
    edtnama.Text := dbgrd1.Fields[1].AsString;
    edtnama_lama.Text := dbgrd1.Fields[1].AsString;

    mmoalamat.Text := dbgrd1.Fields[2].AsString;
    mmoalamat_lama.Text := dbgrd1.Fields[2].AsString;

    btncampur.Caption:='Batal';
    btnsimpan.Enabled:=false;
    btnubah.Enabled:=True; btnhapus.Enabled:=True;
    btnkeluar.Enabled:=False;
  end;

end;

procedure Tf_mast_wil.btnubahClick(Sender: TObject);
begin
 status:='ubah';

 edtnama.Enabled:=True;  edtnama.SetFocus;
 mmoalamat.Enabled:=True;

 btncampur.Caption:='Batal';
 btnsimpan.Enabled:=True;
 btnubah.Enabled:=False;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=False;

 dbgrd1.Enabled:=false;
 edtpencarian.Enabled:=false; edtpencarian.Clear;
end;

procedure Tf_mast_wil.btnhapusClick(Sender: TObject);
begin
 with dm.qry_kawasan do
  begin
    if MessageDlg('Apakah Data Akan Dihapus', mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
       Delete;
       FormShow(Sender);
       MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
     end;
  end;
end;

procedure Tf_mast_wil.konek;
begin
 with dm.qry_kawasan do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kawasan order by kd_kawasan asc';
    Open;
  end;
end;

procedure Tf_mast_wil.edtpencarianKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if edtpencarian.Text='' then konek else
  begin
    with dm.qry_kawasan do
     begin
       close;
       sql.Clear;
       sql.Text:='select * from tbl_kawasan where kd_kawasan like ''%'+edtpencarian.Text+'%'' or nm_kawasan like ''%'+edtpencarian.Text+'%''';
       Open;
     end;
  end;
end;

procedure Tf_mast_wil.edtnamaKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','a'..'z','A'..'Z','-','''','(',')',#13, #32, #9, #8]) then Key:=#0;
 if Key=#13 then
  begin
    if dm.qry_kawasan.Locate('nm_kawasan',edtnama.Text,[]) then
     begin
       MessageDlg('Nama Kawasan Sudah Ada',mtInformation,[mbok],0);
       edtnama.Clear;
       edtnama.SetFocus;
     end
     else
    mmoalamat.SetFocus;
  end;

end;

procedure Tf_mast_wil.mmoalamatKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','a'..'z','A'..'Z','-','''','(',')',',','.',#13, #32, #9, #8]) then Key:=#0;
 if Key=#13 then btnsimpan.SetFocus;
end;

end.
