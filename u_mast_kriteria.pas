unit u_mast_kriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_mast_kriteria = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    edtkode: TEdit;
    edtnama: TEdit;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    btnkeluar: TBitBtn;
    grp4: TGroupBox;
    grp5: TGroupBox;
    lbl5: TLabel;
    edtpencarian: TEdit;
    edtnama_lama: TEdit;
    dbgrd1: TDBGrid;
    img1: TImage;
    procedure FormShow(Sender: TObject);
    procedure btncampurClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure btnhapusClick(Sender: TObject);
    procedure btnkeluarClick(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure edtpencarianKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtnamaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure konek;
  end;

var
  f_mast_kriteria: Tf_mast_kriteria;
  status, kode : string;

implementation

uses
  u_datamodule, StrUtils, DB;

{$R *.dfm}

{ Tf_mast_kriteria }

procedure Tf_mast_kriteria.konek;
begin
 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
  end;
end;

procedure Tf_mast_kriteria.FormShow(Sender: TObject);
begin
 edtkode.Enabled:=false; edtkode.Clear;
 edtnama.Enabled:=false; edtnama.Clear;

 btncampur.Enabled:=True; btncampur.Caption:='Tambah';
 btnsimpan.Enabled:=false;
 btnubah.Enabled:=false;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=True;

 dbgrd1.Enabled:=True;

 edtpencarian.Clear; edtpencarian.Enabled:=True;

 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
  end;
end;

procedure Tf_mast_kriteria.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
    konek;
    with dm.qry_kriteria do
      begin
       if IsEmpty then kode := '001' else
        begin
         Last;
         kode := RightStr(fieldbyname('kd_kriteria').AsString,3);
         kode := IntToStr(StrToInt(kode)+1);
        end;
      end;
     edtkode.Text:='KRT-'+Format('%.3d',[StrToInt(kode)]);

     edtnama.Enabled:=True; edtnama.SetFocus;

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

procedure Tf_mast_kriteria.btnsimpanClick(Sender: TObject);
begin
 if Trim(edtnama.Text)='' then
  begin
    MessageDlg('Nama Kriteria Belum Diisi',mtInformation,[mbOK],0);
    edtnama.Clear; edtnama.SetFocus;
    Exit;
  end;

  with dm.qry_kriteria do
   begin
     if status='tambah' then
      begin
        if Locate('nm_kriteria',edtnama.Text,[]) then
          begin
            MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
            Exit;
          end
          else
          begin
            Append;
            FieldByName('kd_kriteria').AsString := edtkode.Text;
          end;
      end
      else
     if status='ubah' then
      begin
        if edtnama.Text=edtnama_lama.Text then
         begin
          if Locate('kd_kriteria',edtkode.Text,[]) then Edit;
         end
         else
        if edtnama.Text<>edtnama_lama.Text then
         begin
           if Locate('nm_kriteria',edtnama.Text,[]) then
             begin
              MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
              Exit;
             end
           else
           begin
             if Locate('kd_kriteria',edtkode.Text,[]) then Edit;
           end;
         end;
      end;

      FieldByName('nm_kriteria').AsString:=edtnama.Text;
      FieldByName('nl_prioritas').AsString:='0';
      Post;

      FormShow(Sender);
      MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
   end;
end;

procedure Tf_mast_kriteria.btnubahClick(Sender: TObject);
begin
 status:='ubah';

 edtnama.Enabled:=True;  edtnama.SetFocus;

 btncampur.Caption:='Batal';
 btnsimpan.Enabled:=True;
 btnubah.Enabled:=False;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=False;

 dbgrd1.Enabled:=false;
 edtpencarian.Enabled:=false; edtpencarian.Clear;

end;

procedure Tf_mast_kriteria.btnhapusClick(Sender: TObject);
begin
  with dm.qry_tmp_kriteria do
   begin
     Close;
     SQL.Clear;
     SQL.Text:='delete from tbl_tmp_kriteria where kd_kriteria2='+QuotedStr(dbgrd1.Fields[0].AsString)+'';
     ExecSQL;
   end;

  with dm.qry_kriteria do
  begin
    if MessageDlg('Apakah Data Akan Dihapus', mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
       Delete;
       FormShow(Sender);
       MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
     end;
  end;
end;

procedure Tf_mast_kriteria.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_mast_kriteria.dbgrd1DblClick(Sender: TObject);
begin
 edtkode.Text := dbgrd1.Fields[0].AsString;

 if edtkode.Text = '' then Exit else
  begin
    edtnama.Text := dbgrd1.Fields[1].AsString;
    edtnama_lama.Text := dbgrd1.Fields[1].AsString;

    btncampur.Caption:='Batal';
    btnsimpan.Enabled:=false;
    btnubah.Enabled:=True; btnhapus.Enabled:=True;
    btnkeluar.Enabled:=False;
  end;

end;

procedure Tf_mast_kriteria.edtpencarianKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if edtpencarian.Text='' then konek else
  begin
    with dm.qry_kriteria do
     begin
       close;
       sql.Clear;
       sql.Text:='select * from tbl_kriteria where kd_kriteria like ''%'+edtpencarian.Text+'%'' or nm_kriteria like ''%'+edtpencarian.Text+'%''';
       Open;
     end;
  end;
end;

procedure Tf_mast_kriteria.edtnamaKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','a'..'z','A'..'Z','-','''','(',')',#13, #32, #9, #8]) then Key:=#0;
 if Key=#13 then btnsimpan.SetFocus;
end;

end.
