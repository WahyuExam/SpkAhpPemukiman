unit u_mast_sub_kriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  Tf_mast_sub_kriteria = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtkode: TEdit;
    edtnama: TEdit;
    grp3: TGroupBox;
    btncampur: TBitBtn;
    btnsimpan: TBitBtn;
    btnubah: TBitBtn;
    btnhapus: TBitBtn;
    btnkeluar: TBitBtn;
    grp4: TGroupBox;
    dbgrd1: TDBGrid;
    grp5: TGroupBox;
    lbl5: TLabel;
    edtpencarian: TEdit;
    edtnama_lama: TEdit;
    dblkcbbkriteria: TDBLookupComboBox;
    edtkriteria_lama: TEdit;
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
    procedure dblkcbbkriteriaCloseUp(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure konek;
  end;

var
  f_mast_sub_kriteria: Tf_mast_sub_kriteria;
  kode, status : string;

implementation

uses
  u_datamodule, StrUtils;

{$R *.dfm}

{ Tf_mast_sub_kriteria }

procedure Tf_mast_sub_kriteria.konek;
begin
 with dm.qry_tampil_sub_kriteria do
  begin
    Close;
    sql.Clear;
    SQL.Text:='select a.kd_sub_kriteria, b.kd_kriteria, b.nm_kriteria, a.nm_sub_kriteria, a.nl_sub from tbl_sub_kriteria a, tbl_kriteria b where a.kd_kriteria=b.kd_kriteria';
    Open;
  end;
end;

procedure Tf_mast_sub_kriteria.FormShow(Sender: TObject);
begin
 edtkode.Enabled:=false; edtkode.Clear;
 edtnama.Enabled:=false; edtnama.Clear;
 dblkcbbkriteria.Enabled:=false; dblkcbbkriteria.KeyValue:=Null;

 btncampur.Enabled:=True; btncampur.Caption:='Tambah';
 btnsimpan.Enabled:=false;
 btnubah.Enabled:=false;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=True;

 dbgrd1.Enabled:=True;

 edtpencarian.Clear; edtpencarian.Enabled:=True;
 konek;
end;

procedure Tf_mast_sub_kriteria.btncampurClick(Sender: TObject);
begin
 if btncampur.Caption='Tambah' then
  begin
    with dm.qry_sub_kriteria do
      begin
       Close;
       SQL.Clear;
       SQL.Text:='select * from tbl_sub_kriteria order by kd_sub_kriteria asc';
       Open;
       
       if IsEmpty then kode := '001' else
        begin
         Last;
         kode := RightStr(fieldbyname('kd_sub_kriteria').AsString,3);
         kode := IntToStr(StrToInt(kode)+1);
        end;
      end;
     edtkode.Text:='SKR-'+Format('%.3d',[StrToInt(kode)]);
 
     dblkcbbkriteria.Enabled:=True; dblkcbbkriteria.SetFocus;
     edtnama.Enabled:=True;

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

procedure Tf_mast_sub_kriteria.btnsimpanClick(Sender: TObject);
begin
 if Trim(edtnama.Text)='' then
  begin
    MessageDlg('Nama Subkriteria Belum Diisi',mtInformation,[mbOK],0);
    edtnama.Clear; edtnama.SetFocus;
    Exit;
  end;

 if dblkcbbkriteria.KeyValue=Null then
  begin
    MessageDlg('Nama Kriteria Belum Diisi',mtInformation,[mbOK],0);
    dblkcbbkriteria.SetFocus;
    Exit;
  end;

  with dm.qry_sub_kriteria do
   begin
     if status='tambah' then
      begin
        if Locate('kd_kriteria;nm_sub_kriteria',VarArrayOf([dblkcbbkriteria.KeyValue,edtnama.Text]),[]) then
          begin
            MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
            Exit;
          end
          else
          begin
            Append;
            FieldByName('kd_sub_kriteria').AsString := edtkode.Text;
            FieldByName('nl_sub').AsString:='0';
          end;
      end
      else
     if status='ubah' then
      begin
        if (edtnama.Text=edtnama_lama.Text) and (dblkcbbkriteria.KeyValue=edtkriteria_lama.Text) then
         begin
          if Locate('kd_sub_kriteria',edtkode.Text,[]) then Edit;
         end
         else
        if (edtnama.Text<>edtnama_lama.Text) or (dblkcbbkriteria.KeyValue<>edtkriteria_lama.Text) then
         begin
           if Locate('kd_kriteria;nm_sub_kriteria',VarArrayOf([dblkcbbkriteria.KeyValue,edtnama.Text]),[]) then
             begin
              MessageDlg('Data Sudah Ada',mtInformation,[mbok],0);
              Exit;
             end
           else
           begin
             if Locate('kd_sub_kriteria',edtkode.Text,[]) then Edit;
           end;
         end;
      end;

      FieldByName('kd_kriteria').AsString:=dblkcbbkriteria.KeyValue;
      FieldByName('nm_sub_kriteria').AsString:=edtnama.Text;
      Post;

      FormShow(Sender);
      MessageDlg('Data Sudah Disimpan',mtInformation,[mbok],0);
   end;
end;

procedure Tf_mast_sub_kriteria.btnubahClick(Sender: TObject);
begin
 status:='ubah';

 edtnama.Enabled:=True; edtnama.SetFocus;

 btncampur.Caption:='Batal';
 btnsimpan.Enabled:=True;
 btnubah.Enabled:=False;
 btnhapus.Enabled:=false;
 btnkeluar.Enabled:=False;

 dbgrd1.Enabled:=false;
 edtpencarian.Enabled:=false; edtpencarian.Clear;

end;

procedure Tf_mast_sub_kriteria.btnhapusClick(Sender: TObject);
begin
   with dm.qry_tmp_sub_kriteria do
   begin
     Close;
     SQL.Clear;
     SQL.Text:='delete from tbl_tmp_sub_kriteria where kd_sub_kriteria2='+QuotedStr(dbgrd1.Fields[0].AsString)+'';
     ExecSQL;
   end;

 with dm.qry_sub_kriteria do
  begin
    if MessageDlg('Apakah Data Akan Dihapus', mtConfirmation,[mbYes,mbNo],0)=mryes then
     begin
       Delete;
       FormShow(Sender);
       MessageDlg('Data Sudah Dihapus',mtInformation,[mbOK],0);
     end;
  end;

end;

procedure Tf_mast_sub_kriteria.btnkeluarClick(Sender: TObject);
begin
 close;
end;

procedure Tf_mast_sub_kriteria.dbgrd1DblClick(Sender: TObject);
begin
 edtkode.Text := dbgrd1.Fields[0].AsString;

 if edtkode.Text = '' then Exit else
  begin
    edtnama.Text := dbgrd1.Fields[2].AsString;
    edtnama_lama.Text := dbgrd1.Fields[2].AsString;

    dblkcbbkriteria.KeyValue := dbgrd1.Fields[3].AsString;
    edtkriteria_lama.Text := dbgrd1.Fields[3].AsString;

    btncampur.Caption:='Batal';
    btnsimpan.Enabled:=false;
    btnubah.Enabled:=True; btnhapus.Enabled:=True;
    btnkeluar.Enabled:=False;
  end;
end;

procedure Tf_mast_sub_kriteria.edtpencarianKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if edtpencarian.Text='' then konek else
  begin
    with dm.qry_tampil_sub_kriteria do
     begin
       close;
       sql.Clear;
       SQL.Add('select a.kd_sub_kriteria, b.kd_kriteria, b.nm_kriteria, a.nm_sub_kriteria, a.nl_sub from tbl_sub_kriteria a,');
       sql.Add('tbl_kriteria b where a.kd_kriteria=b.kd_kriteria and (b.nm_kriteria like ''%'+edtpencarian.Text+'%'' or a.nm_sub_kriteria like ''%'+edtpencarian.Text+'%'')');
       Open;
     end;
  end;

end;

procedure Tf_mast_sub_kriteria.dblkcbbkriteriaCloseUp(Sender: TObject);
begin
 if dblkcbbkriteria.KeyValue=Null then Exit else edtnama.SetFocus;
end;

end.
