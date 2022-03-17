import 'package:atalay/view/authorized/pages/posts/post_create/post_create_viewmodel.dart';
import 'package:atalay/view/authorized/pages/posts/post_likes/post_like_viewmodel.dart';
import 'package:atalay/view/authorized/pages/posts/posts_viewmodel.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'view/authorized/pages/users/users_viewmodel.dart';
import 'view/authorized/pages/users_onhold/userDetails/user_details_viewmodel.dart';

import 'core/service/service_path.dart';
import 'firebase_options.dart';
import 'view/authorized/home/home_view.dart';
import 'view/authorized/pages/users_onhold/users_onhold_viewmodel.dart';
import 'view/unauthorized/login/login_view.dart';

import 'core/base/view/base_viewmodel.dart';
import 'view/authorized/pages/settings/settings_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'view/authorized/pages/posts/post_details/post_details_viewmodel.dart';

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
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
        ChangeNotifierProvider(create: (context) => SettingsViewModel()),
        ChangeNotifierProvider(create: (context) => UsersOnHoldViewModel()),
        ChangeNotifierProvider(create: (context) => UserDetailsViewModel()),
        ChangeNotifierProvider(create: (context) => UsersViewModel()),
        ChangeNotifierProvider(create: (context) => PostsViewModel()),
        ChangeNotifierProvider(create: (context) => PostCreateViewModel()),
        ChangeNotifierProvider(create: (context) => PostLikeViewModel()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', ''), Locale('tr', '')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr', 'TR'),
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
  late Widget child;
  final appCheck = FirebaseAppCheck.instance;

  @override
  void initState() {
    super.initState();
    appCheck.onTokenChange.listen((event) { });
    appCheck.setTokenAutoRefreshEnabled(true);
    ServicePath.auth.currentUser == null ? child = const LoginView() : child = const HomeView();

    ServicePath.auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          setState(() {
            child = const LoginView();
          });
        } else {
          setState(() {
            child = const HomeView();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        //home: TrainingView(),
        home: child,
      ),
    );
  }
}
