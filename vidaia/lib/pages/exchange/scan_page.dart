import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vidaia/utils/globals.dart' as global;

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
            facing: CameraFacing.back, torchEnabled: false),
          onDetect: (barcode, args) {
            final String code = barcode.rawValue!;
            global.qrCode = code;
            debugPrint('Barcode found! $code');
            Navigator.pop(context);
          });
  }
}
