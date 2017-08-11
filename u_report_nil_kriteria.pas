unit u_report_nil_kriteria;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  Treport_kriteria = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    QRShape1: TQRShape;
    qrlbl2: TQRLabel;
    QRShape2: TQRShape;
    qrlbl3: TQRLabel;
    QRShape3: TQRShape;
    qrlbl4: TQRLabel;
    DetailBand1: TQRBand;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    SummaryBand1: TQRBand;
    QRShape8: TQRShape;
    QRBand1: TQRBand;
    QRShape9: TQRShape;
    QRImage2: TQRImage;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
  private

  public

  end;

var
  report_kriteria: Treport_kriteria;

implementation

uses
  u_datamodule;

{$R *.DFM}

end.
