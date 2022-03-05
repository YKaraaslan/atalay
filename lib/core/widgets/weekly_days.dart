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
        _WeeklyDaysBaseView(date: DateTime.now().subtract(const Duration(days: 3),),),
        _WeeklyDaysBaseView(date: DateTime.now().subtract(const Duration(days: 2),),),
        _WeeklyDaysBaseView(date: DateTime.now().subtract(const Duration(days: 1),),),
        _WeeklyDaysBaseView(date: DateTime.now(), selectionColor: const Color.fromARGB(255, 213, 231, 247),),
        _WeeklyDaysBaseView(date: DateTime.now().add(const Duration(days: 1),),),
        _WeeklyDaysBaseView(date: DateTime.now().add(const Duration(days: 2),),),
        _WeeklyDaysBaseView(date: DateTime.now().add(const Duration(days: 3),),),
      ],
    );
  }
}

class _WeeklyDaysBaseView extends StatelessWidget {
  const _WeeklyDaysBaseView({Key? key, required this.date, this.selectionColor}) : super(key: key);

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
                Text(DateFormat("MMM", 'tr').format(date).toUpperCase(), style:  defaultMonthTextStyle),
                Text(date.day.toString(), style:  defaultDateTextStyle),
                Text(DateFormat("E", 'tr').format(date).toUpperCase(), style:  defaultDayTextStyle)
              ],
            ),
          ),
        ),
        onTap: () {
    
        },
      ),
    );
  }
}