import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/service/service_path.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../profile/profile_view.dart';

class ProjectTeamView extends StatelessWidget {
  const ProjectTeamView({Key? key, required this.users}) : super(key: key);
  final List<dynamic> users;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'team'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => FutureBuilder<DocumentSnapshot>(
            future: ServicePath.usersCollectionReference.doc(users[index]).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileView(
                          userID: snapshot.data!.get('id'),
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.get('imageURL')),
                  ),
                  title: Text(snapshot.data!.get('fullName')),
                  subtitle: Text(snapshot.data!.get('position')),
                  trailing: const Icon(Icons.chevron_right),
                );
              } else {
                return const _ShimmerEffect();
              }
            }),
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
        color: Colors.white,
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
