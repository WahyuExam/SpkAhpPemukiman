unit u_lihat_hitung_kriteria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, jpeg, ExtCtrls;

type
  Tf_lihat_hitung_kriteria = class(TForm)
    grp6: TGroupBox;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    btn2: TButton;
    grp1: TGroupBox;
    StringGrid1: TStringGrid;
    grp2: TGroupBox;
    StringGrid2: TStringGrid;
    grp3: TGroupBox;
    StringGrid3: TStringGrid;
    grp4: TGroupBox;
    StringGrid4: TStringGrid;
    btn1: TBitBtn;
    lbl1: TLabel;
    img1: TImage;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_lihat_hitung_kriteria: Tf_lihat_hitung_kriteria;
  a, b, c, jml_data : Integer;
  status, kode_kriteria1, kriteria1, kriteria2, kode_kriteria2, kode_kriteria_akhir : string;
  hasil_bagi, hasil_jumlah, hasil_kali1, jml_hasil_kali1, totatl_hasil_kali, prioritas, jml_prioritas,
  prioritas_maksimum, konsistensi, rasio_konsistensi, hasil_kali_dgn_prioritas, jml_hasil_kali_dgn_prioritas, jml_hasil_grid4,
  hasil_grid4 : Real;

implementation

uses u_datamodule;

{$R *.dfm}

