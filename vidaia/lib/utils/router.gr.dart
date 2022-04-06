// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

import '../pages/buy_history_page.dart' as _i5;
import '../pages/home_page.dart' as _i3;
import '../pages/login_page.dart' as _i2;
import '../pages/redeem_page.dart' as _i4;
import '../pages/settings_page.dart' as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    EmptyRouterRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    HomeRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    RedeemRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RedeemPage());
    },
    BuyHistoryRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.BuyHistoryPage());
    },
    SettingsRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SettingsPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(EmptyRouterRoute.name, path: '/', children: [
          _i1.RouteConfig(LoginRoute.name,
              path: '', parent: EmptyRouterRoute.name),
          _i1.RouteConfig(HomeRoute.name,
              path: 'home', parent: EmptyRouterRoute.name),
          _i1.RouteConfig(RedeemRoute.name,
              path: 'redeem', parent: EmptyRouterRoute.name),
          _i1.RouteConfig(BuyHistoryRoute.name,
              path: 'buy_history', parent: EmptyRouterRoute.name),
          _i1.RouteConfig(SettingsRoute.name,
              path: 'settings', parent: EmptyRouterRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class EmptyRouterRoute extends _i1.PageRouteInfo<void> {
  const EmptyRouterRoute({List<_i1.PageRouteInfo>? children})
      : super(EmptyRouterRoute.name, path: '/', initialChildren: children);

  static const String name = 'EmptyRouterRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.RedeemPage]
class RedeemRoute extends _i1.PageRouteInfo<void> {
  const RedeemRoute() : super(RedeemRoute.name, path: 'redeem');

  static const String name = 'RedeemRoute';
}

/// generated route for
/// [_i5.BuyHistoryPage]
class BuyHistoryRoute extends _i1.PageRouteInfo<void> {
  const BuyHistoryRoute() : super(BuyHistoryRoute.name, path: 'buy_history');

  static const String name = 'BuyHistoryRoute';
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i1.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings');

  static const String name = 'SettingsRoute';
}
