import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
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
    return WeekView(
      controller: EventController(),
      eventTileBuilder: (date, events, boundry, start, end) {
        // Return your widget to display as event tile.
        return Container();
      },
      heightPerMinute: 1, // height occupied by 1 minute time span.
      eventArranger: const SideEventArranger(), // To define how simultaneous events will be arranged.
      onEventTap: (events, date) => events,
      onDateLongPress: (date) => date,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //weekPageHeaderBuilder: (date1, date2) => Text('$date1 - $date2'),
    );
  }
}
