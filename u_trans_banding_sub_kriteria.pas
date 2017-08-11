unit u_trans_banding_sub_kriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_trans_banding_sub_kriteria = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    cbb_nilai: TComboBox;
    btn_setnilai: TBitBtn;
    btn_batal: TBitBtn;
    edt_krteria1: TEdit;
    edt_kriteria2: TEdit;
    grp3: TGroupBox;
    dbgrd1: TDBGrid;
    grp4: TGroupBox;
    dbgrd2: TDBGrid;
    grp5: TGroupBox;
    btn_keluar: TBitBtn;
    btnkonsistensi: TBitBtn;
    grp7: TGroupBox;
    lbl14: TLabel;
    dblkcbb1: TDBLookupComboBox;
    img1: TImage;
    procedure FormShow(Sender: TObject);
    procedure dblkcbb1CloseUp(Sender: TObject);
    procedure btn_keluarClick(Sender: TObject);
    procedure btnkonsistensiClick(Sender: TObject);
    procedure dbgrd2DblClick(Sender: TObject);
    procedure btn_batalClick(Sender: TObject);
    procedure btn_setnilaiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_trans_banding_sub_kriteria: Tf_trans_banding_sub_kriteria;
  a, b, c, jml_data : Integer;
  status, kode_kriteria1, kriteria1, kriteria2, kode_kriteria2, kode_kriteria_akhir : string;
  hasil_bagi, hasil_jumlah, hasil_kali1, jml_hasil_kali1, totatl_hasil_kali, prioritas, jml_prioritas,
  prioritas_maksimum, konsistensi, rasio_konsistensi : Real;

implementation

uses
  u_datamodule, DB, ADODB, u_lihat_hitung_sub_kriteria;

{$R *.dfm}

procedure Tf_trans_banding_sub_kriteria.FormShow(Sender: TObject);
begin
 dbgrd2.Enabled:=True;

 btnkonsistensi.Caption:='Cek Konsistensi';
 btnkonsistensi.Enabled:=false;
 edt_krteria1.Clear;
 edt_kriteria2.Clear;
 cbb_nilai.Enabled:=False; cbb_nilai.Text:='';

 btn_setnilai.Enabled:=false;
 btn_batal.Enabled:=false;
 btn_keluar.Enabled:=True;
 dblkcbb1.KeyValue:=Null;

 //refresh kriteria
 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open
  end;

  dblkcbb1.Enabled:=True;

  //refresh nil_banding
  with dm.qry_tmp_sub_kriteria do
   begin
     close;
     SQL.Clear;
     sql.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr('kosong')+'';
     Open;
   end;

   //refresh nil_priorotas
   with dm.qry_tampil_sub_kriteria do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select a.kd_sub_kriteria, b.kd_kriteria, b.nm_kriteria, a.nm_sub_kriteria, a.nl_sub from tbl_sub_kriteria a,');
      SQL.Add('tbl_kriteria b where a.kd_kriteria=b.kd_kriteria and b.kd_kriteria='+QuotedStr('kososng')+'');
      Open;
    end;
end;

