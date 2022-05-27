import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/home/history/buy_history_page.dart';
import 'package:vidaia/pages/home/home/home_page.dart';
import 'package:vidaia/pages/home/redeem/redeem_page.dart';
import 'package:vidaia/pages/login_page.dart';
import 'package:vidaia/repositories/dataRepository.dart';
import 'package:vidaia/services/auth_service.dart';

import 'home_page_stack.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  late Future<bool> isDataLoaded;
  late Future<bool> isUserLogged;

  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  void initState() {
    super.initState();
    // isUserLogged = AuthService.instance.init();
    isDataLoaded = dataRepository.init();
  }

  final _pages = [HomePage(), BuyHistoryPage(), RedeemPage()];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<bool>>(
        future: Future.wait([
          // isUserLogged, //Future that returns bool
          isDataLoaded, //Future that returns bool
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshot) {
          bool autoLogin = snapshot.connectionState == ConnectionState.done && AuthService.instance.isLoggedIn && snapshot.data?[0] == true;
          debugPrint('autologin ' + autoLogin.toString() + ' ' + (snapshot.connectionState == ConnectionState.done).toString() + ' ' + AuthService.instance.profile.id.isNotEmpty.toString() + ' ' + (snapshot.data?[0] == true).toString());
          if (autoLogin) {
            return HomePageStack(_pages);
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (AuthService.instance.profile == null || AuthService.instance.profile.id.isEmpty) {
            return const LoginPage();
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
