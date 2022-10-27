import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constant/paddings.dart';
import '../../../../../core/models/project_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/project_card.dart';
import '../projects_viewmodel.dart';

class ProjectsAllView extends StatefulWidget {
  const ProjectsAllView({Key? key}) : super(key: key);

  @override
  State<ProjectsAllView> createState() => _ProjectsAllViewState();
}

class _ProjectsAllViewState extends State<ProjectsAllView> {
  late final ProjectsViewModel _viewModel = context.watch<ProjectsViewModel>();

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
      query: ServicePath.projectsCollectionReference.orderBy('createdAt', descending: true),
      builder: (context, snapshot, _) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.docs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }
              ProjectModel project = ProjectModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);

              return Padding(
                padding: AppPaddings.appPadding,
                child: FutureBuilder(
                    future: _viewModel.getPercentage(snapshot.docs[index].id),
                    builder: (context, snapshotFuture) {
                      if (snapshotFuture.hasData) {
                        Map<String, dynamic> snapshotData = snapshotFuture.data as Map<String, dynamic>;
                        return ProjectsCard(
                          model: project,
                          id: snapshot.docs[index].id,
                          percentage: snapshotData['percentage'],
                          photos: List.generate(
                            project.team.length <= 5 ? project.team.length : 5,
                            (index) {
                              return FutureBuilder<DocumentSnapshot>(
                                future: ServicePath.usersCollectionReference.doc(project.team[index]).get(),
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
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                          taskAmount: snapshotData['total'],
                        );
                      } else {
                        return Container();
                      }
                    }),
              );
            },
          );
        }
        return const _ShimmerEffect();
      },
      pageSize: 20,
    );
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: AnimatedShimmer.round(
              size: 45,
            ),
            title: const AnimatedShimmer(
              height: 10,
              width: 10,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            subtitle: const AnimatedShimmer(
              height: 10,
              width: 100,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Column(
              children: const [
                AnimatedShimmer(
                  height: 10,
                  width: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }
}
