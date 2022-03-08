import 'projects_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    context.watch<ProjectsViewModel>();
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'projects'.tr(),
      ),
      onPageBuilder: (context, value) => const _Body(),
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
              child: viewModel.child
            ),
          ),
        ],
      ),
    );
  }
}
