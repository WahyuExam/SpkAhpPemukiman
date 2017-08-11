unit u_lap_rangking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, DBCtrls;

type
  Tf_lap_rangking = class(TForm)
    img1: TImage;
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    edttahun: TEdit;
    btncetak: TBitBtn;
    btnkeluar: TBitBtn;
    rb1: TRadioButton;
    rb2: TRadioButton;
    dblkcbb1: TDBLookupComboBox;
    cbbtahun: TComboBox;
    rb3: TRadioButton;
    procedure btnkeluarClick(Sender: TObject);
    procedure btncetakClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure dblkcbb1CloseUp(Sender: TObject);
    procedure cbbtahunCloseUp(Sender: TObject);
    procedure rb3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function tgl_indo(vtgl:TDate):string;
  end;

var
  f_lap_rangking: Tf_lap_rangking;
  thn_awl, thn_akhir, kode_awl, kode_akhir : string;
  a : Integer;

implementation

uses
  u_datamodule, u_report_rangking, DB, u_report_seluruh, report_nilai_2, 
  u_mast_kriteria, u_report_penilaian, u_lap_tanggung_jawab;

{$R *.dfm}
procedure Tf_lap_rangking.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_lap_rangking.btncetakClick(Sender: TObject);
begin
if cbbtahun.Text='' then
 begin
   MessageDlg('Tahun Belum Diisi',mtInformation,[mbok],0);
   cbbtahun.SetFocus;
   Exit;
 end;

 if (rb1.Checked=false) and (rb2.Checked=False) and (rb3.Checked=false) then
  begin
    MessageDlg('Jenis Laporan Belum Dipilih',mtInformation,[mbOK],0);
    Exit;
  end;