procedure Tf_trans_banding_sub_kriteria.dblkcbb1CloseUp(Sender: TObject);
begin
 if dblkcbb1.KeyValue=Null then Exit else
  begin
    with dm.qry_tmp_sub_kriteria do
     begin
      close;
      sql.Clear;
      SQL.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+'';
      Open;

      for a:=1 to RecordCount do
       begin
         RecNo:=a;
         if FieldByName('nil').AsString='' then Delete;
       end;
      a:=a+1;

      for a:=1 to RecordCount do
       begin
         RecNo:=a;
         
       end;
      a:=a+1;
     end;

   with dm.qry_sub_kriteria do
    begin
     Close;
     SQL.Clear;
     SQL.Text:='select * from tbl_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+' order by kd_sub_kriteria asc ';
     Open;

     jml_data := RecordCount-1;

     for a:=1 to jml_data do
      begin
        RecNo :=a;

        kode_kriteria1 := fieldbyname('kd_sub_kriteria').AsString;
        kriteria1 := fieldbyname('nm_sub_kriteria').AsString;

        Close;
        SQL.Clear;
        SQL.Text:='select * from tbl_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+' order by kd_sub_kriteria asc ';
        Open;

        for b:=1 to RecordCount-a do
         begin
           RecNo :=b+a;
           kriteria2 := fieldbyname('nm_sub_kriteria').AsString;
           kode_kriteria2 := fieldbyname('kd_sub_kriteria').AsString;

           with dm.qry_tmp_sub_kriteria do
            begin
              Close;
              sql.Clear;
              SQL.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+' and  kd_sub_kriteria1='+QuotedStr(kode_kriteria1)+' and kd_sub_kriteria2='+QuotedStr(kode_kriteria2)+'';
              Open;

              if IsEmpty then Append else Edit;

              FieldByName('kd_kriteria').AsString := dblkcbb1.KeyValue;
              FieldByName('kd_sub_kriteria1').AsString := kode_kriteria1;
              FieldByName('kd_sub_kriteria2').AsString := kode_kriteria2;
              FieldByName('nm_sub_kriteria1').AsString := kriteria1;
              FieldByName('nm_sub_kriteria2').AsString := kriteria2;
              Post;
            end;
         end;
         b:=b+1;
      end;
      a:=a+1;
    end;

  //refresh database
  with dm.qry_tmp_sub_kriteria do
   begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+' order by kd_sub_kriteria1 asc, kd_sub_kriteria2 asc';
     Open;
   end;

   //refresh nil_priorotas
   with dm.qry_tampil_sub_kriteria do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select a.kd_sub_kriteria, b.kd_kriteria, b.nm_kriteria, a.nm_sub_kriteria, a.nl_sub from tbl_sub_kriteria a,');
      SQL.Add('tbl_kriteria b where a.kd_kriteria=b.kd_kriteria and b.kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+'');
      Open;
    end;
    btnkonsistensi.Enabled:=True;
  end;
end;

procedure Tf_trans_banding_sub_kriteria.btn_keluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_trans_banding_sub_kriteria.btnkonsistensiClick(
  Sender: TObject);
begin
if btnkonsistensi.Caption='Cek Konsistensi' then
 begin
  with dm.qry_tmp_sub_kriteria do
   begin
    Close;
    SQL.Clear;
    SQL.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+'';
    Open;

    for a:=1 to RecordCount do
     begin
       RecNo:=a;

       if FieldByName('nil').AsString='' then
        begin
          MessageDlg('Semua Sub Kriteria Harus Dibandingkan',mtInformation,[mbOK],0);
          RecNo:=a;
          with dm.qry_tmp_sub_kriteria do
           begin
            close;
            SQL.Clear;
            SQL.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+' order by kd_sub_kriteria1 asc, kd_sub_kriteria2 asc';
            Open;
           end;

          Exit;
        end
     end;
     a:=a+1;
   end;

  with f_lihat_hitung_sub_kriteria do
   begin
     edtkd_kriteria.Text:=dblkcbb1.KeyValue;
     btn2.Click;
     if lbl11.Caption='Konsisten' then
      begin
        MessageDlg('Perhitungan Konsisten',mtInformation,[mbok],0);
        dblkcbb1.Enabled:=false;
        if MessageDlg('Tampilkan Perhitungan ?',mtConfirmation,[mbYes,mbNo],0)=mryes then f_lihat_hitung_sub_kriteria.ShowModal;
      end
      else
     if lbl11.Caption='Tidak Konsisten' then
      begin
        MessageDlg('Perhitungan Tidak Konsisten, Ulangi Nilai Perbandingan',mtInformation,[mbOK],0);
        if MessageDlg('Tampilkan Perhitungan ?',mtConfirmation,[mbYes,mbNo],0)=mryes then f_lihat_hitung_sub_kriteria.ShowModal else Exit;
      end;
   end;

   dbgrd2.Enabled:=False;
   dbgrd1.Enabled:=false;
   btn_batal.Enabled:=False;
   btn_setnilai.Enabled:=false;

   dbgrd1.Enabled:=True;
   btn_keluar.Enabled:=false;
   btnkonsistensi.Caption:='Bersih';
 end
 else
if btnkonsistensi.Caption='Bersih' then
 begin
  FormShow(Sender);
 end;
end;

procedure Tf_trans_banding_sub_kriteria.dbgrd2DblClick(Sender: TObject);
begin
 btn_setnilai.Enabled:=True;
 btn_batal.Enabled:=True;
 btn_keluar.Enabled:=false;
 btnkonsistensi.Enabled:=False;

 edt_krteria1.Text:=dbgrd2.Fields[3].AsString;
 edt_kriteria2.Text:=dbgrd2.Fields[4].AsString;
 if dbgrd2.Fields[5].AsString='' then
  begin
   cbb_nilai.Text:='';
   cbb_nilai.Enabled:=True;
  end
  else
  begin
    cbb_nilai.ItemIndex := StrToInt(dbgrd2.Fields[5].AsString)-1;
    if MessageDlg('Subkriteria Sudah Dibandingkan, Ingin Mengubah Nilai',mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
       cbb_nilai.Enabled:=True;
     end;
  end;

end;

procedure Tf_trans_banding_sub_kriteria.btn_batalClick(Sender: TObject);
begin
 FormShow(Sender);
end;

procedure Tf_trans_banding_sub_kriteria.btn_setnilaiClick(Sender: TObject);
begin
 if cbb_nilai.Text='' then
  begin
    MessageDlg('Nilai Perbandingan Belum Diisi',mtWarning,[mbOk],0);
    Exit;
  end;

  with dm.qry_tmp_sub_kriteria do
   begin
    if Locate('kd_kriteria;nm_sub_kriteria1;nm_sub_kriteria2',VarArrayOf([dblkcbb1.KeyValue,edt_krteria1.Text,edt_kriteria2.Text]),[]) then
     begin
       Edit;
       FieldByName('nil').AsString := IntToStr(cbb_nilai.ItemIndex+1);
       Post;
     end;
   end;

 //  FormShow(Sender);
    //refresh nil_banding
 
   with dm.qry_tmp_sub_kriteria do
    begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_tmp_sub_kriteria where kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+' order by kd_sub_kriteria1 asc, kd_sub_kriteria2 asc';
     Open;
    end;


   //refresh nil_priorotas
   with dm.qry_tampil_sub_kriteria do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select a.kd_sub_kriteria, b.kd_kriteria, b.nm_kriteria, a.nm_sub_kriteria, a.nl_sub from tbl_sub_kriteria a,');
      SQL.Add('tbl_kriteria b where a.kd_kriteria=b.kd_kriteria and b.kd_kriteria='+QuotedStr(dblkcbb1.KeyValue)+'');
      Open;
    end;


   edt_krteria1.Clear;
   edt_kriteria2.Clear;
   cbb_nilai.Text:='';
   btn_setnilai.Enabled:=false;
   btn_batal.Enabled:=false;

   MessageDlg('Data Sudah Disimpan',mtInformation,[mbOK],0);
   btnkonsistensi.Enabled:=True;
end;

end.
