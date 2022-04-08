import 'package:flutter/material.dart';
import 'package:vidaia/widgets/vidaia_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VidaiScaffold(
        body: Column(
      children: const [Text('Settings')],
    ));
  }
}
