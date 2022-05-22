import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/styles.dart';

class WeeklyDays extends StatelessWidget {
  const WeeklyDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 1)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 1))
                        .day
                ? Colors.green.shade100
                : null),
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 2)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 2)).day
                ? Colors.green.shade100
                : null),
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 3)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 3)).day
                ? Colors.green.shade100
                : null),
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 4)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 4)).day
                ? Colors.green.shade100
                : null),
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 5)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 5)).day
                ? Colors.green.shade100
                : null),
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 6)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 6)).day
                ? Colors.green.shade100
                : null),
        _WeeklyDaysBaseView(
            date: DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday - 7)),
            selectionColor: DateTime.now().day ==
                    DateTime.now()
                        .subtract(Duration(days: DateTime.now().weekday - 7)).day
                ? Colors.green.shade100
                : null),
      ],
    );
  }
}

class _WeeklyDaysBaseView extends StatelessWidget {
  const _WeeklyDaysBaseView({Key? key, required this.date, this.selectionColor})
      : super(key: key);

  final DateTime date;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
          width: 100,
          height: 70,
          margin: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: selectionColor ?? Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(DateFormat('MMM', 'tr').format(date).toUpperCase(),
                    style: defaultMonthTextStyle(context)),
                Text(date.day.toString(), style: defaultDateTextStyle(context)),
                Text(DateFormat('E', 'tr').format(date).toUpperCase(),
                    style: defaultDayTextStyle(context))
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
