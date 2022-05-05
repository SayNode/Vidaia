import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/pages/home/custom_border_shape.dart';
import 'package:vidaia/utils/wallet.dart';

import '../../widgets/vidaia_drawer.dart';

class HomePageStack extends StatefulWidget {
  final List<Widget> list;

  HomePageStack(this.list);

  @override
  State<HomePageStack> createState() => _HomePageStackState();
}

class _HomePageStackState extends State<HomePageStack> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Stack(children: [
          AppBar(
            shape: CustomShapeBorder(),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: Container(
              //height: 80,
              //width: 80,
              margin: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  color: Colors.orange, shape: BoxShape.circle),
              child: Column(
                children: [
                  const Expanded(child: Icon(Icons.monetization_on_outlined)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('37 VID'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
      drawer: const VidaiaDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart), label: 'purchase'.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.local_offer_outlined),
              label: 'redeem'.tr()),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.list,
      ),
    );
  }
}
