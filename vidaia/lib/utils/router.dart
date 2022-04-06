import 'package:auto_route/auto_route.dart';
import 'package:vidaia/pages/buy_history_page.dart';
import 'package:vidaia/pages/login_page.dart';
import 'package:vidaia/pages/redeem_page.dart';
import 'package:vidaia/pages/settings_page.dart';

import '../pages/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        page: EmptyRouterPage,
        initial: true,
        path: '/',
        children: [
          AutoRoute(page: LoginPage, path: ''),
          AutoRoute(page: HomePage, name: 'HomeRoute', path: 'home'),   
          AutoRoute(page: RedeemPage, name: 'RedeemRoute', path: 'redeem'),
          AutoRoute(
              page: BuyHistoryPage,
              name: 'BuyHistoryRoute',
              path: 'buy_history'),
          AutoRoute(
              page: SettingsPage, name: 'SettingsRoute', path: 'settings'),
        ]),
  ],
)
class $AppRouter {}

