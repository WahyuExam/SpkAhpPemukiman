unit u_datamodule;

interface

uses
  SysUtils, Classes, XPMan, DB, ADODB;

type
  Tdm = class(TDataModule)
    XPManifest1: TXPManifest;
    con1: TADOConnection;
    qry_kawasan: TADOQuery;
    ds_kawasan: TDataSource;
    qry_kriteria: TADOQuery;
    ds_kriteria: TDataSource;
    qry_sub_kriteria: TADOQuery;
    qry_tampil_sub_kriteria: TADOQuery;
    ds_sub_kriteria: TDataSource;
    qry_kriteria2: TADOQuery;
    ds_kriteria2: TDataSource;
    qry_tmp_kriteria: TADOQuery;
    ds_tmp_kriteria: TDataSource;
    qry_indek: TADOQuery;
    qry_kriteria_tampil: TADOQuery;
    ds_kriteria_tampil: TDataSource;
    qry_tmp_sub_kriteria: TADOQuery;
    ds_tmp_sub_kriteria: TDataSource;
    qry_penilaian: TADOQuery;
    qry_tampil_penilaian: TADOQuery;
    ds_tampil_penilaian: TDataSource;
    qry_rangking: TADOQuery;
    qry_tampil_rangking: TADOQuery;
    ds_tapil_rangking: TDataSource;
    tbladmin: TADOTable;
    ds_sub_kriteria2: TDataSource;
    qry_nil_paramaeter: TADOQuery;
    ds_nil_parameter: TDataSource;
    qry_parameter_nil: TADOQuery;
    ds_parameter_nil: TDataSource;
    qry_jawab: TADOQuery;
    dsjawab: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
var ss : string;
begin
 con1.Connected:=false;
 getdir(0,ss);
 con1.ConnectionString:=
 'Provider=Microsoft.Jet.OLEDB.4.0;'+
 'Data Source='+ ss +'\db_ahp.mdb;';
 con1.Connected:=true;

 //aktif semua
 qry_kawasan.Active:=True;
 qry_indek.Active:=True;
 qry_kriteria.Active:=True;
 qry_kriteria2.Active:=True;
 qry_kriteria_tampil.Active:=True;
 qry_tmp_kriteria.Active:=True;

 qry_sub_kriteria.Active:=True;
 qry_tmp_sub_kriteria.Active:=True;
 qry_tampil_sub_kriteria.Active:=True;

 qry_penilaian.Active:=True;
 qry_tampil_penilaian.Active:=True;
 qry_rangking.Active:=True;

 qry_tampil_rangking.Active:=True;
 tbladmin.Active:=True;

 qry_nil_paramaeter.Active:=True;
 qry_parameter_nil.Active:=True;

 qry_jawab.Active:=True;
end;

end.
