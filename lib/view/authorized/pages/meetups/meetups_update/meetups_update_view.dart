import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/meeting_model.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import '../../groups/groups_create/selected/groups_selected_view.dart';
import 'meetups_update_viewmodel.dart';

class MeetupsUpdateView extends StatelessWidget {
  const MeetupsUpdateView({Key? key, required this.model, required this.id}) : super(key: key);
  final MeetingModel model;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'meetups'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => _Body(model: model, id: id),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model, required this.id}) : super(key: key);
  final MeetingModel model;
  final String id;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final MeetupsUpdateViewModel _viewModel = context.read<MeetupsUpdateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.titleTextController = TextEditingController();
    _viewModel.startTimeTextController = TextEditingController();
    _viewModel.endTimeTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.locationTextController = TextEditingController();
    _viewModel.startTime = DateTime.fromMillisecondsSinceEpoch(widget.model.startsAt.millisecondsSinceEpoch);
    _viewModel.endTime = DateTime.fromMillisecondsSinceEpoch(widget.model.endsAt.millisecondsSinceEpoch);
    _viewModel.startTimeTextController.text = DateFormat('dd MMM yyyy, hh:mm').format(_viewModel.startTime);
    _viewModel.endTimeTextController.text = DateFormat('dd MMM yyyy, hh:mm').format(_viewModel.endTime);
    _viewModel.usersSelectedForTeam = [];

    _viewModel.titleTextController.text = widget.model.title;
    _viewModel.descriptionTextController.text = widget.model.description;
    _viewModel.locationTextController.text = widget.model.location;

    _viewModel.id = widget.id;

    Future.delayed(const Duration(microseconds: 0), () => _viewModel.getData(widget.model));
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.titleTextController.dispose();
    _viewModel.startTimeTextController.dispose();
    _viewModel.endTimeTextController.dispose();
    _viewModel.descriptionTextController.dispose();
    _viewModel.locationTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Consumer(
          builder: (context, MeetupsUpdateViewModel _viewModel, child) => Form(
            key: _viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _viewModel.titleTextController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'title'.tr(),
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'cannot_be_blank'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _viewModel.descriptionTextController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'description'.tr(),
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'cannot_be_blank'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _viewModel.locationTextController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'location'.tr(),
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'cannot_be_blank'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _viewModel.startTimeTextController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'start_time'.tr(),
                        ),
                        readOnly: true,
                        onTap: () {
                          _viewModel.showTimePicker(context, 'start_time'.tr());
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'cannot_be_blank'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _viewModel.endTimeTextController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'end_time'.tr(),
                        ),
                        readOnly: true,
                        onTap: () {
                          _viewModel.showTimePicker(context, 'end_time'.tr());
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'cannot_be_blank'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Consumer(
                  builder: (context, MeetupsUpdateViewModel _viewModel, child) => SizedBox(
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
                      text: 'create_event'.tr(),
                      fun: () async {
                        if (_viewModel.formKey.currentState!.validate()) {
                          _viewModel.updateMeeting(context, widget.model);
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
      ),
    );
  }
}
