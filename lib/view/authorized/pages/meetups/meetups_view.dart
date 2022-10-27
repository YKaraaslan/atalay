import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/classes/auth_provider.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/models/meeting_model.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'meetups_show/meetups_show_view.dart';

class MeetupsView extends StatelessWidget {
  const MeetupsView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'meetups'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      floatingActionButton: context.read<AuthProvider>().meetingsCreate
          ? FloatingActionButton(
              child: const Icon(Icons.create),
              onPressed: () {
                Navigator.pushNamed(context, Routes.meetupsCreate);
              },
            )
          : null,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FirestoreQueryBuilder(
        query: ServicePath.meetingsCollectionReference.orderBy('startsAt', descending: true),
        builder: (context, snapshot, _) {
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }

          if (snapshot.hasData) {
            return _MeetupsList(snapshot: snapshot);
          }
          return Container();
        },
      ),
    );
  }
}

class _MeetupsList extends StatelessWidget {
  const _MeetupsList({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  final FirestoreQueryBuilderSnapshot<Object?> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.docs.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        MeetingModel meeting = MeetingModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MeetupsShowView(model: meeting, id: snapshot.docs[index].id),
              ),
            );
          },
          child: _MeetupsCard(meeting: meeting),
        );
      },
    );
  }
}

class _MeetupsCard extends StatelessWidget {
  const _MeetupsCard({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  final MeetingModel meeting;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.lightGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.only(left: 5),
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      meeting.title,
                      style: Styles.cardTitleStyle(),
                    ),
                  ),
                  FutureBuilder<DocumentSnapshot>(
                      future: ServicePath.usersCollectionReference.doc(meeting.createdBy).get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(radius: 15, backgroundImage: NetworkImage(snapshot.data!.get('imageURL')));
                        }
                        return Container();
                      }),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.timelapse,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10),
                  Text(DateFormat('dd MMMM hh:mm').format(DateTime.fromMillisecondsSinceEpoch(meeting.startsAt.millisecondsSinceEpoch))),
                  const Text(' - '),
                  Text(DateFormat('dd MMMM hh:mm').format(DateTime.fromMillisecondsSinceEpoch(meeting.endsAt.millisecondsSinceEpoch))),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 10),
                  Text(meeting.location),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
