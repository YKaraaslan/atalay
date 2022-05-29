import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../core/classes/auth_provider.dart';
import '../../../core/constant/assets.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/styles.dart';
import '../../../core/service/service_path.dart';
import '../pages/calendar/calendar_view.dart';
import '../pages/dashboard/dashboard_view.dart';
import '../pages/finance/finance_view.dart';
import '../pages/groups/groups_view.dart';
import '../pages/meetups/meetups_view.dart';
import '../pages/posts/posts_view.dart';
import '../pages/profile/profile_view.dart';
import '../pages/projects/projects_view.dart';
import '../pages/references/references_view.dart';
import '../pages/settings/settings_view.dart';
import '../pages/users/users_view.dart';
import '../pages/users_onhold/users_onhold_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, this.pageToShow}) : super(key: key);
  final String? pageToShow;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().setOnline();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<HomeViewModel>().setOnline();
        break;
      case AppLifecycleState.inactive:
        context.read<HomeViewModel>().setOffline();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return context.read<HomeViewModel>().onWillPop();
      },
      child: BaseView(
        onPageBuilder: (context, value) => ZoomDrawer(
          controller: context.read<HomeViewModel>().zoomDrawerController,
          borderRadius: 24,
          style: DrawerStyle.defaultStyle,
          showShadow: true,
          moveMenuScreen: false,
          openCurve: Curves.fastOutSlowIn,
          disableDragGesture: false,
          mainScreenTapClose: true,
          slideWidth: Sizes.width_65percent(context),
          duration: const Duration(milliseconds: 500),
          menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          angle: 0.0,
          clipMainScreen: true,
          mainScreen: GestureDetector(
            onTap: context.read<HomeViewModel>().menuTap,
            child: context.watch<HomeViewModel>().selectedWiget,
          ),
          menuScreen: const _Menu(),
          menuScreenWidth: double.infinity,
          menuScreenTapClose: true,
          drawerShadowsBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage(Assets.drawerMenuBackground),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Consumer<HomeViewModel>(
                builder: (context, viewModel, child) => Text(
                  'v${viewModel.version}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const _MenuItems(),
        ],
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  const _MenuItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Sizes.height_15percent(context),
      left: 10,
      child: SizedBox(
        width: Sizes.width_60percent(context),
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _PostsMenuItem(),
              _DashboardMenuItem(),
              _ProjectsMenuItem(),
              _UsersMenuItem(),
              _GroupsMenuItem(),
              _ReferencesMenuItem(),
              _FinanceMenuItem(),
              _MeetingsMenuItem(),
              _CalendarMenuItem(),
              _ProfileMenuItem(),
              _SettingsMenuItem(),
              _UsersOnHoldMenuItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostsMenuItem extends StatelessWidget {
  const _PostsMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabPosts,
      child: _Item(
        assetName: Assets.posts,
        title: 'posts'.tr(),
        widget: PostsView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _DashboardMenuItem extends StatelessWidget {
  const _DashboardMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabDashboard,
      child: _Item(
        assetName: Assets.dashboard,
        title: 'dashboard'.tr(),
        widget: DashboardView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _ProjectsMenuItem extends StatelessWidget {
  const _ProjectsMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabProjects,
      child: _Item(
        assetName: Assets.projects,
        title: 'projects'.tr(),
        widget: ProjectsView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _UsersMenuItem extends StatelessWidget {
  const _UsersMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabUsers,
      child: _Item(
        assetName: Assets.onlineUsers,
        title: 'users'.tr(),
        widget: UsersView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _GroupsMenuItem extends StatelessWidget {
  const _GroupsMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabGroups,
      child: _Item(
        assetName: Assets.groups,
        title: 'groups'.tr(),
        widget: GroupsView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _ReferencesMenuItem extends StatelessWidget {
  const _ReferencesMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabReferences,
      child: _Item(
        assetName: Assets.references,
        title: 'references'.tr(),
        widget: ReferencesView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _FinanceMenuItem extends StatelessWidget {
  const _FinanceMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabFinances,
      child: _Item(
        assetName: Assets.finance,
        title: 'finance'.tr(),
        widget: FinanceView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _MeetingsMenuItem extends StatelessWidget {
  const _MeetingsMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabMeetings,
      child: _Item(
        assetName: Assets.meetups,
        title: 'meetups'.tr(),
        widget: MeetupsView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _CalendarMenuItem extends StatelessWidget {
  const _CalendarMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Item(
      assetName: Assets.calendar,
      title: 'calendar'.tr(),
      widget: CalendarView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Item(
      assetName: Assets.profile,
      title: 'profile'.tr(),
      widget: ProfileView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController, userID: ServicePath.auth.currentUser!.uid),
    );
  }
}

class _SettingsMenuItem extends StatelessWidget {
  const _SettingsMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Item(
      assetName: Assets.settings,
      title: 'settings'.tr(),
      widget: SettingsView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
    );
  }
}

class _UsersOnHoldMenuItem extends StatelessWidget {
  const _UsersOnHoldMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<AuthProvider>().tabUsersOnHold,
      child: _Item(
        assetName: Assets.usersOnHold,
        title: 'users_onhold'.tr(),
        widget: UsersOnHoldView(zoomDrawerController: context.read<HomeViewModel>().zoomDrawerController),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.assetName, required this.title, required this.widget}) : super(key: key);
  final String assetName;
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<HomeViewModel>().setPage(widget);
        context.read<HomeViewModel>().zoomDrawerController.toggle!();
      },
      child: Row(
        children: [
          CircleAvatar(radius: 10, backgroundColor: Colors.transparent, child: Image.asset(assetName)),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Styles.zoomMenuTextStyle(),
          ),
        ],
      ),
    );
  }
}
