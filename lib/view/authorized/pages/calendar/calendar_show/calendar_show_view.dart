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
    _viewModel.startTimeTextController.text = DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(widget.model.dateStart.millisecondsSinceEpoch));
    _viewModel.endTimeTextController.text = DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(widget.model.dateEnd.millisecondsSinceEpoch));
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
        child: Consumer<CalendarShowViewModel>(
          builder: (context, viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Title(),
              SizedBox(height: 20),
              _Time(),
              SizedBox(height: 20),
              _Description(),
              SizedBox(height: 10),
              _Button(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Sizes.width_65percent(context),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red.withOpacity(0.7)),
          ),
          child: const Text('Sil'),
          onPressed: () {
            context.read<CalendarShowViewModel>().delete(context);
          },
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<CalendarShowViewModel>().descriptionTextController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'description'.tr(),
      ),
      maxLength: 100,
      readOnly: true,
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: context.read<CalendarShowViewModel>().startTimeTextController,
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
            controller: context.read<CalendarShowViewModel>().endTimeTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'end_time'.tr(),
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.read<CalendarShowViewModel>().titleTextController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'title'.tr(),
      ),
      maxLength: 30,
      readOnly: true,
    );
  }
}
