import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/project_model.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import '../../../../../core/widgets/base_textformfield.dart';
import '../../groups/groups_create/selected/groups_selected_view.dart';
import 'projects_update_viewmodel.dart';

class ProjectsUpdateView extends StatelessWidget {
  const ProjectsUpdateView({Key? key, required this.model}) : super(key: key);
  final ProjectModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'projects_update'.tr(),
        actions: const [SizedBox()],
      ),
      onPageBuilder: (context, value) => _Body(model: model),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final ProjectModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ProjectsUpdateViewModel _viewModel = context.read<ProjectsUpdateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
    _viewModel.titleController = TextEditingController();
    _viewModel.explanationController = TextEditingController();
    _viewModel.deadlineController = TextEditingController();
    _viewModel.toDoTextController = TextEditingController();
    _viewModel.usersSelectedForTeam = [];
    _viewModel.groupsSelectedForTeam = [];
    _viewModel.toDo = [];
    _viewModel.toDoId = [];

    Future.delayed(const Duration(microseconds: 0), () => _viewModel.setPage(widget.model));
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.titleController.dispose();
    _viewModel.explanationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _viewModel.titleController,
                decoration: InputDecoration(
                  labelText: "project_title".tr(),
                  icon: const Icon(Icons.title),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'cannot_be_blank'.tr();
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _viewModel.explanationController,
                decoration: InputDecoration(labelText: "project_explanation".tr(), icon: const Icon(Icons.text_fields)),
                maxLength: 200,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'cannot_be_blank'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              BaseTextFormField(
                hint: 'deadline'.tr(),
                controller: _viewModel.deadlineController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.datetime,
                prefixIcon: const Icon(Icons.date_range_outlined),
                isReadOnly: true,
                fun: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'deadline_validator'.tr();
                  }
                  return null;
                },
                onTap: () {
                  _viewModel.showDateTimePicker(context);
                },
              ),
              const SizedBox(height: 15),
              Text(
                'team'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              Consumer(
                builder: (context, ProjectsUpdateViewModel _viewModel, child) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        _viewModel.navigateAndDisplaySelectionForTeam(context);
                      },
                      leading: Image.asset(
                        Assets.groupsTeam,
                        height: 30,
                      ),
                      title: Text("${_viewModel.usersSelectedForTeam.length.toString()} ${'person'.tr()}"),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text(
                    'see_team'.tr(),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GroupsSelectedView(usersSelectedForTeam: _viewModel.usersSelectedForTeam),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'group'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              Consumer(
                builder: (context, ProjectsUpdateViewModel _viewModel, child) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        _viewModel.navigateAndDisplaySelectionForGroups(context);
                      },
                      leading: Image.asset(
                        Assets.groupsTeam,
                        height: 30,
                      ),
                      title: Text("${_viewModel.groupsSelectedForTeam.length.toString()} ${'group'.tr()}"),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              ),
              /*const Divider(height: 10),
              Align(
                alignment: Alignment.center,
                child: OutlinedButton(
                  onPressed: () {
                    _viewModel.addLabel(context);
                  },
                  child: Text(
                    'add_todo'.tr(),
                  ),
                ),
              ),
              Consumer(
                builder: (context, ProjectsUpdateViewModel _viewModel, child) => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemCount: _viewModel.toDo.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Align(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      title: SelectableText(
                        _viewModel.toDo[index],
                        style: const TextStyle(fontSize: 13),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _viewModel.onDeletedMethod(index);
                        },
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close_rounded,
                            size: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              const Divider(height: 10),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: BaseButton(
                    text: 'projects_update'.tr(),
                    fun: () {
                      if (_viewModel.formKey.currentState!.validate()) {
                        _viewModel.updateProject(context, widget.model);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}