procedure Tf_lihat_hitung_kriteria.btn2Click(Sender: TObject);
var kode_kriteria : string;
begin
  with dm.qry_kriteria do
   begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
     Open;

     for a:=1 to RecordCount do
      begin
        RecNo:=a;

        with StringGrid1 do
         begin
           RowCount := RecordCount+2;
           ColCount := RecordCount+1;

           Cells[0,0+a] := fieldbyname('kd_kriteria').AsString;
           Cells[0+a,0] := fieldbyname('kd_kriteria').AsString;
           Cells[a,a] := '1';
         end;

        with StringGrid2 do
         begin
           RowCount := RecordCount+2;
           ColCount := RecordCount+3;

           Cells[0,0+a] := fieldbyname('kd_kriteria').AsString;
           Cells[0+a,0] := fieldbyname('kd_kriteria').AsString;
         end;

        with StringGrid3 do
         begin
           RowCount := RecordCount+1;
           ColCount := RecordCount+2;

           Cells[0,0+a] := fieldbyname('kd_kriteria').AsString;
           Cells[0+a,0] := fieldbyname('kd_kriteria').AsString;
         end;

        with StringGrid4 do
         begin
           RowCount := RecordCount+2;
           ColCount := 4;

           Cells[0,0+a] := fieldbyname('kd_kriteria').AsString;
         end;
      end;
      a:=a+1;
      StringGrid1.Cells[0,recordcount+1] := 'Jumlah';

      StringGrid2.Cells[recordcount+1,0] := 'Jumlah';
      StringGrid2.Cells[recordcount+2,0] := 'Prioritas';

      StringGrid3.Cells[recordcount+1,0] := 'Jumlah';

      StringGrid4.Cells[0,0] := 'Kriteria';
      StringGrid4.Cells[1,0] := 'Jml Perbaris';
      StringGrid4.Cells[2,0] := 'Prioritas';
      StringGrid4.Cells[3,0] := 'Hasil';
      StringGrid4.Cells[0,recordcount+1] := 'Jumlah';
   end;

  //ambil nilai
  with dm.qry_kriteria do
   begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
     Open;

     for a:=1 to RecordCount do
      begin
        RecNo := a;
        kode_kriteria := fieldbyname('kd_kriteria').AsString;

        with dm.qry_tmp_kriteria do
         begin
           close;
           SQL.Clear;
           sql.Text:='select * from tbl_tmp_kriteria where kd_kriteria1='+QuotedStr(kode_kriteria)+'';
           Open;

           for b:=1 to RecordCount do
            begin
              RecNo:=b;
              kriteria1 := fieldbyname('kd_kriteria1').AsString;
              kriteria2 := fieldbyname('kd_kriteria2').AsString;
              hasil_bagi := 1/fieldbyname('nil').AsVariant;

              with dm.qry_tmp_kriteria do
                begin
                 if Locate('kd_kriteria1;kd_kriteria2;nil',VarArrayOf([kriteria1,kriteria2,fieldbyname('nil').AsString]),[]) then
                  begin
                    Edit;
                    FieldByName('nil_banding').AsString := FloatToStrF(hasil_bagi,ffFixed,4,3);
                    Post;
                  end
                end;

              with StringGrid1 do
               begin
                 Cells[b+a,a] := fieldbyname('nil').AsString;
                 Cells[a,a+b] := fieldbyname('nil_banding').AsString;
               end;
            end;
            b:=b+1;
         end;
      end;
      a:=a+1;
   end;

   //jumlah baris
   with StringGrid1 do
    begin
     for a:=1 to ColCount - 1 do
      begin
        hasil_jumlah:=0;
        for b:=1 to RowCount - 2 do
         begin
           hasil_jumlah := hasil_jumlah + StrToFloat(Cells[a,b])
         end;
         b:=b+1;

         Cells[0+a,ColCount]:=FloatToStrF(hasil_jumlah,ffFixed,4,3);

         for c:=1 to RowCount - 2 do
          begin
            hasil_kali1 := StrToFloat(Cells[a,c]) / StrToFloat(Cells[0+a,colcount]);
            StringGrid2.Cells[a,c] := FloatToStrF(hasil_kali1,ffFixed,4,3);
          end;
          c:=c+1;
      end;
      a:=a+1;
    end;

    //jmlah dan prioritas
    with StringGrid2 do
     begin
      for a:=1 to ColCount - 3 do
       begin
         jml_hasil_kali1 :=0;
         for b:=1 to RowCount - 2 do
          begin
           jml_hasil_kali1 := jml_hasil_kali1 + StrToFloat(Cells[b,a]);
          end;
          b:=b+1;

          Cells[ColCount-2,a] := FloatToStrF(jml_hasil_kali1,ffFixed,4,3);
       end;
       a:=a+1;
     end;

     //jml bawah
    with StringGrid2 do
     begin
       totatl_hasil_kali:=0;
       for a:=1 to RowCount - 2 do
        begin
          totatl_hasil_kali := totatl_hasil_kali + StrToFloat(Cells[colcount-2,a]);
        end;
        a:=a+1;

       Cells[ColCount-2,RowCount-1] :=  FloatToStrF(totatl_hasil_kali,ffFixed,1,0);

       for a:=1 to RowCount - 2 do
        begin
          prioritas := StrToFloat(Cells[colcount-2,a]) / StrToFloat(Cells[colcount-2,rowcount-1]);
          Cells[ColCount-1,a] := FloatToStrF(prioritas,ffFixed,4,3);
        end;
        a:=a+1;

       jml_prioritas:=0;
       for a:=1 to RowCount - 2 do
        begin
         jml_prioritas := jml_prioritas + StrToFloat(Cells[colcount-1,a]);
        end;
        a:=a+1;
       Cells[ColCount-1,RowCount-1] :=  FloatToStrF(jml_prioritas,ffFixed,1,0);
     end;

     //matrik penjumlahan setiap baris
     with StringGrid1 do
      begin
        for a:=1 to ColCount-1 do
         begin
           for b:=1 to RowCount-2 do
            begin
              hasil_kali_dgn_prioritas := StrToFloat(Cells[a,b]) * StrToFloat(StringGrid2.Cells[colcount+1,b]);
              StringGrid3.Cells[a,b]:= FloatToStrF(hasil_kali_dgn_prioritas,ffFixed,4,3);
            end;
            b:=b+1;
         end;
         a:=a+1;
      end;

    with StringGrid3 do
     begin
      for a:=1 to ColCount - 2 do
       begin
         jml_hasil_kali_dgn_prioritas :=0;
         for b:=1 to RowCount - 1 do
          begin
           jml_hasil_kali_dgn_prioritas := jml_hasil_kali_dgn_prioritas + StrToFloat(Cells[b,a]);
          end;
          b:=b+1;

          Cells[ColCount-1,a] := FloatToStrF(jml_hasil_kali_dgn_prioritas,ffFixed,4,3);
       end;
       a:=a+1;
     end;

     //nilai kosnsistensi
     for a:=1 to StringGrid3.RowCount-1 do
      begin
        StringGrid4.Cells[1,a] := StringGrid3.Cells[StringGrid3.ColCount-1,a];
      end;
      a:=a+1;

     for a:=1 to StringGrid2.RowCount-2 do
      begin
        StringGrid4.Cells[2,a] := StringGrid2.Cells[StringGrid2.ColCount-1,a];
      end;

     with StringGrid4 do
      begin
        hasil_grid4 :=0;
        for a:=1 to RowCount - 2 do
         begin
           jml_hasil_grid4 := StrToFloat(Cells[1,a]) + StrToFloat(Cells[2,a]);
           Cells[3,a] := FloatToStrF(jml_hasil_grid4,ffFixed,4,3);
           hasil_grid4 := hasil_grid4 + StrToFloat(Cells[3,a]);
         end;
         a:=a+1;
         Cells[3, RowCount-1] := FloatToStrF(hasil_grid4,ffFixed,4,3);

         //prioritas maksimum
         prioritas_maksimum := StrToFloat(Cells[3,rowcount-1]) / (StringGrid1.colcount-1);
         lbl8.Caption:=FloatToStrF(prioritas_maksimum,ffFixed,4,3);
      end;

      //ci
      lbl9.Caption := FloatToStrF((StrToFloat(lbl8.Caption)- (StringGrid1.ColCount-1)) / ((StringGrid1.ColCount-1)-1),ffFixed,4,3);

      //cr
      if dm.qry_indek.Locate('matrik',IntToStr(StringGrid1.ColCount-1),[]) then
       begin
         rasio_konsistensi := StrToFloat(lbl9.Caption) / dm.qry_indek.fieldbyname('nilai_ir').AsVariant;
         lbl10.Caption:=FloatToStrF(rasio_konsistensi,ffFixed,4,3);
         if StrToFloat(lbl10.Caption) < 0.1 then lbl11.Caption:='Konsisten' else lbl11.Caption:='Tidak Konsisten';
         if lbl11.Caption='Konsisten' then
          begin
            with StringGrid2 do
             begin
               for a:=1 to RowCount-2 do
                begin
                  with dm.qry_kriteria do
                   begin
                     Close;
                     SQL.Clear;
                     SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
                     Open;

                     RecNo:=a;
                     Edit;
                     FieldByName('nl_prioritas').AsString := StringGrid2.Cells[colcount-1,a];
                     Post
                   end;
                end;
                a:=a+1;
             end;
          end;
       end;

   with dm.qry_kriteria_tampil do
    begin
      close;
      SQL.Clear;
      SQL.Text:='select * from tbl_kriteria order by kd_kriteria asc';
      Open;
    end;

  with dm.qry_tmp_kriteria do
   begin
     close;
     SQL.Clear;
     SQL.Text:='select * from tbl_tmp_kriteria order by kd_kriteria1 asc, kd_kriteria2 asc';
     Open;
   end;

end;

procedure Tf_lihat_hitung_kriteria.btn1Click(Sender: TObject);
begin
 Close;
end;

end.
