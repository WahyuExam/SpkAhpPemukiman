unit u_report_seluruh;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses, DB, ADODB;

type
  Treport_penilaian_semua = class(TQuickRep)
    QRGroup1: TQRGroup;
    QRShape1: TQRShape;
    qrlbl11: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    QRDBText1: TQRDBText;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    DetailBand1: TQRBand;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    PageFooterBand1: TQRBand;
    QRShape9: TQRShape;
    QRBand1: TQRBand;
    QRShape10: TQRShape;
    QRImage2: TQRImage;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qry1: TADOQuery;
    wdstrngfldqry1kd_penilaian: TWideStringField;
    wdstrngfldqry1tahun: TWideStringField;
    wdstrngfldqry1kd_kawasan: TWideStringField;
    wdstrngfldqry1nm_kawasan: TWideStringField;
    wdstrngfldqry1kd_sub_kriteria: TWideStringField;
    wdstrngfldqry1nm_sub_kriteria: TWideStringField;
    qry1nl_sub: TFloatField;
    wdstrngfldqry1kd_kriteria: TWideStringField;
    wdstrngfldqry1nm_kriteria: TWideStringField;
    qry1nl_prioritas: TFloatField;
    wdstrngfldqry1parameter_nil: TWideStringField;
    wdstrngfldqry1nil_param: TWideStringField;
    wdstrngfldqry1kd_parameter: TWideStringField;
    qry1ttl: TFloatField;
    qry1ttl_nilai: TFloatField;
    wdstrngfldqry1ket: TWideStringField;
    QRLabel1: TQRLabel;
    SummaryBand1: TQRBand;
    QRShape4: TQRShape;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
  private

  public

  end;

var
  report_penilaian_semua: Treport_penilaian_semua;

implementation

uses
  u_datamodule;

{$R *.DFM}

end.
