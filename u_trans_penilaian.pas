unit u_trans_penilaian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, jpeg, ExtCtrls;

type
  Tf_trans_penilaian = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl14: TLabel;
    edttahun: TEdit;
    lbl2: TLabel;
    dblkcbbkawasan: TDBLookupComboBox;
    grp7: TGroupBox;
    btntambah: TBitBtn;
    btnsimpan: TBitBtn;
    btnbatal: TBitBtn;
    btnkeluar: TBitBtn;
    grp8: TGroupBox;
    dbgrd3: TDBGrid;
    grp6: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtsubkriteria: TEdit;
    edtnil: TEdit;
    btnsetnilai: TBitBtn;
    btnulang: TBitBtn;
    edtkriteria: TEdit;
    dbgrd1: TDBGrid;
    img1: TImage;
    dblkcbbparameter: TDBLookupComboBox;
    procedure btnkeluarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btntambahClick(Sender: TObject);
    procedure dblkcbbkawasanCloseUp(Sender: TObject);
    procedure btnbatalClick(Sender: TObject);
    procedure dbgrd3DblClick(Sender: TObject);
    procedure btnulangClick(Sender: TObject);
    procedure btnsetnilaiClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure edtnilKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure dblkcbbparameterCloseUp(Sender: TObject);
    procedure edttahunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure koenk_kirteria;
    procedure sort_kriteria;
  end;

var
  f_trans_penilaian: Tf_trans_penilaian;
  a : Integer;
  kd_penilaian,kode, kode_sub_kriteria, status : string;
  ttl : Real;

implementation

uses
  u_datamodule, DB, ADODB, StrUtils;

