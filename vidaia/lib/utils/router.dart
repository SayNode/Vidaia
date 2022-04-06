import 'package:auto_route/auto_route.dart';
import 'package:vidaia/pages/login_page.dart';

import '../pages/home_page.dart';

@MaterialAutoRouter(        
  replaceInRouteName: 'Page,Route',        
  routes: <AutoRoute>[        
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: LoginPage, name: 'LoginRoute', path: 'login'),        
    //AutoRoute(page: BookDetailsPage),        
  ],        
)        

class $AppRouter {}  