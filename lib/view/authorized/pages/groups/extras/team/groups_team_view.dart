import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/models/groups_model.dart';
import '../../../../../../core/service/service_path.dart';
import '../../../profile/profile_view.dart';

class GroupsTeamView extends StatelessWidget {
  const GroupsTeamView({Key? key, required this.groupsModel}) : super(key: key);
  final GroupsModel groupsModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => ListView.builder(
        itemCount: groupsModel.people.length,
        itemBuilder: (context, index) => FutureBuilder<DocumentSnapshot>(
          future: ServicePath.usersCollectionReference.doc(groupsModel.people[index]).get(),
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
              return Container();
            }
          },
        ),
      ),
    );
  }
}
