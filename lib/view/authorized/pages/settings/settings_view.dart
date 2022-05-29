import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/theme/dark_theme_provider.dart';
import '../../../../core/widgets/base_appbar.dart';
import '../profile/profile_update/profile_update_view.dart';
import 'mail_changer.dart/confirm_credentials.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'settings'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final SettingsViewModel _viewModel = context.read<SettingsViewModel>();
  late String language = context.locale == const Locale('tr', 'TR') ? 'Türkçe' : 'English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SettingsList(
        lightBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        darkBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shrinkWrap: true,
        sections: [
          account(),
          application(context),
          general(),
        ],
      ),
    );
  }

  SettingsSection general() {
    return SettingsSection(
      title: 'Genel',
      titlePadding: const EdgeInsets.only(top: 20, left: 15, bottom: 10),
      tiles: [
        SettingsTile(
          title: 'Atalay Mobil Hakkinda',
          leading: const Icon(Icons.info_outlined),
          onPressed: (context) {},
          trailing: const Icon(Icons.chevron_right),
        ),
        SettingsTile(
          title: 'Cikis Yap',
          leading: const Icon(Icons.exit_to_app),
          onPressed: (context) {
            _viewModel.signOut(context);
          },
        ),
      ],
    );
  }

  SettingsSection application(BuildContext context) {
    return SettingsSection(
      title: 'Uygulama',
      titlePadding: const EdgeInsets.only(top: 20, left: 15, bottom: 10),
      tiles: [
        SettingsTile(
          title: 'Dil',
          subtitle: language,
          leading: const Icon(Icons.language_outlined),
          onPressed: (context) {
            _viewModel.languageDialog(context);
          },
          trailing: const Icon(Icons.chevron_right),
        ),
        SettingsTile.switchTile(
          title: 'Gece Temasi',
          leading: const Icon(Icons.color_lens_outlined),
          trailing: const Icon(Icons.chevron_right),
          switchValue: context.watch<DarkThemeProvider>().darkTheme,
          onToggle: (value) {
            context.read<DarkThemeProvider>().darkTheme = value;
          },
        ),
        SettingsTile.switchTile(
          title: 'Bildirimler',
          leading: const Icon(Icons.notifications_active_outlined),
          trailing: const Icon(Icons.chevron_right),
          switchValue: context.watch<SettingsViewModel>().isNotificationAllowed,
          onToggle: (value) {
            _viewModel.setNotificationStatus(value);
          },
        ),
      ],
    );
  }

  SettingsSection account() {
    return SettingsSection(
      title: 'Hesap',
      tiles: [
        SettingsTile(
          title: 'Profil Bilgileri',
          leading: const Icon(Icons.account_circle_outlined),
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileUpdateView(),
              ),
            );
          },
          trailing: const Icon(Icons.chevron_right),
        ),
        SettingsTile(
          title: 'Mail Adresi',
          leading: const Icon(Icons.mail_outline),
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConfirmCredentials(),
              ),
            );
          },
          trailing: const Icon(Icons.chevron_right),
        ),
        SettingsTile(
          title: 'Şifre',
          leading: const Icon(Icons.password),
          onPressed: (context) {},
          trailing: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
