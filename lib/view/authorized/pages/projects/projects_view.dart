import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/classes/auth_provider.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'projects_active/projects_active_view.dart';
import 'projects_all/projects_all_view.dart';
import 'projects_finished/projects_finished_view.dart';
import 'projects_viewmodel.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    context.watch<ProjectsViewModel>();
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'projects'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      floatingActionButton: context.read<AuthProvider>().projectsCreate ? FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, Routes.projectsCreate);
        },
      ) : null,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProjectsViewModel viewModel, child) => Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: CupertinoSlidingSegmentedControl(
              padding: const EdgeInsets.all(5),
              backgroundColor: Colors.blue.shade100,
              children: viewModel.tabs,
              groupValue: viewModel.segmentedControlGroupValue,
              onValueChanged: (value) {
                viewModel.setSegmentedValue(value as int);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: IndexedStack(
                index: viewModel.segmentedControlGroupValue,
                children: const [
                  ProjectsActiveView(),
                  ProjectsFinishedView(),
                  ProjectsAllView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
