import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/groups_model.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import '../../profile/profile_view.dart';
import '../groups_create/selected/groups_selected_view.dart';
import 'groups_update_viewmodel.dart';

class GroupsUpdateView extends StatelessWidget {
  const GroupsUpdateView({Key? key, required this.model}) : super(key: key);
  final GroupsModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'groups_create'.tr(),
        actions: const [SizedBox()],
      ),
      onPageBuilder: (context, value) => _Body(model: model),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final GroupsModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final GroupsUpdateViewModel _viewModel = context.read<GroupsUpdateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.nameController = TextEditingController();
    _viewModel.explanationController = TextEditingController();
    _viewModel.usersSelectedForTeam = [];
    _viewModel.image = null;

    Future.delayed(const Duration(microseconds: 0), () => _viewModel.getData(widget.model));
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
                builder: (context, GroupsUpdateViewModel _viewModel, child) => Center(
                  child: InkWell(
                    onTap: () {
                      _viewModel.getFromGallery();
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Card(
                        child: _viewModel.image == null
                            ? Hero(
                                tag: "photo",
                                child: Image.network(widget.model.imageURL, width: 100, height: 100, fit: BoxFit.cover),
                              )
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
                builder: (context, GroupsUpdateViewModel _viewModel, child) => SizedBox(
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileView(
                          userID: _viewModel.personInCharge!.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                'team'.tr(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              Consumer(
                builder: (context, GroupsUpdateViewModel _viewModel, child) => SizedBox(
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GroupsSelectedView(usersSelectedForTeam: _viewModel.usersSelectedForTeam),
                            ),
                          );
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
                    'choose_for_team'.tr(),
                  ),
                  onPressed: () {
                    _viewModel.navigateAndDisplaySelection(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: BaseButton(
                    text: 'group_update'.tr(),
                    fun: () {
                      if (_viewModel.formKey.currentState!.validate()) {
                        _viewModel.updateGroup(context, widget.model);
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
