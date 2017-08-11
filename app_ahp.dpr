program app_ahp;

uses
  Forms,
  u_menuutama in 'u_menuutama.pas' {f_menu},
  u_mast_wilayah in 'u_mast_wilayah.pas' {f_mast_wil},
  u_datamodule in 'u_datamodule.pas' {dm: TDataModule},
  u_mast_kriteria in 'u_mast_kriteria.pas' {f_mast_kriteria},
  u_mast_sub_kriteria in 'u_mast_sub_kriteria.pas' {f_mast_sub_kriteria},
  u_trans_banding_kriteria in 'u_trans_banding_kriteria.pas' {f_trans_banding_kriteria},
  u_trans_banding_sub_kriteria in 'u_trans_banding_sub_kriteria.pas' {f_trans_banding_sub_kriteria},
  u_lihat_hitung_kriteria in 'u_lihat_hitung_kriteria.pas' {f_lihat_hitung_kriteria},
  u_lihat_hitung_sub_kriteria in 'u_lihat_hitung_sub_kriteria.pas' {f_lihat_hitung_sub_kriteria},
  u_trans_penilaian in 'u_trans_penilaian.pas' {f_trans_penilaian},
  u_trans_rangking in 'u_trans_rangking.pas' {f_trans_rangking},
  u_report_kawasan in 'u_report_kawasan.pas' {report_kawasan: TQuickRep},
  u_report_nil_kriteria in 'u_report_nil_kriteria.pas' {report_kriteria: TQuickRep},
  u_report_sub_kriteria in 'u_report_sub_kriteria.pas' {report_sub_kriteriia: TQuickRep},
  u_lap_perangkingan in 'u_lap_perangkingan.pas' {f_lap_rangkingan},
  u_report_penilaian in 'u_report_penilaian.pas' {report_penilaian: TQuickRep},
  u_login in 'u_login.pas' {f_login},
  u_backup in 'u_backup.pas' {f_backup},
  u_gantisandi in 'u_gantisandi.pas' {f_gantisandi},
  u_report_seluruh in 'u_report_seluruh.pas' {report_penilaian_semua: TQuickRep},
  u_trans_paramater_nilai in 'u_trans_paramater_nilai.pas' {f_trans_parameter_nilai},
  report_nilai_semua2 in 'report_nilai_semua2.pas' {report_penilaian_semua_2: TQuickRep},
  report_nilai_2 in 'report_nilai_2.pas' {report_nilai2: TQuickRep},
  u_lap_rangking in 'u_lap_rangking.pas' {f_lap_rangking},
  u_report_rangking in 'u_report_rangking.pas' {report_rangking: TQuickRep},
  u_penanggung_jawab in 'u_penanggung_jawab.pas' {f_penanggung_jawab},
  u_lap_tanggung_jawab in 'u_lap_tanggung_jawab.pas' {f_lap_jawab};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_login, f_login);
  Application.CreateForm(Tf_menu, f_menu);
  Application.CreateForm(Tf_mast_wil, f_mast_wil);
  Application.CreateForm(Tf_mast_kriteria, f_mast_kriteria);
  Application.CreateForm(Tf_mast_sub_kriteria, f_mast_sub_kriteria);
  Application.CreateForm(Tf_trans_banding_kriteria, f_trans_banding_kriteria);
  Application.CreateForm(Tf_trans_banding_sub_kriteria, f_trans_banding_sub_kriteria);
  Application.CreateForm(Tf_lihat_hitung_kriteria, f_lihat_hitung_kriteria);
  Application.CreateForm(Tf_lihat_hitung_sub_kriteria, f_lihat_hitung_sub_kriteria);
  Application.CreateForm(Tf_trans_penilaian, f_trans_penilaian);
  Application.CreateForm(Tf_trans_rangking, f_trans_rangking);
  Application.CreateForm(Treport_kawasan, report_kawasan);
  Application.CreateForm(Tf_penanggung_jawab, f_penanggung_jawab);
  Application.CreateForm(Treport_kriteria, report_kriteria);
  Application.CreateForm(Treport_sub_kriteriia, report_sub_kriteriia);
  Application.CreateForm(Tf_lap_rangkingan, f_lap_rangkingan);
  Application.CreateForm(Tf_backup, f_backup);
  Application.CreateForm(Tf_gantisandi, f_gantisandi);
  Application.CreateForm(Tf_trans_parameter_nilai, f_trans_parameter_nilai);
  Application.CreateForm(Treport_penilaian_semua_2, report_penilaian_semua_2);
  Application.CreateForm(Treport_nilai2, report_nilai2);
  Application.CreateForm(Tf_lap_rangking, f_lap_rangking);
  Application.CreateForm(Treport_rangking, report_rangking);
  Application.CreateForm(Treport_penilaian_semua, report_penilaian_semua);
  Application.CreateForm(Treport_penilaian, report_penilaian);
  Application.CreateForm(Tf_lap_jawab, f_lap_jawab);
  Application.Run;
end.
