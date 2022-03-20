import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/widgets/base_appbar.dart';
import 'projects_create_viewmodel.dart';

class ProjectsCreateView extends StatelessWidget {
  const ProjectsCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'projects_create'.tr(),
        actions: const [SizedBox()],
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
  late final ProjectsCreateViewModel _viewModel = context.read<ProjectsCreateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.titleController = TextEditingController();
    _viewModel.explanationController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.titleController.dispose();
    _viewModel.explanationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.contentPadding,
      child: Form(
        key: _viewModel.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _viewModel.titleController,
              decoration:  InputDecoration(
                labelText: "project_title".tr(),
                icon: const Icon(Icons.title),
              ),
              maxLength: 50,
            ),
            TextFormField(
              controller: _viewModel.explanationController,
              decoration:  InputDecoration(
                labelText: "project_explanation".tr(),
                icon: const Icon(Icons.text_fields)
              ),
              maxLength: 200,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}