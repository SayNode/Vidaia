import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/utils/constants.dart';

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

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND,
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: const VidaiaDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: BACKGROUND,
        toolbarHeight: 90,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: Center(child: Icon(Icons.menu, color: PRIMARY)),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
          Text("Vidaia", style: TextStyle(color: PRIMARY_DARK)),
          IconButton(
            icon: Center(child: Icon(Icons.currency_exchange_outlined, color: PRIMARY)),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
          ),
        ]),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY,
        unselectedItemColor: SECONDARY,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 22),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart_outlined, size: 22), label: 'purchase'.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.local_offer_outlined, size: 22), label: 'redeem'.tr()),
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
