import 'package:atalay/view/src/unauthorized/forgot_password/forgot_password_viewmodel.dart';

import 'core/theme/light_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'core/constant/routes.dart';
import 'view/src/unauthorized/login/login_viewmodel.dart';
import 'view/src/unauthorized/signup/signup_viewmodel.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordViewModel()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', ''), Locale('tr', '')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr', ''),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .whenComplete(() => FlutterNativeSplash.remove());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: appLightTheme(context),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: Routes.getRoutes(context),
      initialRoute: Routes.login,
    );
  }
}
