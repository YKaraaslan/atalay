import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import 'calendar_create_viewmodel.dart';

class CalendarCreateView extends StatefulWidget {
  const CalendarCreateView({Key? key, required this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  State<CalendarCreateView> createState() => _CalendarCreateViewState();
}

class _CalendarCreateViewState extends State<CalendarCreateView> {
  late final CalendarCreateViewModel _viewModel = context.read<CalendarCreateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.titleTextController = TextEditingController();
    _viewModel.startTimeTextController = TextEditingController();
    _viewModel.endTimeTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.startTime = widget.dateTime;
    _viewModel.endTime = widget.dateTime.add(const Duration(hours: 1));
    _viewModel.startTimeTextController.text = DateFormat('hh:mm').format(_viewModel.startTime);
    _viewModel.endTimeTextController.text = DateFormat('hh:mm').format(_viewModel.endTime);
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
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: DateFormat('dd MMMM yyyy').format(widget.dateTime),
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
          builder: (context, CalendarCreateViewModel _viewModel, child) => Form(
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
                  maxLength: 30,
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
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Sizes.width_65percent(context),
                    child: BaseButton(
                      text: 'create_event'.tr(),
                      fun: () async {
                        if (_viewModel.formKey.currentState!.validate()) {
                          await _viewModel.createEvent(context);
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
