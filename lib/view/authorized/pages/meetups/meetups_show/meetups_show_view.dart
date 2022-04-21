import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../core/models/meeting_model.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../meetups_update/meetups_update_view.dart';
import 'meetups_show_viewmodel.dart';

class MeetupsShowView extends StatelessWidget {
  const MeetupsShowView({Key? key, required this.model, required this.id}) : super(key: key);
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
  late final MeetupsShowViewModel _viewModel = context.read<MeetupsShowViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.titleTextController = TextEditingController();
    _viewModel.startTimeTextController = TextEditingController();
    _viewModel.endTimeTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.locationTextController = TextEditingController();
    _viewModel.listTiles = [];
    _viewModel.model = widget.model;
    _viewModel.id = widget.id;
    _viewModel.setFields();

    Future.delayed(const Duration(microseconds: 0), () => _viewModel.getParticipants(context));
  }

  @override
  void dispose() {
    super.dispose();
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
          builder: (context, MeetupsShowViewModel _viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _viewModel.titleTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'title'.tr(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.descriptionTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'description'.tr(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.locationTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'location'.tr(),
                ),
                readOnly: true,
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _viewModel.listTiles.isNotEmpty ? 'Katilimcilar' : '',
                style: buttonTextStyle().copyWith(color: Colors.blue.shade800),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemCount: _viewModel.listTiles.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => _viewModel.listTiles[index],
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: OutlinedButton(
                    child: const Text(
                      'Toplantiyi Sil',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      _viewModel.delete(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: OutlinedButton(
                    child: const Text(
                      'Toplantiyi Duzenle',
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeetupsUpdateView(model: widget.model, id: widget.id),
                        ),
                      );
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
