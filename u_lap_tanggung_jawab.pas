unit u_lap_tanggung_jawab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, jpeg, ExtCtrls;

type
  Tf_lap_jawab = class(TForm)
    img1: TImage;
    grp1: TGroupBox;
    lbl1: TLabel;
    dblkcbb1: TDBLookupComboBox;
    btn1: TBitBtn;
    btn2: TBitBtn;
    edt1: TEdit;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure dblkcbb1CloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    function tgl_indo(vtgl:TDate):string;
  end;

var
  f_lap_jawab: Tf_lap_jawab;

implementation

uses
  u_datamodule, u_report_kawasan, u_report_nil_kriteria, u_report_sub_kriteria, 
  u_lap_perangkingan, report_nilai_semua2, report_nilai_2, u_report_seluruh, 
  u_lap_rangking, u_report_penilaian, u_report_rangking;

{$R *.dfm}

procedure Tf_lap_jawab.btn2Click(Sender: TObject);
begin
 close;
end;

procedure Tf_lap_jawab.btn1Click(Sender: TObject);
begin
 if dblkcbb1.KeyValue=null then
  begin
    MessageDlg('Penanggung Jawab Belum Dipilih',mtInformation,[mbok],0);
    dblkcbb1.SetFocus;
    Exit;
  end;

 if edt1.Text='kawasan' then
  begin
    report_kawasan.qrlbl10.Caption := tgl_indo(Now);
    report_kawasan.qrlbl12.Caption := dblkcbb1.Text;
    report_kawasan.Preview;
  end
  else
 if edt1.Text='kriteria' then
  begin
    report_kriteria.qrlbl10.Caption := tgl_indo(Now);
    report_kriteria.qrlbl12.Caption := dblkcbb1.Text;
    report_kriteria.Preview;
  end
  else
 if edt1.Text='subkriteria' then
  begin
    report_sub_kriteriia.qrlbl10.Caption := tgl_indo(Now);
    report_sub_kriteriia.qrlbl12.Caption := dblkcbb1.Text;
    report_sub_kriteriia.Preview;
  end
  else
 if edt1.Text='nilai_seluruh' then
  begin
    report_penilaian_semua_2.qrlbl10.Caption:=tgl_indo(Now);
    report_penilaian_semua_2.qrlbl19.Caption:= f_lap_rangkingan.cbbtahun.Text;
    report_penilaian_semua_2.qrlbl4.Caption:=dblkcbb1.Text;
    report_penilaian_semua_2.Preview;
  end
  else
 if edt1.Text='nilai_kawasan' then
  begin
    report_nilai2.qrlbl10.Caption:=tgl_indo(Now);
    report_nilai2.qrlbl4.Caption:=dblkcbb1.Text;
    report_nilai2.qrlbl3.Caption:=f_lap_rangkingan.cbbtahun.Text;
    report_nilai2.Preview;
  end
  else
 if edt1.Text='rank_seluruh' then
  begin
    report_penilaian_semua.qrlbl4.Caption:=tgl_indo(Now);
    report_penilaian_semua.qrlbl20.Caption:=dblkcbb1.Text;
    report_penilaian_semua.QRLabel1.Caption:=f_lap_rangking.cbbtahun.Text;
    report_penilaian_semua.Preview;
  end
  else
 if edt1.Text='rank_kawasan' then
  begin
    report_penilaian.qrlbl4.Caption:=tgl_indo(Now);
    report_penilaian.qrlbl20.Caption:=dblkcbb1.Text;
    report_penilaian.qrlbl3.Caption:=f_lap_rangking.cbbtahun.Text;
    report_penilaian.Preview;
  end
  else
 if edt1.Text='rank' then
  begin
    report_rangking.qrlbl10.Caption:=tgl_indo(Now);
    report_rangking.qrlbl12.Caption:=dblkcbb1.Text;
    report_rangking.qrlbl3.Caption := f_lap_rangking.cbbtahun.Text;
    report_rangking.Preview;
  end;
end;

function Tf_lap_jawab.tgl_indo(vtgl: TDate): string;
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

procedure Tf_lap_jawab.dblkcbb1CloseUp(Sender: TObject);
begin
 if dblkcbb1.KeyValue=Null then Exit;
end;

procedure Tf_lap_jawab.FormShow(Sender: TObject);
begin
 dblkcbb1.KeyValue:=Null;
end;

end.
