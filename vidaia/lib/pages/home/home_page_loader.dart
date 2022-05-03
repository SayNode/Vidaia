import 'package:flutter/material.dart';
import 'package:vidaia/pages/home/history/buy_history_page.dart';
import 'package:vidaia/pages/home/home/home_page.dart';
import 'package:vidaia/pages/home/redeem/redeem_page.dart';

import 'home_page_stack.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  void initState() {
    super.initState();
  }

  final _pages = [
    HomePage(),
    RedeemPage(),
    BuyHistoryPage()
    ];

  @override
  Widget build(BuildContext context) {
    return HomePageStack(_pages);
  }
}
