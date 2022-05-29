import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/constant/sizes.dart';
import '../../../../../../core/models/project_model.dart';
import '../../../../../../core/models/project_todo_model.dart';
import '../../../../../../core/service/service_path.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../projects_update/projects_update_view.dart';
import '../../projects_viewmodel.dart';
import '../team/project_team_view.dart';

class ProjectDetailsView extends StatelessWidget {
  const ProjectDetailsView({Key? key, required this.model}) : super(key: key);
  final ProjectModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: model.title,
        actions: const [],
      ),
      onPageBuilder: (context, value) => _Body(model: model),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectsUpdateView(model: model),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final ProjectModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _CreatedBy(model: widget.model),
            const SizedBox(height: 35),
            _Percentile(model: widget.model),
            const SizedBox(height: 35),
            const Text(
              'Project',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              widget.model.explanation,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 35),
            const Text(
              'Project Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _ProjectsList(widget: widget),
          ],
        ),
      ),
    );
  }
}

class _ProjectsList extends StatelessWidget {
  const _ProjectsList({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final _Body widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: ServicePath.projectsToDoCollectionReference(widget.model.projectID).orderBy('index').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ProjectToDoModel project = ProjectToDoModel.fromJson(snapshot.data!.docs[index].data() as Map<String, Object?>);
              return CheckboxListTile(
                value: project.status == 'finished',
                onChanged: (value) => false,
                title: Text(
                  project.text,
                  style: project.status == 'finished' ? const TextStyle(decoration: TextDecoration.lineThrough) : const TextStyle(),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _Percentile extends StatelessWidget {
  const _Percentile({Key? key, required this.model}) : super(key: key);
  final ProjectModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: context.read<ProjectsViewModel>().getPercentage(model.projectID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> snapshotData = snapshot.data as Map<String, dynamic>;
              return CircularStepProgressIndicator(
                width: Sizes.width_30percent(context),
                height: Sizes.width_30percent(context),
                totalSteps: 100,
                currentStep: snapshotData['percentage'],
                stepSize: 7,
                selectedColor: Colors.greenAccent,
                unselectedColor: Colors.grey[200],
                padding: 0,
                selectedStepSize: 10,
                roundedCap: (_, __) => true,
                child: Center(
                  child: Text(
                    "%${snapshotData['percentage']}",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 33),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectTeamView(users: model.team),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('team'.tr(), style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemCount: model.team.length <= 7 ? model.team.length : 7,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FutureBuilder<DocumentSnapshot>(
                          future: ServicePath.usersCollectionReference.doc(model.team[index]).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(snapshot.data!.get('imageURL')),
                                ),
                              );
                            } else {
                              return const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text('Deadline'),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.grey,
                ),
                Text(
                    '${DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(model.createdAt.millisecondsSinceEpoch)).toString()} - ${DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(model.deadline.millisecondsSinceEpoch)).toString()}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
              ],
            )
          ],
        )
      ],
    );
  }
}

class _CreatedBy extends StatelessWidget {
  const _CreatedBy({Key? key, required this.model}) : super(key: key);
  final ProjectModel model;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: ServicePath.usersCollectionReference.doc(model.createdBy).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RichText(
            text: TextSpan(
                text: DateFormat('dd MMMM').format(DateTime.fromMillisecondsSinceEpoch(model.createdAt.millisecondsSinceEpoch)).toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: ', ${'created_by'.tr()} ',
                  ),
                  TextSpan(
                    text: snapshot.data!.get('fullName'),
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ]),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
