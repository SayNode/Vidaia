import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
        allowDuplicates: false,
        controller: MobileScannerController(
          facing: CameraFacing.back,
          torchEnabled: false,
          formats: [BarcodeFormat.qrCode],
        ),
        onDetect: (barcode, args) {
          final String code = barcode.rawValue!;
          debugPrint('Barcode found! $code');
          Navigator.pop(context, code);
        });
  }
}
