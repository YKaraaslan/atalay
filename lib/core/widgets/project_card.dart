import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../view/authorized/pages/projects/extras/details/project_details_view.dart';
import '../constant/sizes.dart';
import '../constant/styles.dart';
import '../models/project_model.dart';

class ProjectsCard extends StatelessWidget {
  const ProjectsCard({
    Key? key,
    required this.photos,
    required this.percentage,
    required this.taskAmount,
    required this.model,
    required this.id,
  }) : super(key: key);

  final List<Widget> photos;
  final int taskAmount;
  final int percentage;
  final ProjectModel model;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsView(model: model),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _CardUpperSection(model: model, photos: photos, percentage: percentage),
              const SizedBox(height: 15),
              _CardBottom(model: model, taskAmount: taskAmount),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardUpperSection extends StatelessWidget {
  const _CardUpperSection({
    Key? key,
    required this.model,
    required this.photos,
    required this.percentage,
  }) : super(key: key);

  final ProjectModel model;
  final List<Widget> photos;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.title, style: Styles.cardTitleStyle()),
              const SizedBox(height: 5),
              Text(model.explanation, style: Theme.of(context).textTheme.bodySmall),
              Visibility(
                visible: photos.isNotEmpty,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text('team'.tr(), style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 5),
                    Row(
                      children: photos,
                    ),
                  ],
                ),
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
    );
  }
}

class _CardBottom extends StatelessWidget {
  const _CardBottom({
    Key? key,
    required this.taskAmount,
    required this.model,
  }) : super(key: key);

  final ProjectModel model;
  final int taskAmount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.grey,
              ),
              Text(
                  '${DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(model.createdAt.millisecondsSinceEpoch)).toString()} - ${DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(model.deadline.millisecondsSinceEpoch)).toString()}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
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
              Text('$taskAmount ${'duty'.tr()}', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}
