import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'settings'.tr(),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        child: Text('sign_out'.tr()),
        onPressed: () {
          _viewModel.signOut(context);
        },
      ),
    );
  }
}
