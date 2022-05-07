import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/utils/constants.dart';
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

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND,
      key: scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: VidaiaDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: BACKGROUND,
        toolbarHeight: 90,
        title: Stack(alignment: AlignmentDirectional.centerEnd, children: [
          const Center(child: Text("Vidaia", style: TextStyle(color: PRIMARY_DARK))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              icon: const Center(child: Icon(Icons.menu, color: PRIMARY)),
              onPressed: () => scaffoldKey.currentState?.openDrawer(),
            ),
            StreamBuilder<BigInt>(
              //initialData: 0.0,
              stream: checkBalance(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: PRIMARY_LIGHT,
                        ));
                  default:
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      final balance = snapshot.data.toString();

                      return Text(balance, style: TextStyle(color: PRIMARY_DARK, fontSize: 15));
                    }
                }
              },
            ),
          ]),
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
