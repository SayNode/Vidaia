import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/repositories/dataRepository.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vidaia/utils/globals.dart';

class RecievePage extends StatefulWidget {
  const RecievePage({Key? key}) : super(key: key);

  @override
  State<RecievePage> createState() => _RecievePageState();
}

class _RecievePageState extends State<RecievePage> {
  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Column(
          children: [
            Container(child: Text('Recieve')),
            QrImage(
              data: address!,
              size: 250,
            ),
            Text(address!),
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: address));
                },
                child: Text('Copy Address')),
          ],
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
