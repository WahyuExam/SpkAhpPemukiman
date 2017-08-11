unit report_nilai_2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB, dxGDIPlusClasses;

type
  Treport_nilai2 = class(TQuickRep)
    QRGroup1: TQRGroup;
    QRShape1: TQRShape;
    qrlbl11: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape5: TQRShape;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    QRDBText1: TQRDBText;
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
    qrlbl3: TQRLabel;
    qry1: TADOQuery;
    SummaryBand1: TQRBand;
    QRShape4: TQRShape;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl4: TQRLabel;
  private

  public

  end;

var
  report_nilai2: Treport_nilai2;

implementation

{$R *.DFM}

end.
