import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/home/history/buy_history_page.dart';
import 'package:vidaia/pages/home/home/home_page.dart';
import 'package:vidaia/pages/home/redeem/redeem_page.dart';
import 'package:vidaia/repositories/dataRepository.dart';

import 'home_page_stack.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  late Future<bool> isDataLoaded;

  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  void initState() {
    super.initState();
    isDataLoaded = dataRepository.init();
  }

  final _pages = [HomePage(), BuyHistoryPage(), RedeemPage()];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isDataLoaded,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data == true) {
            return HomePageStack(_pages);
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Loading data",
                    style: TextStyle(color: Colors.black38, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          }
        });
  }
}
