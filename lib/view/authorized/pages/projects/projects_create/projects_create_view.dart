import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import '../../../../../core/widgets/base_textformfield.dart';
import '../../groups/groups_create/selected/groups_selected_view.dart';
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
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
    _viewModel.titleController = TextEditingController();
    _viewModel.explanationController = TextEditingController();
    _viewModel.deadlineController = TextEditingController();
    _viewModel.toDoTextController = TextEditingController();
    _viewModel.usersSelectedForTeam = [];
    _viewModel.groupsSelectedForTeam = [];
    _viewModel.toDo = [];
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
    _viewModel.deadlineController.dispose();
    _viewModel.toDoTextController.dispose();
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
              _Title(viewModel: _viewModel),
              _Description(viewModel: _viewModel),
              const SizedBox(height: 15),
              _Deadline(viewModel: _viewModel),
              const SizedBox(height: 15),
              Text(
                'team'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const _Team(),
              _SeeTeamButton(viewModel: _viewModel),
              const SizedBox(
                height: 15,
              ),
              Text(
                'group'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const _Group(),
              const Divider(height: 10),
              _ToDoButton(viewModel: _viewModel),
              const _ToDos(),
              const Divider(height: 10),
              const SizedBox(height: 10),
              _CreateButton(viewModel: _viewModel),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({
    Key? key,
    required ProjectsCreateViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final ProjectsCreateViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Sizes.width_65percent(context),
        child: BaseButton(
          text: 'projects_create'.tr(),
          fun: () {
            if (_viewModel.formKey.currentState!.validate()) {
              _viewModel.createProject(context);
            }
          },
        ),
      ),
    );
  }
}

class _ToDos extends StatelessWidget {
  const _ToDos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProjectsCreateViewModel viewModel, child) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: viewModel.toDo.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.topLeft,
          child: ListTile(
            title: SelectableText(
              viewModel.toDo[index],
              style: const TextStyle(fontSize: 13),
            ),
            trailing: InkWell(
              onTap: () {
                viewModel.onDeletedMethod(index);
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
    );
  }
}

class _ToDoButton extends StatelessWidget {
  const _ToDoButton({
    Key? key,
    required ProjectsCreateViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final ProjectsCreateViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OutlinedButton(
        onPressed: () {
          _viewModel.addLabel(context);
        },
        child: Text(
          'add_todo'.tr(),
        ),
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProjectsCreateViewModel viewModel, child) => SizedBox(
        width: double.infinity,
        child: Card(
          child: ListTile(
            onTap: () {
              viewModel.navigateAndDisplaySelectionForGroups(context);
            },
            leading: Image.asset(
              Assets.groupsTeam,
              height: 30,
            ),
            title: Text("${viewModel.groupsSelectedForTeam.length.toString()} ${'group'.tr()}"),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}

class _SeeTeamButton extends StatelessWidget {
  const _SeeTeamButton({
    Key? key,
    required ProjectsCreateViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final ProjectsCreateViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}

class _Team extends StatelessWidget {
  const _Team({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ProjectsCreateViewModel viewModel, child) => SizedBox(
        width: double.infinity,
        child: Card(
          child: ListTile(
            onTap: () {
              viewModel.navigateAndDisplaySelectionForTeam(context);
            },
            leading: Image.asset(
              Assets.groupsTeam,
              height: 30,
            ),
            title: Text("${viewModel.usersSelectedForTeam.length.toString()} ${'person'.tr()}"),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}

class _Deadline extends StatelessWidget {
  const _Deadline({
    Key? key,
    required ProjectsCreateViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final ProjectsCreateViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
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
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required ProjectsCreateViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final ProjectsCreateViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _viewModel.explanationController,
      decoration: InputDecoration(labelText: 'project_explanation'.tr(), icon: const Icon(Icons.text_fields)),
      maxLength: 200,
      maxLines: 3,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'cannot_be_blank'.tr();
        }
        return null;
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required ProjectsCreateViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final ProjectsCreateViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _viewModel.titleController,
      decoration: InputDecoration(
        labelText: 'project_title'.tr(),
        icon: const Icon(Icons.title),
      ),
      maxLength: 50,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'cannot_be_blank'.tr();
        }
        return null;
      },
    );
  }
}
