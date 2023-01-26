import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/classes/time_ago.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/widgets/base_appbar.dart';
import '../profile/profile_view.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'users'.tr(),
        zoomDrawerController: widget.zoomDrawerController,
        actions: const [],
      ),
      onPageBuilder: (context, value) => FirestoreQueryBuilder(
        query: ServicePath.usersCollectionReference
            .orderBy('online', descending: true)
            .orderBy('onlineTime', descending: true),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const _ShimmerEffect();
          }
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          return ListView.builder(
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }
              UserModel users = UserModel.fromJson(
                  snapshot.docs[index].data() as Map<String, Object?>);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileView(
                          userID: users.id,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(users.imageURL),
                  ),
                  title: Text(users.fullName),
                  subtitle: users.online
                      ? Text('online'.tr(),
                          style: const TextStyle(color: Colors.green))
                      : Text(
                          TimeAgo.timeAgoSinceDate(users.onlineTime),
                        ),
                  trailing: users.online
                      ? const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 7,
                        )
                      : const Icon(
                          Icons.chevron_right,
                          size: 20,
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          leading: AnimatedShimmer.round(
            size: 50,
          ),
          title: const AnimatedShimmer(
            height: 10,
            width: 10,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          subtitle: const AnimatedShimmer(
            height: 10,
            width: 10,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          trailing: AnimatedShimmer.round(
            size: 15,
          ),
        ),
      ),
    );
  }
}
