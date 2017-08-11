unit u_trans_rangking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, jpeg, ExtCtrls;

type
  Tf_trans_rangking = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl14: TLabel;
    edttahun: TEdit;
    grp3: TGroupBox;
    dbgrd1: TDBGrid;
    btnkeluar: TBitBtn;
    btnbersih: TBitBtn;
    btnproses: TBitBtn;
    img1: TImage;
    procedure btnkeluarClick(Sender: TObject);
    procedure btnprosesClick(Sender: TObject);
    procedure edttahunKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnbersihClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_trans_rangking: Tf_trans_rangking;
  a, b, c : Integer;
  kd_penilaian, kd_kriteria, ket : string;
  ttl_hasil, hasil, hasil_akhir : Real;

implementation

uses
  u_datamodule, DB;

{$R *.dfm}

procedure Tf_trans_rangking.btnkeluarClick(Sender: TObject);
begin
 Close;
end;

procedure Tf_trans_rangking.btnprosesClick(Sender: TObject);
begin
 if edttahun.Text='' then
  begin
    MessageDlg('Tahun Belum Diisi',mtWarning,[mbok],0);
    edttahun.SetFocus;
    Exit;
  end;

 if (StrToInt(edttahun.Text) < 1900) or (StrToInt(edttahun.Text) > 3000) then
  begin
    MessageDlg('Tahun yang Boleh Dimasukkan antara 1900 smapai 3000',mtInformation,[mbOK],0);
    edttahun.SetFocus;
    Exit;
  end;

  //rangking
  with dm.qry_rangking do
   begin
     Close;
     SQL.Clear;
     SQL.Text:='select * from tbl_rangking where tahun='+QuotedStr(edttahun.Text)+'';
     Open;

     if IsEmpty then
      begin
        MessageDlg('Data Belum Ada',mtInformation,[mbOK],0);
        FormShow(Sender);
        Exit;
      end
      else
     begin
      for a:=1 to RecordCount do
       begin
         RecNo:=a;
         kd_penilaian := fieldbyname('kd_penilaian').AsString;

         with dm.qry_kriteria do
          begin
            Close;
            SQL.Clear;
            SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
            Open;

            hasil_akhir :=0;
            for b := 1 to RecordCount do
             begin
               RecNo:=b;
               kd_kriteria := fieldbyname('kd_kriteria').AsString;

               with dm.qry_tampil_penilaian do
                begin
                  close;
                  SQL.Clear;
                  sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria, c.nm_sub_kriteria,');
                  sql.add('c.nl_sub, d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter,');
                  SQL.Add('e.ttl from tbl_rangking a, tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan');
                  SQL.Add('and e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
                  sql.Add('and a.kd_penilaian='+QuotedStr(kd_penilaian)+' and d.kd_kriteria='+QuotedStr(kd_kriteria)+'');
                  Open;

                  ttl_hasil :=0;
                  for c:=1 to RecordCount do
                   begin
                     RecNo := c;
                     ttl_hasil := ttl_hasil + fieldbyname('ttl').AsVariant;
                   end;
                   c:=c+1;

                   hasil := ttl_hasil * dm.qry_kriteria.fieldbyname('nl_prioritas').AsVariant;
                end;
                hasil_akhir := hasil_akhir + hasil;
             end;
             b:=b+1;
          end;

         if hasil_akhir >= 4 then ket:='Sangat Penting' else
         if (hasil_akhir >=3) and (hasil_akhir <= 3.99) then ket:='Penting' else
         if (hasil_akhir >=2) and (hasil_akhir <= 2.99) then ket:='Sedang' else
         if hasil_akhir <2 then ket :='Kurang Penting';

         Edit;
         FieldByName('ttl_nilai').AsString := FloatToStrF(hasil_akhir,ffFixed,4,3);
         FieldByName('ket').AsString := ket;
         Post;
       end;
       a:=a+1;
     end;
   end;

 MessageDlg('Proses selesai',mtInformation,[mbok],0);
 //refresh data
 with dm.qry_tampil_rangking do
  begin
    close;
    SQL.Clear;
    SQL.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, b.almt_kawasan, a.ttl_nilai, a.ket from tbl_rangking a,');
    SQL.Add('tbl_kawasan b where a.kd_kawasan=b.kd_kawasan and a.tahun='+QuotedStr(edttahun.Text)+' order by a.ttl_nilai desc');
    Open;
  end;

  btnproses.Enabled:=false;
  btnbersih.Enabled:=True;
end;

procedure Tf_trans_rangking.edttahunKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Not (key in ['0'..'9',#13,#9,#8]) then Key:=#0;
end;

procedure Tf_trans_rangking.FormShow(Sender: TObject);
begin
 edttahun.Enabled:=True;
 edttahun.Clear;
 edttahun.Text:=FormatDateTime('yyyy',Now);

 btnproses.Enabled:=True;
 btnbersih.Enabled:=false;
 btnkeluar.Enabled:=True;

 with dm.qry_tampil_rangking do
  begin
    close;
    SQL.Clear;
    SQL.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, b.almt_kawasan, a.ttl_nilai, a.ket from tbl_rangking a,');
    SQL.Add('tbl_kawasan b where a.kd_kawasan=b.kd_kawasan and a.kd_penilaian='+QuotedStr('kosong')+'');
    Open;
  end;
end;

procedure Tf_trans_rangking.btnbersihClick(Sender: TObject);
begin
 FormShow(Sender);
end;

end.
