unit u_menuutama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls;

type
  Tf_menu = class(TForm)
    mm1: TMainMenu;
    Keluar1: TMenuItem;
    ransaksi1: TMenuItem;
    Laporan1: TMenuItem;
    Keluar2: TMenuItem;
    Wilayah1: TMenuItem;
    Kriteria1: TMenuItem;
    SubKriteria1: TMenuItem;
    PerbandinganKriteria1: TMenuItem;
    PerbandinganSubKriteria1: TMenuItem;
    Penilaian1: TMenuItem;
    PerangkinganAHP1: TMenuItem;
    LaporanKawasan1: TMenuItem;
    LaporanNilaiPrioritasKriteria1: TMenuItem;
    LaporanNilaiPrioritasSubkriteria1: TMenuItem;
    LaporanPerangkingan1: TMenuItem;
    Pengaturan1: TMenuItem;
    PanggildanSalinData1: TMenuItem;
    GantiKataSandi1: TMenuItem;
    img1: TImage;
    IndikatorPenilaianSubkriteia1: TMenuItem;
    LaporanPerangkingan2: TMenuItem;
    PenangungJawab1: TMenuItem;
    procedure Keluar2Click(Sender: TObject);
    procedure Wilayah1Click(Sender: TObject);
    procedure Kriteria1Click(Sender: TObject);
    procedure SubKriteria1Click(Sender: TObject);
    procedure PerbandinganKriteria1Click(Sender: TObject);
    procedure PerbandinganSubKriteria1Click(Sender: TObject);
    procedure Penilaian1Click(Sender: TObject);
    procedure PerangkinganAHP1Click(Sender: TObject);
    procedure LaporanKawasan1Click(Sender: TObject);
    procedure LaporanNilaiPrioritasKriteria1Click(Sender: TObject);
    procedure LaporanNilaiPrioritasSubkriteria1Click(Sender: TObject);
    procedure LaporanPerangkingan1Click(Sender: TObject);
    procedure PanggildanSalinData1Click(Sender: TObject);
    procedure GantiKataSandi1Click(Sender: TObject);
    procedure IndikatorPenilaianSubkriteia1Click(Sender: TObject);
    procedure LaporanPerangkingan2Click(Sender: TObject);
    procedure PenangungJawab1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function tgl_indo(vtgl:TDate):string;
  end;

var
  f_menu: Tf_menu;

implementation

uses
  u_mast_wilayah, u_mast_kriteria, u_mast_sub_kriteria, 
  u_trans_banding_kriteria, u_trans_banding_sub_kriteria, u_trans_penilaian, 
  u_trans_rangking, u_report_kawasan, u_report_nil_kriteria, 
  u_report_sub_kriteria, u_lap_perangkingan, u_backup, u_gantisandi, 
  u_datamodule, u_trans_paramater_nilai, u_lap_rangking, u_penanggung_jawab, 
  u_lap_tanggung_jawab;

{$R *.dfm}

procedure Tf_menu.Keluar2Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure Tf_menu.Wilayah1Click(Sender: TObject);
begin
 f_mast_wil.ShowModal;
end;

procedure Tf_menu.Kriteria1Click(Sender: TObject);
begin
 f_mast_kriteria.ShowModal;
end;

procedure Tf_menu.SubKriteria1Click(Sender: TObject);
begin
 f_mast_sub_kriteria.ShowModal;
end;

procedure Tf_menu.PerbandinganKriteria1Click(Sender: TObject);
begin
 f_trans_banding_kriteria.ShowModal;
end;

procedure Tf_menu.PerbandinganSubKriteria1Click(Sender: TObject);
begin
 f_trans_banding_sub_kriteria.ShowModal;
end;

procedure Tf_menu.Penilaian1Click(Sender: TObject);
begin
 f_trans_penilaian.ShowModal;
end;

procedure Tf_menu.PerangkinganAHP1Click(Sender: TObject);
begin
 f_trans_rangking.ShowModal;
end;

procedure Tf_menu.LaporanKawasan1Click(Sender: TObject);
begin
  report_kawasan.qrlbl10.Caption := tgl_indo(Now);
  report_kawasan.qrlbl12.Caption := dm.qry_jawab.fieldbyname('nm_jawab').AsString;
  report_kawasan.Preview;
end;

procedure Tf_menu.LaporanNilaiPrioritasKriteria1Click(Sender: TObject);
begin
 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
  end;

  report_kriteria.qrlbl10.Caption := tgl_indo(Now);
  report_kriteria.qrlbl12.Caption := dm.qry_jawab.fieldbyname('nm_jawab').AsString;
  report_kriteria.Preview;
end;

procedure Tf_menu.LaporanNilaiPrioritasSubkriteria1Click(Sender: TObject);
begin
 with dm.qry_sub_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_sub_kriteria order by kd_sub_kriteria asc';
    Open;
  end;

  report_sub_kriteriia.qrlbl10.Caption := tgl_indo(Now);
  report_sub_kriteriia.qrlbl12.Caption := dm.qry_jawab.fieldbyname('nm_jawab').AsString;
  report_sub_kriteriia.Preview;
end;

procedure Tf_menu.LaporanPerangkingan1Click(Sender: TObject);
begin
 with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
  end;
 f_lap_rangkingan.ShowModal;
end;

procedure Tf_menu.PanggildanSalinData1Click(Sender: TObject);
begin
 f_backup.ShowModal;
end;

procedure Tf_menu.GantiKataSandi1Click(Sender: TObject);
begin
 f_gantisandi.ShowModal;
end;

procedure Tf_menu.IndikatorPenilaianSubkriteia1Click(Sender: TObject);
begin
 f_trans_parameter_nilai.ShowModal;
end;

procedure Tf_menu.LaporanPerangkingan2Click(Sender: TObject);
begin
  with dm.qry_kriteria do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
    Open;
  end;

 f_lap_rangking.ShowModal; 
end;

procedure Tf_menu.PenangungJawab1Click(Sender: TObject);
begin
 f_penanggung_jawab.ShowModal;
end;

function Tf_menu.tgl_indo(vtgl: TDate): string;
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
