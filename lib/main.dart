// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import 'config/environment.dart';
import 'l10n/l10n.dart';
import 'pages/auth/sign_in_page.dart';
import 'pages/auth/sign_up_page.dart';
import 'pages/profile_page.dart';
import 'pages/splash_page.dart';
import 'services/supabase/supabase_auth_service.dart';
import 'utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load enviroment
  await dotenv.load(fileName: ".env");
  print(Supabase);
  await Supabase.initialize(
    url: 'https://xcadcujuokfxgnkkiyhj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhjYWRjdWp1b2tmeGdua2tpeWhqIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzY3Nzk4MzUsImV4cCI6MTk5MjM1NTgzNX0.c1kP8pSpInBos-ILI50WcZlmmKtocYTZETOaN0IlM5U',
  );

  timeago.setLocaleMessages('ru', timeago.RuMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<SupabaseAuthService>(
        create: (_) => SupabaseAuthService(),
        lazy: false,
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        routes: <String, WidgetBuilder>{
          SplashPage.routeName: (_) => const SplashPage(),
          ProfilePage.routeName: (_) => const ProfilePage(),
          SignInPage.routeName: (_) => const SignInPage(),
          SignUpPage.routeName: (_) => const SignUpPage(),
        },
      );
    });
  } // Widget
}
