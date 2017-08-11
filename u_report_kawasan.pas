unit u_report_kawasan;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  Treport_kawasan = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    TitleBand1: TQRBand;
    qrlbl1: TQRLabel;
    QRShape1: TQRShape;
    qrlbl2: TQRLabel;
    QRShape2: TQRShape;
    qrlbl3: TQRLabel;
    QRShape3: TQRShape;
    qrlbl4: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRShape8: TQRShape;
    QRImage1: TQRImage;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
  private

  public

  end;

var
  report_kawasan: Treport_kawasan;

implementation

uses
  u_datamodule;

{$R *.DFM}

end.
