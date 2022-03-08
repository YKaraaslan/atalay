import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../constant/routes.dart';
import '../constant/sizes.dart';
import '../constant/styles.dart';

class ProjectsCard extends StatelessWidget {
  const ProjectsCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.photos,
      required this.dateStart,
      required this.dateEnd,
      required this.percentage,
      this.taskAmount = 0})
      : super(key: key);

  final String title;
  final String subTitle;
  final List<Widget> photos;
  final String dateStart;
  final String dateEnd;
  final int taskAmount;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.projectDetails);
      },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: cardTitleStyle()),
                        const SizedBox(height: 5),
                        Text(subTitle,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 15),
                        Text('team'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 5),
                        Row(
                          children: photos,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CircularStepProgressIndicator(
                    width: Sizes.width_20percent(context),
                    height: Sizes.width_20percent(context),
                      totalSteps: 100,
                      currentStep: percentage,
                      stepSize: 3,
                      selectedColor: Colors.greenAccent,
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      selectedStepSize: 6,
                      roundedCap: (_, __) => true,
                      child: Center(
                        child: Text(
                          '%$percentage',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                        Text('$dateStart - $dateEnd',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Sizes.width_20percent(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.task_alt,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('$taskAmount ' + 'duty'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
