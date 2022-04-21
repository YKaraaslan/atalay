import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/event_model.dart';
import '../../../../../core/widgets/base_appbar.dart';
import 'calendar_show_viewmodel.dart';

class CalendarShowView extends StatefulWidget {
  const CalendarShowView({Key? key, required this.model}) : super(key: key);
  final EventModel model;

  @override
  State<CalendarShowView> createState() => _CalendarShowViewState();
}

class _CalendarShowViewState extends State<CalendarShowView> {
  late final CalendarShowViewModel _viewModel = context.read<CalendarShowViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.titleTextController = TextEditingController();
    _viewModel.startTimeTextController = TextEditingController();
    _viewModel.endTimeTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();

    _viewModel.titleTextController.text = widget.model.title;
    _viewModel.startTimeTextController.text =
        DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(widget.model.dateStart.millisecondsSinceEpoch));
    _viewModel.endTimeTextController.text =
        DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(widget.model.dateEnd.millisecondsSinceEpoch));
    _viewModel.descriptionTextController.text = widget.model.description;

    _viewModel.time = widget.model.dateStart;
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.titleTextController.dispose();
    _viewModel.startTimeTextController.dispose();
    _viewModel.endTimeTextController.dispose();
    _viewModel.descriptionTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'calendar'.tr(),
        actions: const [SizedBox()],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Consumer(
          builder: (context, CalendarShowViewModel _viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _viewModel.titleTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'title'.tr(),
                ),
                maxLength: 30,
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
              TextFormField(
                controller: _viewModel.descriptionTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'description'.tr(),
                ),
                maxLength: 100,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red.withOpacity(0.7)),
                    ),
                    child: const Text('Sil'),
                    onPressed: () {
                      _viewModel.delete(context);
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
