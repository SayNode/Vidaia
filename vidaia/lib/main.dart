import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/utils/router.gr.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp()),
  );
}

const primaryColor = Color(0xFF0b3b2d);
const primaryColorBright = Color(0xFF6c9772);
const primaryColorDark = Color(0xFF112823);

const backgroundColor = Color(0xFFf8faf7);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        //Localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        //

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: const Color(0xFFf8faf7),
          iconTheme: const IconThemeData(color: backgroundColor),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
          ),
          appBarTheme: const AppBarTheme(
            color: primaryColor,
          ),
          bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
          textTheme: TextTheme(
            headline1: GoogleFonts.quicksand(
                fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            headline2: GoogleFonts.quicksand(
                fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            headline3: GoogleFonts.quicksand(
                fontSize: 48, fontWeight: FontWeight.w400),
            headline4: GoogleFonts.quicksand(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headline5: GoogleFonts.quicksand(
                fontSize: 24, fontWeight: FontWeight.w400),
            headline6: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            subtitle1: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.quicksand(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.quicksand(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            overline: GoogleFonts.quicksand(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          ),
        ),
        darkTheme: ThemeData.dark());
  }
}