if rb1.Checked=True then
 begin
   with report_penilaian_semua.qry1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria, c.nm_sub_kriteria, c.nl_sub,');
      sql.add('d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl, a.ttl_nilai,');
      sql.Add('a.ket  from tbl_rangking a, tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan');
      sql.Add('and e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
      SQL.Add('and a.tahun='+QuotedStr(cbbtahun.Text)+' order by a.tahun asc, a.ttl_nilai desc, d.kd_kriteria asc, c.kd_sub_kriteria asc');
      Open;

      if IsEmpty then
       begin
         MessageDlg('Data Tidak Ada',mtInformation,[mbOK],0);
         Exit;
       end
      else
      begin
        report_penilaian_semua.qrlbl4.Caption:=tgl_indo(Now);
        report_penilaian_semua.qrlbl20.Caption:=dm.qry_jawab.fieldbyname('nm_jawab').AsString;
        report_penilaian_semua.QRLabel1.Caption:=cbbtahun.Text;
        report_penilaian_semua.Preview;
      end;
    end;
 end
 else
if rb2.Checked=True then
 begin
   if dblkcbb1.KeyValue=Null then
    begin
      MessageDlg('Kawasan Belum Diisi',mtInformation,[mbok],0);
      dblkcbb1.SetFocus;
      Exit;
    end;

    with report_penilaian.qry1 do
     begin
      Close;
      Close;
      SQL.Clear;
      SQL.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria, c.nm_sub_kriteria, c.nl_sub,');
      sql.add('d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl, a.ttl_nilai,');
      sql.Add('a.ket  from tbl_rangking a, tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan');
      sql.Add('and e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
      SQL.Add('and a.tahun='+QuotedStr(cbbtahun.Text)+' and b.kd_kawasan='+QuotedStr(dblkcbb1.KeyValue)+' order by a.tahun asc, a.ttl_nilai desc, d.kd_kriteria asc, c.kd_sub_kriteria asc');
      Open;

      if IsEmpty then
       begin
        MessageDlg('Data Tidak Ada',mtInformation,[mbOK],0);
        Exit;
       end
      else
      begin
       report_penilaian.qrlbl4.Caption:=tgl_indo(Now);
       report_penilaian.qrlbl20.Caption:=dm.qry_jawab.fieldbyname('nm_jawab').AsString;
       report_penilaian.qrlbl3.Caption:=cbbtahun.Text;
       report_penilaian.Preview;
      end;
     end;
 end
 else
if rb3.Checked=True then
 begin
  with dm.qry_tampil_rangking do
   begin
    close;
    sql.Clear;
    sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, b.almt_kawasan, a.ttl_nilai, a.ket from tbl_rangking a,');
    sql.Add('tbl_kawasan b where a.kd_kawasan=b.kd_kawasan and a.tahun='+QuotedStr(cbbtahun.Text)+' order by a.ttl_nilai desc');
    Open;

    if IsEmpty then
     begin
      MessageDlg('Data Kosong',mtInformation,[mbok],0);
      Exit;
     end
     else
     begin
       report_rangking.qrlbl10.Caption:=tgl_indo(Now);
       report_rangking.qrlbl12.Caption:=dm.qry_jawab.fieldbyname('nm_jawab').AsString;
       report_rangking.qrlbl3.Caption := cbbtahun.Text;
       report_rangking.Preview;
     end;
   end;
 end;
end;

procedure Tf_lap_rangking.edttahunKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then Key:=#0;
end;

procedure Tf_lap_rangking.FormShow(Sender: TObject);
begin
 rb1.Checked:=false;
 rb2.Checked:=false;
 rb3.Checked:=false;

 dblkcbb1.Enabled:=false; dblkcbb1.KeyValue:=Null;
 cbbtahun.ItemIndex:=-1;
 with dm.qry_rangking do
  begin
    close;
    SQL.Clear;
    SQL.Text := 'select * from tbl_rangking order by tahun asc';
    Open;

    First; thn_awl := fieldbyname('tahun').AsString;
    Last; thn_akhir := fieldbyname('tahun').AsString;
  end;

  cbbtahun.Clear;
  for a:= StrToInt(thn_awl) to StrToInt(thn_akhir)+5 do
   begin
     cbbtahun.Items.Add(IntToStr(a));
   end;
end;

procedure Tf_lap_rangking.rb1Click(Sender: TObject);
begin
 dblkcbb1.Enabled:=false; dblkcbb1.KeyValue:=Null;
end;

procedure Tf_lap_rangking.rb2Click(Sender: TObject);
begin
 dblkcbb1.Enabled:=True; dblkcbb1.KeyValue:=Null;
end;

procedure Tf_lap_rangking.dblkcbb1CloseUp(Sender: TObject);
begin
 if dblkcbb1.KeyValue=Null then Exit;
end;

procedure Tf_lap_rangking.cbbtahunCloseUp(Sender: TObject);
begin
 if cbbtahun.Text='' then Exit else
  begin
    with dm.qry_rangking do
     begin
       close;
       sql.Clear;
       SQL.Text:='select * from tbl_rangking where tahun='+QuotedStr(cbbtahun.Text)+' order by kd_kawasan asc';
       Open;

       First; kode_awl := fieldbyname('kd_kawasan').AsString;
       Last; kode_akhir := fieldbyname('kd_kawasan').AsString;
     end;

     with dm.qry_kawasan do
      begin
        close;
        SQL.Clear;
        SQL.Text:='select * from tbl_kawasan where kd_kawasan between kode_awal and kode_akhir order by kode_awal asc';
        Prepared;
        Parameters[0].Value:=kode_awl;
        Parameters[1].Value:=kode_akhir;
        Open;
      end;
  end;
end;

procedure Tf_lap_rangking.rb3Click(Sender: TObject);
begin
 dblkcbb1.Enabled:=false; dblkcbb1.KeyValue:=Null;
end;

function Tf_lap_rangking.tgl_indo(vtgl: TDate): string;
const
  nama_bulan : array[1..12] of string = ('Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember');

var
  a : Integer;
  bulan : string;
begin
  for a:=1 to 12 do
   begin
     LongMonthNames[a] := nama_bulan[a];
   end;
   a:=a+1;

   Result := FormatDateTime('dd mmmm yyyy',vtgl);
end;

end.
