import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/utils/wallet.dart';

import '../utils/popups.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Change Languge'),
            trailing: SizedBox(
              width: 100,
              child: DropdownButton(
                  hint: Text(
                    'currentLanguage'.tr(),
                  ),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'de',
                      child: Text(
                        'Deutsch',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'en',
                      child: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      context.setLocale(Locale(value!));
                    });
                  }),
            ),
          ),
          ListTile(
            title: Text('Import Wallet'),
            onTap: () {importWallet(context);},
          )
        ],
      ),
    );
  }
}
