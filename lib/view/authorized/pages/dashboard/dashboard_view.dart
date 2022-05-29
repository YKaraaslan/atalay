import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/classes/auth_provider.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/models/announcement_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/theme/dark_theme_provider.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'dashboard_viewmodel.dart';
import 'widgets/weekly_days.dart';

part 'widgets/announcement.dart';
part 'widgets/my_duties.dart';
part 'widgets/project_status.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'dashboard'.tr(),
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
  late final DashboardViewModel _viewModel = context.read<DashboardViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.announcementController = TextEditingController();
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.announcementController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: AppPaddings.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WeeklyDays(),
            const SizedBox(height: 20),
            const _Announcement(),
            const SizedBox(height: 10),
            Text(
              'Proje Durumu',
              style: Styles.cardTitleStyle(),
            ),
            const SizedBox(height: 10),
            const _ProjectsStatus(),
            const SizedBox(height: 30),
            Text(
              'Görevlerim',
              style: Styles.cardTitleStyle(),
            ),
            const SizedBox(height: 10),
            const _MyDuties(),
          ],
        ),
      ),
    );
  }
}