{$R *.dfm}
procedure Tf_trans_penilaian.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_trans_penilaian.FormShow(Sender: TObject);
begin
 edttahun.Text:=FormatDateTime('yyyy',Now);
 edttahun.Enabled:=True;
 dblkcbbkawasan.Enabled:=True; dblkcbbkawasan.SetFocus;
 dblkcbbkawasan.KeyValue:=Null;
 dblkcbbparameter.KeyValue:=Null; dblkcbbparameter.Enabled:=false;

 btntambah.Enabled:=false; btntambah.Caption:='Tambah';
 btnsimpan.Enabled:=false;
 btnsimpan.Caption:='Simpan';
 btnbatal.Enabled:=false;

 btnkeluar.Enabled:=True;

 dbgrd3.Enabled:=false;

 edtkriteria.Enabled:=False; edtkriteria.Clear;
 edtsubkriteria.Enabled:=false; edtsubkriteria.Clear;
 edtnil.Enabled:=false; edtnil.Clear;

 btnsetnilai.Enabled:=false;
 btnulang.Enabled:=false;

  with dm.qry_tampil_penilaian do
   begin
     Close;
     SQL.Clear;
     sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria,');
     sql.Add('c.nm_sub_kriteria, c.nl_sub, d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl from tbl_rangking a,');
     sql.Add('tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan and');
     sql.Add('e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
     sql.Add('and a.kd_penilaian='+QuotedStr('kosong')+' order by d.kd_kriteria asc');
     Open;
   end;

 with dm.qry_penilaian do
  begin
    Close;
    SQL.Clear;
    sql.Text:='select * from tbl_penilaian order by kd_penilaian asc';
    Open;
  end;

 with dm.qry_rangking do
  begin
    close;
    SQL.Clear;
    SQL.Text:='select * from tbl_rangking order by kd_penilaian asc';
    Open;
  end;

  with dm.qry_kriteria do
   begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_kriteria where kd_kriteria='+QuotedStr('kosong')+'';
     Open;
   end;

  with dm.qry_kawasan do
   begin
     close;
     sql.Clear;
     sql.Text:='select * from tbl_kawasan order by kd_kawasan asc';
     Open;
   end;
end;

procedure Tf_trans_penilaian.btntambahClick(Sender: TObject);
begin
 if btntambah.Caption='Tambah' then
  begin
    btntambah.Enabled:=false; btntambah.Caption:='Tambah';
    btnbatal.Enabled:=True;
    btnkeluar.Enabled:=false;
    btnsimpan.Enabled:=True;

    dbgrd1.Enabled:=True;
    dbgrd3.Enabled:=True;
    status:='simpan';

    edttahun.Enabled:=false;
    dblkcbbkawasan.Enabled:=False;

    with dm.qry_rangking do
     begin
      Close;
      SQL.Clear;
      sql.Text:='select * from tbl_rangking order by kd_penilaian asc';
      Open;

      if IsEmpty then kode := '001' else
       begin
        Last;
        kode := RightStr(fieldbyname('kd_penilaian').AsString,3);
        kode := IntToStr(StrToInt(kode)+1);
       end;
     end;

    kd_penilaian := 'NIL-'+Format('%.3d',[StrToInt(kode)]);
    //ShowMessage(kd_penilaian);

    with dm.qry_sub_kriteria do
     begin
      close;
      SQL.Clear;
      SQL.Text:='select * from tbl_sub_kriteria order by kd_sub_kriteria asc';
      Open;

      if IsEmpty then
        begin
          MessageDlg('Data Kosong',mtInformation,[mbOK],0);
          Exit;
        end
      else
      begin
       //simpan di rangking
       with dm.qry_rangking do
         begin
           Close;
           sql.Clear;
           SQL.Text := 'select * from tbl_rangking where kd_penilaian='+QuotedStr(kd_penilaian)+'';
           Open;

           if IsEmpty then Append else Edit;

           FieldByName('kd_penilaian').AsString := kd_penilaian;
           FieldByName('tahun').AsString := edttahun.Text;
           FieldByName('kd_kawasan').AsString := dblkcbbkawasan.KeyValue;
           FieldByName('ttl_nilai').AsString :='0';
           FieldByName('ket').AsString :='belum';
           Post;
         end;

         for a:=1 to RecordCount do
           begin
            RecNo := a;
            kode_sub_kriteria := fieldbyname('kd_sub_kriteria').AsString;

            with dm.qry_penilaian do
              begin
               close;
               SQL.Clear;
               SQL.Text:='select * from tbl_penilaian where kd_penilaian='+QuotedStr(kd_penilaian)+' and kd_sub_kriteria='+QuotedStr(kode_sub_kriteria)+'';
               Open;

               if IsEmpty then Append else Edit;

               FieldByName('kd_penilaian').AsString:=kd_penilaian;
               FieldByName('kd_sub_kriteria').AsString := kode_sub_kriteria;
               Post;
              end;
           end;
           a:=a+1;

           koenk_kirteria;
           edttahun.Enabled:=false;
           dblkcbbkawasan.Enabled:=false;
      end;
     end;
  end
  else
 if btntambah.Caption='Ubah' then
  begin
    dbgrd3.Enabled:=True;
    dbgrd1.Enabled:=True;
    btntambah.Enabled:=false;
    btnbatal.Enabled:=True;
    btnsimpan.Enabled:=True;
  end;

end;

procedure Tf_trans_penilaian.dblkcbbkawasanCloseUp(Sender: TObject);
begin
 if dblkcbbkawasan.KeyValue=Null then Exit;
 if edttahun.Text='' then
  begin
    MessageDlg('Tahun Wajib Diisi',mtWarning,[mbok],0);
    dblkcbbkawasan.KeyValue:=Null;
    edttahun.SetFocus;
    Exit;
  end;

 if (StrToInt(edttahun.Text) <1900) or (StrToInt(edttahun.Text)>3000) then
  begin
    MessageDlg('Tahun Yang Boleh Dimasukkan Antara Tahun 1900 - 3000',mtInformation,[mbok],0);
    dblkcbbkawasan.KeyValue:=Null;
    edttahun.SetFocus;
    Exit;
  end;

 with dm.qry_penilaian do
  begin
    if dm.qry_rangking.Locate('tahun;kd_kawasan',VarArrayOf([edttahun.Text,dblkcbbkawasan.KeyValue]),[]) then
     begin
       kd_penilaian := dm.qry_rangking.fieldbyname('kd_penilaian').AsString;
       //ShowMessage(kd_penilaian);
       MessageDlg('Kawasan Sudah Dinilai Tahun ini',mtInformation,[mbOK],0);
       status:='ubah';
       with dm.qry_tampil_penilaian do
        begin
          Close;
          SQL.Clear;
          sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria,');
          sql.Add('c.nm_sub_kriteria, c.nl_sub, d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl from tbl_rangking a,');
          sql.Add('tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan and');
          sql.Add('e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
          sql.Add('and a.kd_penilaian='+QuotedStr(kd_penilaian)+' order by d.kd_kriteria asc');
          Open;
        end;
       koenk_kirteria;
       btntambah.Caption:='Ubah'; btntambah.Enabled:=True;
       dbgrd3.Enabled:=false;
       dbgrd1.Enabled:=False;
     end
     else
     begin
      btntambah.Caption:='Tambah'; btntambah.Enabled:=True;

      with dm.qry_tampil_penilaian do
       begin
        Close;
        SQL.Clear;
        sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria,');
        sql.Add('c.nm_sub_kriteria, c.nl_sub, d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl from tbl_rangking a,');
        sql.Add('tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan and');
        sql.Add('e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
        sql.Add('and a.kd_penilaian='+QuotedStr('kosong')+' order by d.kd_kriteria asc');
        Open;
       end;

      with dm.qry_kriteria do
       begin
        close;
        SQL.Clear;
        SQL.Text:='select * from tbl_kriteria where kd_kriteria='+QuotedStr('kosong')+'';
        Open;
       end;
     end;
  end;
end;

procedure Tf_trans_penilaian.btnbatalClick(Sender: TObject);
begin
 with dm.qry_rangking do
  begin
    close;
    SQL.Clear;
    SQL.Text:='delete from tbl_rangking where kd_penilaian='+QuotedStr(kd_penilaian)+' and ket='+QuotedStr('belum')+'';
    ExecSQL;
  end;

  FormShow(Sender);
end;

procedure Tf_trans_penilaian.dbgrd3DblClick(Sender: TObject);
begin
 edtnil.Text:=dbgrd3.Fields[12].AsString;
 if edtnil.Text='' then
  begin
    //edtnil.Enabled:=True; edtnil.SetFocus;
    dblkcbbparameter.Enabled:=True; dblkcbbparameter.SetFocus;
    sort_kriteria;
  end
  else
  begin
    MessageDlg('Subkriteria Sudah Dinilai',mtInformation,[mbOK],0);
    if MessageDlg('Ingin Merubah Nilai ?',mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
       sort_kriteria;
       edtnil.Text:=dbgrd3.Fields[12].AsString;
      // edtnil.Enabled:=True; edtnil.SetFocus;
       dblkcbbparameter.KeyValue:=dbgrd3.Fields[14].AsString;
       dblkcbbparameter.Enabled:=True; dblkcbbparameter.SetFocus;
     end
     else
     begin
       edtnil.Text:='';
       dblkcbbparameter.KeyValue:=Null;
       Exit;
     end;
  end;

   edtkriteria.Text:=dbgrd3.Fields[8].AsString;
   edtsubkriteria.Text:=dbgrd3.Fields[5].AsString;

   btnsetnilai.Enabled:=True;
   btnulang.Enabled:=True;

   dbgrd3.Enabled:=false;
end;

procedure Tf_trans_penilaian.btnulangClick(Sender: TObject);
begin
 edtkriteria.Clear;
 edtsubkriteria.Clear;
 edtnil.Clear;
 dblkcbbparameter.KeyValue:=Null;
 dbgrd3.Enabled:=True;

 btnsetnilai.Enabled:=false;
 btnulang.Enabled:=false;
end;

procedure Tf_trans_penilaian.btnsetnilaiClick(Sender: TObject);
begin
 if edtnil.Text='' then
  begin
    MessageDlg('Nilai belum Diisi',mtInformation,[mbOK],0);
    Exit;
  end;

 with dm.qry_penilaian do
  begin
    close;
    sql.Clear;
    sql.Text:='select * from tbl_penilaian where kd_penilaian='+QuotedStr(dbgrd3.Fields[0].AsString)+' and kd_sub_kriteria='+QuotedStr(dbgrd3.Fields[4].AsString)+'';
    Open;

    if not IsEmpty then
     begin
       with dm.qry_sub_kriteria do
        begin
          close;
          SQL.Clear;
          SQL.Text:='select * from tbl_sub_kriteria where kd_sub_kriteria='+QuotedStr(dbgrd3.Fields[4].AsString)+'';
          Open;

          dm.qry_penilaian.Edit;
          dm.qry_penilaian.FieldByName('parameter_nil').AsString := dblkcbbparameter.Text;
          dm.qry_penilaian.FieldByName('nil_param').AsString := edtnil.Text;
          dm.qry_penilaian.FieldByName('kd_parameter').AsString := dblkcbbparameter.KeyValue;
          dm.qry_penilaian.FieldByName('ttl').AsVariant := fieldbyname('nl_sub').AsVariant * StrToFloat(edtnil.Text);
          dm.qry_penilaian.Post;
        end;

   with dm.qry_tampil_penilaian do
   begin
     Close;
     SQL.Clear;
     sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria,');
     sql.Add('c.nm_sub_kriteria, c.nl_sub, d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl from tbl_rangking a,');
     sql.Add('tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan and');
     sql.Add('e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
     sql.Add('and a.kd_penilaian='+QuotedStr(kd_penilaian)+' and d.kd_kriteria='+QuotedStr(dbgrd1.Fields[0].AsString)+' order by d.kd_kriteria asc, c.kd_sub_kriteria asc');
     Open;

      for a:=1 to RecordCount do
      begin
        RecNo := a;
        if FieldByName('nil_param').AsString='' then dbgrd1.Enabled:=False else dbgrd1.Enabled:=True;
      end;
      a:=a+1;
   end;
        btnulang.Click;
        //koenk_kirteria;

        if status='simpan' then
         begin
           btnsimpan.Caption:='Simpan';
           btnbatal.Enabled:=True;
         end
         else
        begin
          btnsimpan.Caption:='Selesai';
          btnbatal.Enabled:=false;
        end;
     end;
  end;
end;

procedure Tf_trans_penilaian.btnsimpanClick(Sender: TObject);
begin
 if btnsimpan.Caption='Simpan' then
  begin
     with dm.qry_penilaian do
      begin
       close;
       SQL.Clear;
       sql.Text:='select * from tbl_penilaian where kd_penilaian='+QuotedStr(kd_penilaian)+'';
       Open;

       for a:=1 to RecordCount do
        begin
          RecNo:=a;

          if FieldByName('nil_param').Text='' then
           begin
            MessageDlg('Semua Nilai Pada Subkriteria Wajib Diisi',mtInformation,[mbok],0);
            Exit;
           end;
        end;
        a:=a+1;
      end;

      with dm.qry_rangking do
       begin
         close;
         SQL.Clear;
         sql.Text:='select * from tbl_rangking where kd_penilaian='+QuotedStr(kd_penilaian)+'';
         Open;

         Edit;
         FieldByName('ket').AsString := 'Sudah';
         Post;
       end;

      FormShow(Sender);
      MessageDlg('Data Sudah Disimpan',mtInformation,[mbOK],0);
  end
  else
 if btnsimpan.Caption='Selesai' then
  begin
    with dm.qry_penilaian do
      begin
       close;
       SQL.Clear;
       sql.Text:='select * from tbl_penilaian where kd_penilaian='+QuotedStr(kd_penilaian)+'';
       Open;

       for a:=1 to RecordCount do
        begin
          RecNo:=a;

          if FieldByName('nil_param').Text='' then
          begin
            MessageDlg('Semua Nilai Pada Subkriteria Wajib Diisi',mtInformation,[mbok],0);
            Exit;
          end;
        end;
        a:=a+1;
      end;

      FormShow(Sender);
      MessageDlg('Data Sudah Diubah',mtInformation,[mbOK],0);
  end;
end;

procedure Tf_trans_penilaian.edtnilKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in ['0'..'9',#13,#8,#9]) then Key:=#0;
end;

procedure Tf_trans_penilaian.dbgrd1CellClick(Column: TColumn);
begin
   with dm.qry_tampil_penilaian do
   begin
     Close;
     SQL.Clear;
     sql.Add('select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd_sub_kriteria,');
     sql.Add('c.nm_sub_kriteria, c.nl_sub, d.kd_kriteria, d.nm_kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_parameter, e.ttl from tbl_rangking a,');
     sql.Add('tbl_kawasan b, tbl_sub_kriteria c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_kawasan and');
     sql.Add('e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=d.kd_kriteria and e.kd_penilaian=a.kd_penilaian');
     sql.Add('and a.kd_penilaian='+QuotedStr(kd_penilaian)+' and d.kd_kriteria='+QuotedStr(dbgrd1.Fields[0].AsString)+' order by d.kd_kriteria asc, c.kd_sub_kriteria asc');
     Open;

     for a:=1 to RecordCount do
      begin
        RecNo := a;
        if FieldByName('nil_param').AsString='' then dbgrd1.Enabled:=False else dbgrd1.Enabled:=True;
      end;
      a:=a+1;
   end;

end;

procedure Tf_trans_penilaian.koenk_kirteria;
begin
   with dm.qry_kriteria do
   begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
     Open;
   end;
end;

procedure Tf_trans_penilaian.dblkcbbparameterCloseUp(Sender: TObject);
begin
 if dblkcbbparameter.KeyValue=Null then Exit else
  begin
    if dm.qry_parameter_nil.Locate('kd_parameter',dblkcbbparameter.KeyValue,[]) then edtnil.Text:=dm.qry_parameter_nil.fieldbyname('nil_param').AsString;
  end;
end;

procedure Tf_trans_penilaian.sort_kriteria;
begin
with dm.qry_parameter_nil do
 begin
  Close;
  SQL.Clear;
  SQL.Text:='select * from tbl_nil_sub_kriteria where kd_sub_kriteria='+QuotedStr(dbgrd3.Fields[4].AsString)+'';
  Open;
 end;
end;

procedure Tf_trans_penilaian.edttahunClick(Sender: TObject);
begin
 dblkcbbkawasan.KeyValue:=Null;
end;

end.
