import 'package:flutter/material.dart';
import 'package:vidaia/widgets/vidaia_drawer.dart';
import 'package:vidaia/widgets/vidaia_navbar.dart';

class VidaiScaffold extends StatelessWidget {
  final Widget body;

  const VidaiScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(),
      body: body,
      drawer: const VidaiaDrawer(),
      bottomNavigationBar: const VidaiaNavBar(),
    );
  }
}
