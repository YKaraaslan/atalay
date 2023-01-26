import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'core/base/view/base_viewmodel.dart';
import 'core/classes/auth_provider.dart';
import 'core/constant/routes.dart';
import 'core/service/service_path.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/dark_theme_provider.dart';
import 'core/theme/light_theme.dart';
import 'firebase_options.dart';
import 'view/authorized/home/home_view.dart';
import 'view/authorized/home/home_viewmodel.dart';
import 'view/authorized/pages/calendar/calendar_create/calendar_create_viewmodel.dart';
import 'view/authorized/pages/calendar/calendar_show/calendar_show_viewmodel.dart';
import 'view/authorized/pages/calendar/calendar_viewmodel.dart';
import 'view/authorized/pages/dashboard/dashboard_viewmodel.dart';
import 'view/authorized/pages/finance/finance_transaction/finance_transaction_viewmodel.dart';
import 'view/authorized/pages/finance/finance_viewmodel.dart';
import 'view/authorized/pages/groups/extras/details/groups_details_viewmodel.dart';
import 'view/authorized/pages/groups/groups_create/add_to_team/add_to_team_viewmodel.dart';
import 'view/authorized/pages/groups/groups_create/groups_create_viewmodel.dart';
import 'view/authorized/pages/groups/groups_update/groups_update_viewmodel.dart';
import 'view/authorized/pages/groups/groups_viewmodel.dart';
import 'view/authorized/pages/meetups/meetups_create/meetups_create_viewmodel.dart';
import 'view/authorized/pages/meetups/meetups_show/meetups_show_viewmodel.dart';
import 'view/authorized/pages/meetups/meetups_update/meetups_update_viewmodel.dart';
import 'view/authorized/pages/meetups/meetups_viewmodel.dart';
import 'view/authorized/pages/posts/post_comments/post_comments_viewmodel.dart';
import 'view/authorized/pages/posts/post_create/post_create_viewmodel.dart';
import 'view/authorized/pages/posts/post_details/post_details_viewmodel.dart';
import 'view/authorized/pages/posts/post_likes/post_like_viewmodel.dart';
import 'view/authorized/pages/posts/post_update/post_update_viewmodel.dart';
import 'view/authorized/pages/posts/posts_viewmodel.dart';
import 'view/authorized/pages/profile/profile_update/profile_update_viewmodel.dart';
import 'view/authorized/pages/profile/profile_viewmodel.dart';
import 'view/authorized/pages/projects/projects_create/add_group/add_group_viewmodel.dart';
import 'view/authorized/pages/projects/projects_create/projects_create_viewmodel.dart';
import 'view/authorized/pages/projects/projects_update/projects_update_viewmodel.dart';
import 'view/authorized/pages/projects/projects_viewmodel.dart';
import 'view/authorized/pages/references/references_add_to_companies/references_add_to_companies_viewmodel.dart';
import 'view/authorized/pages/references/references_company_create/references_company_create_viewmodel.dart';
import 'view/authorized/pages/references/references_company_show/references_company_show_viewmodel.dart';
import 'view/authorized/pages/references/references_company_update/references_company_update_viewmodel.dart';
import 'view/authorized/pages/references/references_person_create/references_person_create_viewmodel.dart';
import 'view/authorized/pages/references/references_person_show/references_person_show_viewmodel.dart';
import 'view/authorized/pages/references/references_person_update/references_person_update_viewmodel.dart';
import 'view/authorized/pages/references/references_viewmodel.dart';
import 'view/authorized/pages/settings/settings_viewmodel.dart';
import 'view/authorized/pages/users/users_viewmodel.dart';
import 'view/authorized/pages/users_onhold/userDetails/user_details_viewmodel.dart';
import 'view/authorized/pages/users_onhold/users_onhold_viewmodel.dart';
import 'view/authorized/updates/updates_viewmodel.dart';
import 'view/unauthorized/forgot_password/forgot_password_viewmodel.dart';
import 'view/unauthorized/login/login_view.dart';
import 'view/unauthorized/login/login_viewmodel.dart';
import 'view/unauthorized/signup/signup_viewmodel.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BaseViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => DarkThemeProvider(), lazy: true),
        ChangeNotifierProvider(create: (context) => AuthProvider(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => UpdatesViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => LoginViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => SignUpViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ForgotPasswordViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => HomeViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => DashboardViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => FinanceViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => GroupsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => MeetupsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ProfileViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ProjectsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => GroupDetailsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => PostDetailsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => SettingsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => UsersOnHoldViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => UserDetailsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => UsersViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => PostsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => PostCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => PostLikeViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => PostCommentsViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => PostUpdateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ProjectsCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => GroupsCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => GroupsUpdateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => AddToTeamViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => AddGroupViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ProjectsUpdateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => FinanceTransactionViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => CalendarViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => CalendarCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => CalendarShowViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ProfileViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ProfileUpdateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => MeetupsCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => MeetupsCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => MeetupsShowViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => MeetupsUpdateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesAddToCompaniesViewModel(),
            lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesCompanyCreateViewModel(),
            lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesCompanyShowViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesCompanyUpdateViewModel(),
            lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesPersonCreateViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesPersonShowViewModel(), lazy: true),
        ChangeNotifierProvider(
            create: (context) => ReferencesPersonUpdateViewModel(), lazy: true),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr', 'TR'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  late Widget child;
  late final themeChangeProvider = context.read<DarkThemeProvider>();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();

    if (ServicePath.auth.currentUser == null) {
      child = const LoginView();
    } else {
      child = const HomeView();
      Future.sync(getAuth);
    }

    getCurrentAppTheme();

    ServicePath.auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          setState(() {
            child = const LoginView();
            FlutterNativeSplash.remove();
          });
        } else {
          setState(() {
            child = const HomeView();
            Future.sync(getAuth);
            FlutterNativeSplash.remove();
          });
        }
      },
    );
  }

  Future getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  Future getAuth() async {
    await ServicePath.usersCollectionReference
        .doc(ServicePath.auth.currentUser!.uid)
        .get()
        .then((value) async {
      await ServicePath.authorizationCollectionReference
          .doc(value.get('authorization'))
          .get()
          .then((document) {
        if (document.exists) {
          context.read<AuthProvider>().index = document.get('index');
          context.read<AuthProvider>().name = document.get('name');
          context.read<AuthProvider>().postsCreate =
              document.get('postsCreate');
          context.read<AuthProvider>().announcementsCreate =
              document.get('announcementsCreate');
          context.read<AuthProvider>().projectsCreate =
              document.get('projectsCreate');
          context.read<AuthProvider>().groupsCreate =
              document.get('groupsCreate');
          context.read<AuthProvider>().referencesCreate =
              document.get('referencesCreate');
          context.read<AuthProvider>().financesCreate =
              document.get('financesCreate');
          context.read<AuthProvider>().meetingsCreate =
              document.get('meetingsCreate');
          context.read<AuthProvider>().tabPosts = document.get('tabPosts');
          context.read<AuthProvider>().tabDashboard =
              document.get('tabDashboard');
          context.read<AuthProvider>().tabProjects =
              document.get('tabProjects');
          context.read<AuthProvider>().tabUsers = document.get('tabUsers');
          context.read<AuthProvider>().tabGroups = document.get('tabGroups');
          context.read<AuthProvider>().tabReferences =
              document.get('tabReferences');
          context.read<AuthProvider>().tabFinances =
              document.get('tabFinances');
          context.read<AuthProvider>().tabMeetings =
              document.get('tabMeetings');
          context.read<AuthProvider>().tabUsersOnHold =
              document.get('tabUsersOnHold');
          context.read<AuthProvider>().notify();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
          themeMode: context.watch<DarkThemeProvider>().darkTheme
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: appLightTheme(context),
          darkTheme: appDarkTheme(context),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: Routes.getRoutes(context),
          home: child,
          // home: const UpdatesView(),
        ),
      ),
    );
  }
}
