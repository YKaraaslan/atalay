import 'package:atalay/core/base/view/base_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'view/authorized/pages/posts/post_details.dart/post_details_viewmodel.dart';

import 'view/authorized/pages/groups/extras/details/groups_details_viewmodel.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constant/routes.dart';
import 'core/theme/light_theme.dart';
import 'view/authorized/home/home_viewmodel.dart';
import 'view/authorized/pages/dashboard/dashboard_viewmodel.dart';
import 'view/authorized/pages/finance/finance_viewmodel.dart';
import 'view/authorized/pages/groups/groups_viewmodel.dart';
import 'view/authorized/pages/meetups/meetups_viewmodel.dart';
import 'view/authorized/pages/profile/profile_viewmodel.dart';
import 'view/authorized/pages/projects/projects_viewmodel.dart';
import 'view/authorized/pages/references/references_viewmodel.dart';
import 'view/unauthorized/forgot_password/forgot_password_viewmodel.dart';
import 'view/unauthorized/login/login_viewmodel.dart';
import 'view/unauthorized/signup/signup_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BaseViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => DashboardViewModel()),
        ChangeNotifierProvider(create: (context) => FinanceViewModel()),
        ChangeNotifierProvider(create: (context) => GroupsViewModel()),
        ChangeNotifierProvider(create: (context) => MeetupsViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => ProjectsViewModel()),
        ChangeNotifierProvider(create: (context) => ReferencesViewModel()),
        ChangeNotifierProvider(create: (context) => GroupDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => PostDetailsViewModel()),
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
  late String _route;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser == null
        ? _route = Routes.login
        : _route = Routes.home;

    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          _route = Routes.login;
        } else {
          _route = Routes.home;
        }
      },
    );

    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: appLightTheme(context),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: Routes.getRoutes(context),
        initialRoute: Routes.login,
        //initialRoute: _route,
      ),
    );
  }
}
