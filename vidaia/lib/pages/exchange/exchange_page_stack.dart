import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/utils/constants.dart';
import 'package:vidaia/utils/wallet.dart';

import '../../widgets/vidaia_drawer.dart';

class ExchangePageStack extends StatefulWidget {
  final List<Widget> list;

  ExchangePageStack(this.list);

  @override
  State<ExchangePageStack> createState() => _ExchangePageStackState();
}

class _ExchangePageStackState extends State<ExchangePageStack> {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: BACKGROUND,
        toolbarHeight: 90,
        title: Stack(alignment: AlignmentDirectional.centerEnd, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  child: Image(
                    image: AssetImage("assets/images/vidar.png"),
                    height: 25,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 5,
                  ),
                  child: Text(
                    'VID',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
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

                      return Text(balance,
                          style: TextStyle(color: PRIMARY_DARK, fontSize: 16));
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
          BottomNavigationBarItem(
            icon: Container(),
            label: 'Send',
          ),
          BottomNavigationBarItem(
            icon: Container(), 
            label: 'Recieve'.tr()
            ),
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
