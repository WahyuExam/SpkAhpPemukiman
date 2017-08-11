unit u_report_rangking;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  Treport_rangking = class(TQuickRep)
    DetailBand1: TQRBand;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRBand1: TQRBand;
    QRShape10: TQRShape;
    QRImage2: TQRImage;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl1: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    SummaryBand1: TQRBand;
    qrlbl3: TQRLabel;
    qrlbl2: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    QRShape4: TQRShape;
    qrlbl12: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
  private

  public

  end;

var
  report_rangking: Treport_rangking;

implementation

uses
  u_datamodule;

{$R *.DFM}

end.
