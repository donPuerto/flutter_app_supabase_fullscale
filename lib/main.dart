// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/environment.dart';
import 'l10n/l10n.dart';
import 'pages/splash_page.dart';
import 'router.dart';
import 'utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load enviroment
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseAnonKey,
  );

  timeago.setLocaleMessages('ru', timeago.RuMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Supabase.instance.client.auth.onAuthStateChange((event, session) {
    //   switch (event) {
    //     case AuthChangeEvent.signedIn:
    //       Navigator.of(globalAppNavigatorKey.currentContext!)
    //           .pushNamedAndRemoveUntil('/account', (route) => false);
    //       break;
    //     case AuthChangeEvent.signedOut:
    //       Navigator.of(globalAppNavigatorKey.currentContext!)
    //           .pushNamedAndRemoveUntil('/login', (route) => false);
    //       break;
    //     default:
    //       break;
    //   }
    // });

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Supabase App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        supportedLocales: L10n.all,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        initialRoute: SplashPage.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
    });
  } // Widget
}
