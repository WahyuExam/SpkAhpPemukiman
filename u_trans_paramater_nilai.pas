unit u_trans_paramater_nilai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, jpeg, ExtCtrls, Grids, DBGrids, Buttons;

type
  Tf_trans_parameter_nilai = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dblkcbbsubkriteria: TDBLookupComboBox;
    cbbnilai: TComboBox;
    mmoparameter: TMemo;
    grp3: TGroupBox;
    lbl2: TLabel;
    dblkcbbkriteria: TDBLookupComboBox;
    dbgrd1: TDBGrid;
    grp4: TGroupBox;
    img1: TImage;
    btntambah: TBitBtn;
    btnsimpan: TBitBtn;
    btnhapus: TBitBtn;
    btnubah: TBitBtn;
    btnkeluar: TBitBtn;
    btnbatal1: TBitBtn;
    btnsimpan2: TBitBtn;
    edtnilai: TEdit;
    mmo_parameterbantu: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnkeluarClick(Sender: TObject);
    procedure btntambahClick(Sender: TObject);
    procedure dblkcbbkriteriaCloseUp(Sender: TObject);
    procedure dblkcbbsubkriteriaCloseUp(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure mmoparameterChange(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure btnhapusClick(Sender: TObject);
    procedure btnubahClick(Sender: TObject);
    procedure btnbatal1Click(Sender: TObject);
    procedure btnsimpan2Click(Sender: TObject);
    procedure mmoparameterKeyPress(Sender: TObject; var Key: Char);
    procedure cbbnilaiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure konek_kosong;
    procedure tambahan;
    procedure kode_parameter;
  end;

var
  f_trans_parameter_nilai: Tf_trans_parameter_nilai;
  kode, kd_parameter : string;

implementation

uses
  u_datamodule, DB, StrUtils;

{$R *.dfm}

procedure Tf_trans_parameter_nilai.FormShow(Sender: TObject);
begin
 dblkcbbkriteria.Enabled:=True; dblkcbbkriteria.KeyValue:=Null; dblkcbbkriteria.SetFocus;
 dblkcbbsubkriteria.Enabled:=True;; dblkcbbsubkriteria.KeyValue:=Null;
 mmoparameter.Enabled:=false; mmoparameter.Clear;
 cbbnilai.Enabled:=false; cbbnilai.Text:='';

 dbgrd1.Enabled:=false;

 btntambah.Enabled:=True; btntambah.Caption:='Tambah'; btntambah.BringToFront;
 btnsimpan.Enabled:=False; btnsimpan.Caption:='Simpan'; btnsimpan.BringToFront;
 btnubah.Enabled:=false;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=True;
 konek_kosong;

 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
  end;
end;

procedure Tf_trans_parameter_nilai.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_trans_parameter_nilai.btntambahClick(Sender: TObject);
begin
 if btntambah.Caption='Tambah' then
  begin
   if (dblkcbbkriteria.KeyValue=null) or (dblkcbbsubkriteria.KeyValue=null) then
    begin
      MessageDlg('Kriteria dan Subkriteria Wajib Diisi',mtWarning,[mbok],0);
      Exit;
    end;

   kode_parameter;

   mmoparameter.Enabled:=True; mmoparameter.SetFocus;
   cbbnilai.Enabled:=True;
   dbgrd1.Enabled:=false;

   dblkcbbsubkriteria.Enabled:=false;
   dblkcbbkriteria.Enabled:=False;

   btntambah.Caption:='Batal';
   btnsimpan.Enabled:=True;
   btnubah.Enabled:=false;
   btnhapus.Enabled:=false;
   btnkeluar.Enabled:=false;
  end
  else
 if btntambah.Caption='Batal' then
  begin
    FormShow(Sender);
  end;
end;

procedure Tf_trans_parameter_nilai.dblkcbbkriteriaCloseUp(Sender: TObject);
begin
 if dblkcbbkriteria.KeyValue=Null then Exit;
 with dm.qry_sub_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbbkriteria.KeyValue)+'';
    Open;
  end;

  dblkcbbsubkriteria.KeyValue:=Null;
  konek_kosong;
end;

procedure Tf_trans_parameter_nilai.konek_kosong;
begin
 with dm.qry_nil_paramaeter do
  begin
    close;
    SQL.Clear;
    SQL.Add('select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.nil_param from tbl_sub_kriteria a,');
    SQL.Add('tbl_nil_sub_kriteria b where b.kd_sub_kriteria=a.kd_sub_kriteria and a.kd_sub_kriteria='+QuotedStr('kosong')+'');
    Open;
  end;
end;

procedure Tf_trans_parameter_nilai.dblkcbbsubkriteriaCloseUp(
  Sender: TObject);
begin
 if dblkcbbsubkriteria.KeyValue=Null then Exit;
 dbgrd1.Enabled:=True;
 with dm.qry_nil_paramaeter do
  begin
    close;
    SQL.Clear;
    SQL.Add('select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.nil_param from tbl_sub_kriteria a,');
    SQL.Add('tbl_nil_sub_kriteria b where b.kd_sub_kriteria=a.kd_sub_kriteria and a.kd_sub_kriteria='+QuotedStr(dblkcbbsubkriteria.KeyValue)+'');
    Open;
  end;

end;

procedure Tf_trans_parameter_nilai.btnsimpanClick(Sender: TObject);
begin
 if btnsimpan.Caption='Simpan' then
  begin
   if (mmoparameter.Text='') or (cbbnilai.Text='') then
    begin
     MessageDlg('Semua Data Wajib Diisi',mtWarning,[mbok],0);
     mmoparameter.SetFocus;
     Exit;
    end;

     //simpan data
    with dm.qry_parameter_nil do
     begin
      if Locate('kd_sub_kriteria;parameter_nil',VarArrayOf([dblkcbbsubkriteria.KeyValue,mmoparameter.Text]),[]) then
       begin
         MessageDlg('Parameter Pada Subkriteria Ini Sudah Ada',mtWarning,[mbOK],0);
         mmoparameter.SetFocus;
         Exit;
       end;

       if Locate('kd_sub_kriteria;nil_param',VarArrayOf([dblkcbbsubkriteria.KeyValue,cbbnilai.Text]),[]) then
       begin
         MessageDlg('Nilai Parameter Pada Subkriteria Ini Sudah Digunakan',mtWarning,[mbOK],0);
         cbbnilai.SetFocus;
         Exit;
       end;

       Append;
       FieldByName('kd_parameter').AsString := kd_parameter;
       FieldByName('kd_sub_kriteria').AsString := dblkcbbsubkriteria.KeyValue;
       FieldByName('parameter_nil').AsString := mmoparameter.Text;
       FieldByName('nil_param').AsString := cbbnilai.Text;
       Post;
     end;

     with dm.qry_nil_paramaeter do
      begin
       close;
       sql.Clear;
       sql.Add('select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.nil_param from tbl_sub_kriteria a,');
       SQL.Add('tbl_nil_sub_kriteria b where b.kd_sub_kriteria=a.kd_sub_kriteria and a.kd_sub_kriteria='+QuotedStr(dblkcbbsubkriteria.KeyValue)+'');
       Open;
      end;

     kode_parameter;
     MessageDlg('Data Sudah Ditambahkan',mtInformation,[mbok],0);
     mmoparameter.Clear; mmoparameter.SetFocus;
     cbbnilai.Text:='';
     btnsimpan.Caption:='Selesai';
  end
  else
 if btnsimpan.Caption='Selesai' then
  begin
    FormShow(Sender);
    MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
  end;
end;

procedure Tf_trans_parameter_nilai.mmoparameterChange(Sender: TObject);
begin
 btnsimpan.Caption:='Simpan';
end;

procedure Tf_trans_parameter_nilai.dbgrd1CellClick(Column: TColumn);
begin
 mmoparameter.Text:=dbgrd1.Fields[2].AsString; mmoparameter.Enabled:=False;
 cbbnilai.Text:=dbgrd1.Fields[3].AsString; cbbnilai.Enabled:=false;

 mmo_parameterbantu.Text:=dbgrd1.Fields[2].AsString;
 edtnilai.Text:=dbgrd1.Fields[3].AsString;

 btnubah.Enabled:=True;
 btnbatal1.BringToFront;
 btnkeluar.Enabled:=false;
 btnhapus.Enabled:=True;
end;

procedure Tf_trans_parameter_nilai.btnhapusClick(Sender: TObject);
begin
 if MessageDlg('Yakin Data Akan Dihapus ?',mtConfirmation,[mbYes,mbNo],0)=mryes then
  begin
    with dm.qry_parameter_nil do
     begin
       if Locate('kd_sub_kriteria;parameter_nil',VarArrayOf([dblkcbbsubkriteria.KeyValue,mmoparameter.Text]),[]) then
        begin
          Delete;
        end;
     end;

     with dm.qry_nil_paramaeter do
      begin
       close;
       sql.Clear;
       sql.Add('select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.nil_param from tbl_sub_kriteria a,');
       SQL.Add('tbl_nil_sub_kriteria b where b.kd_sub_kriteria=a.kd_sub_kriteria and a.kd_sub_kriteria='+QuotedStr(dblkcbbsubkriteria.KeyValue)+'');
       Open;
      end;

     MessageDlg('Data Sudah Dihapus',mtInformation,[mbok],0);

     tambahan;
     dbgrd1.Enabled:=True;
  end;
end;

procedure Tf_trans_parameter_nilai.btnubahClick(Sender: TObject);
begin
 mmoparameter.Enabled:=True; mmoparameter.SetFocus;
 cbbnilai.Enabled:=True;

 btnbatal1.BringToFront;
 btnubah.Enabled:=false;
 btnsimpan2.BringToFront;
 btnhapus.Enabled:=false;

 dblkcbbkriteria.Enabled:=false;
 dblkcbbsubkriteria.Enabled:=false;
end;

procedure Tf_trans_parameter_nilai.btnbatal1Click(Sender: TObject);
begin
 mmoparameter.Clear;
 cbbnilai.Text:='';

 btnbatal1.SendToBack;
 btnubah.Enabled:=false;
 btnkeluar.Enabled:=True;
 btnsimpan2.SendToBack;
 btnhapus.Enabled:=false;
end;

procedure Tf_trans_parameter_nilai.btnsimpan2Click(Sender: TObject);
begin
  if (mmoparameter.Text=mmo_parameterbantu.Text) and (cbbnilai.Text=edtnilai.Text) then
  begin
    with dm.qry_nil_paramaeter do
      begin
       close;
       sql.Clear;
       sql.Add('select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.nil_param from tbl_sub_kriteria a,');
       SQL.Add('tbl_nil_sub_kriteria b where b.kd_sub_kriteria=a.kd_sub_kriteria and a.kd_sub_kriteria='+QuotedStr(dblkcbbsubkriteria.KeyValue)+'');
       Open;
      end;

     MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
     mmoparameter.Clear; mmoparameter.SetFocus;
     cbbnilai.Text:='';

     tambahan;
     dbgrd1.Enabled:=True;
  end
  else
 if (mmoparameter.Text<>mmo_parameterbantu.Text) or (cbbnilai.Text<>edtnilai.Text) then
  begin
    with dm.qry_parameter_nil do
     begin
       if mmoparameter.Text<>mmo_parameterbantu.Text then
        begin
         if Locate('parameter_nil;kd_sub_kriteria',VarArrayOf([mmoparameter.Text,dblkcbbsubkriteria.KeyValue]),[]) then
          begin
           MessageDlg('Parameter Pada Subkriteria Ini Sudah Ada',mtWarning,[mbOK],0);
           mmoparameter.SetFocus;
           Exit;
          end;
        end;

       if cbbnilai.Text<>edtnilai.Text then
        begin
         if Locate('nil_param;kd_sub_kriteria',VarArrayOf([cbbnilai.Text,dblkcbbsubkriteria.KeyValue]),[]) then
          begin
           MessageDlg('Nilai Parameter Pada Subkriteria Ini Sudah Digunakan',mtWarning,[mbOK],0);
           cbbnilai.SetFocus;
           Exit;
          end;
        end;

       if Locate('parameter_nil;kd_sub_kriteria',VarArrayOf([mmo_parameterbantu.Text,dblkcbbsubkriteria.KeyValue]) ,[]) then
        begin
         Edit;
         FieldByName('parameter_nil').AsString := mmoparameter.Text;
         FieldByName('nil_param').AsString := cbbnilai.Text;
         Post;
        end;
     end;

     with dm.qry_nil_paramaeter do
      begin
       close;
       sql.Clear;
       sql.Add('select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.nil_param from tbl_sub_kriteria a,');
       SQL.Add('tbl_nil_sub_kriteria b where b.kd_sub_kriteria=a.kd_sub_kriteria and a.kd_sub_kriteria='+QuotedStr(dblkcbbsubkriteria.KeyValue)+'');
       Open;
      end;

     MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
     mmoparameter.Clear; mmoparameter.SetFocus;
     cbbnilai.Text:='';

     tambahan;
     dbgrd1.Enabled:=True;
  end;

end;

procedure Tf_trans_parameter_nilai.tambahan;
begin
 dblkcbbkriteria.Enabled:=True; dblkcbbkriteria.SetFocus;
 dblkcbbsubkriteria.Enabled:=True;
 mmoparameter.Enabled:=false; mmoparameter.Clear;
 cbbnilai.Enabled:=false; cbbnilai.Text:='';

 dbgrd1.Enabled:=false;

 btntambah.Enabled:=True; btntambah.Caption:='Tambah'; btntambah.BringToFront;
 btnsimpan.Enabled:=False; btnsimpan.Caption:='Simpan'; btnsimpan.BringToFront;
 btnubah.Enabled:=false;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=True;
end;

procedure Tf_trans_parameter_nilai.kode_parameter;
begin
with dm.qry_parameter_nil do
    begin
      close;
      SQL.Clear;
      SQL.Text:='select * from tbl_nil_sub_kriteria order by kd_parameter asc';
      Open;

      if IsEmpty then kode := '001' else
       begin
         Last;
         kode := RightStr(fieldbyname('kd_parameter').AsString,3);
         kode := IntToStr(StrToInt(kode)+1);
       end;
    end;

   kd_parameter := 'NPR-'+Format('%.3d',[StrToInt(kode)]);
end;

procedure Tf_trans_parameter_nilai.mmoparameterKeyPress(Sender: TObject;
  var Key: Char);
begin
 if key=#13 then
  begin
    if dm.qry_parameter_nil.Locate('parameter_nil',mmoparameter.Text,[]) then
     begin
       MessageDlg('Parameter Nilai Sudah Ada',mtInformation,[mbok],0);
       mmoparameter.Clear;
       mmoparameter.SetFocus;
       cbbnilai.Enabled:=False;
       cbbnilai.ItemIndex:=-1;
     end
     else
     begin
      cbbnilai.Enabled:=True; cbbnilai.SetFocus;
     end
  end;
end;

procedure Tf_trans_parameter_nilai.cbbnilaiClick(Sender: TObject);
begin
 with dm.qry_parameter_nil do
  begin
    if Locate('kd_sub_kriteria;nil_param',VarArrayOf([dblkcbbsubkriteria.KeyValue,cbbnilai.Text]),[]) then
       begin
         MessageDlg('Nilai Parameter Pada Subkriteria Ini Sudah Digunakan',mtWarning,[mbOK],0);
         cbbnilai.SetFocus;
         Exit;
       end;
  end;

end;

end.
