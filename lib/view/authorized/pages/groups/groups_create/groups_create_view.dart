import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import 'groups_create_viewmodel.dart';
import 'selected/groups_selected_view.dart';

class GroupsCreateView extends StatelessWidget {
  const GroupsCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'groups_create'.tr(),
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
  late final GroupsCreateViewModel _viewModel = context.read<GroupsCreateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.nameController = TextEditingController();
    _viewModel.explanationController = TextEditingController();
    _viewModel.usersSelectedForTeam = [];
    _viewModel.personInCharge = null;
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.nameController.dispose();
    _viewModel.explanationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'group_photo'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, GroupsCreateViewModel _viewModel, child) => Center(
                  child: InkWell(
                    onTap: () {
                      _viewModel.getFromGallery();
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Card(
                        child: _viewModel.image == null
                            ? Image.asset(Assets.groupCreatePhoto, width: 100, height: 100, fit: BoxFit.contain)
                            : Hero(
                                tag: "photo",
                                child: Image.file(_viewModel.image!, width: 100, height: 100, fit: BoxFit.cover),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _viewModel.nameController,
                decoration: InputDecoration(
                  labelText: "group_name".tr(),
                  icon: const Icon(Icons.title),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'group_name_validator'.tr();
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _viewModel.explanationController,
                decoration: InputDecoration(labelText: "group_explanation".tr(), icon: const Icon(Icons.text_fields)),
                maxLength: 200,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'group_explanation_validator'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'person_incharge'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, GroupsCreateViewModel _viewModel, child) => SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GroupsSelectedView(usersSelectedForTeam: _viewModel.usersSelectedForTeam),
                      ));
                    }),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (_viewModel.personInCharge != null) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                _viewModel.navigateAndDisplaySelectionForPersonInCharge(context);
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _viewModel.personInCharge!.imageURL,
                                ),
                              ),
                              title: Text(_viewModel.personInCharge!.fullName),
                              subtitle: Text(_viewModel.personInCharge!.position),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          );
                        } else {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                _viewModel.navigateAndDisplaySelectionForPersonInCharge(context);
                              },
                              leading: Image.asset(
                                Assets.profile,
                                height: 30,
                              ),
                              title: Text("person_incharge".tr()),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text(
                    'see_profile'.tr(),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.profile);
                  },
                ),
              ),
              Text(
                'team'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              Consumer(
                builder: (context, GroupsCreateViewModel _viewModel, child) => SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GroupsSelectedView(usersSelectedForTeam: _viewModel.usersSelectedForTeam),
                      ));
                    }),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          _viewModel.navigateAndDisplaySelection(context);
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: BaseButton(
                    text: 'group_create'.tr(),
                    fun: () {
                      if (_viewModel.formKey.currentState!.validate()) {
                        _viewModel.createGroup(context);
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
