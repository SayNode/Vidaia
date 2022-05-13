import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/exchange/scan_page.dart';
import 'package:vidaia/repositories/dataRepository.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vidaia/utils/globals.dart' as global;
import 'package:vidaia/utils/invalid_Address_Exception.dart';
import 'package:vidaia/utils/popups.dart';
import 'package:vidaia/utils/wallet.dart';

import '../../../utils/constants.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final addressController = TextEditingController();
  final valueController = TextEditingController();

  updateAddress(String address) {
    setState(() => addressController.text = address);
  }

  moveToSecondPage() async {
    final address = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScanPage()),
    );
    updateAddress(address);
  }

  @override
  void dispose() {
    valueController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            leading: const Icon(
              Icons.qr_code,
              color: PRIMARY_LIGHT,
            ),
            title: Text(
              'Scan QRCode'.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onTap: () {
              moveToSecondPage();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Receiver's Address",
            ),
            controller: addressController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Amount',
            ),
            controller: valueController,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              addressController.text =
                  '0x00bab3d8de4ebbefb07d53b1ff8c0f2434bd616d';
            },
            child: Text('set address')),
        ElevatedButton(
            onPressed: () async {
              onLoading(context);
              var res;
              try {
                res = await transferVidar(int.parse(valueController.text),
                    addressController.text, 'https://testnet.veblocks.net');
              } on InvalidAddressException {
                Navigator.pop(context);
                oneButtonPopup(context, Text('Transaction Failed'),
                    Text('The Address is not valid'));
              } finally {
                if (res.containsKey('id')) {
                  Navigator.pop(context);
                  txConfirmedAlert(context, res['id']);
                } else {
                  txError(context);
                }
              }
            },
            child: Text('Send')),
      ],
    );
  }
}
