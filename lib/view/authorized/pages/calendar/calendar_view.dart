import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/models/event_model.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'calendar_create/calendar_create_view.dart';
import 'calendar_show/calendar_show_view.dart';
import 'calendar_viewmodel.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final CalendarViewModel _viewModel = context.read<CalendarViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
    _viewModel.dialogTextController = TextEditingController();
    _viewModel.eventController = EventController();
    _viewModel.getEvents(context);
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.dialogTextController.dispose();
    _viewModel.eventController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: widget.zoomDrawerController,
        title: 'calendar'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, CalendarViewModel viewModel, child) => WeekView(
        controller: viewModel.eventController,
        heightPerMinute: 1, // height occupied by 1 minute time span.
        eventArranger: const SideEventArranger(), // To define how simultaneous events will be arranged.
        onEventTap: (events, date) {
          EventModel model = EventModel(
            title: events[0].title,
            description: events[0].description,
            dateStart: Timestamp.fromMillisecondsSinceEpoch(events[0].startTime!.millisecondsSinceEpoch),
            dateEnd: Timestamp.fromMillisecondsSinceEpoch(events[0].endTime!.millisecondsSinceEpoch),
            createdAt: Timestamp.now(),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CalendarShowView(model: model),
            ),
          );
        },
        onDateLongPress: (date) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CalendarCreateView(dateTime: date),
            ),
          );
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //weekPageHeaderBuilder: (date1, date2) => Text('$date1 - $date2'),
      ),
    );
  }
}
