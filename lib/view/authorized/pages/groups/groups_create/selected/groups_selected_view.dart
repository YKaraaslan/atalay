import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/models/user_model.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../profile/profile_view.dart';

class GroupsSelectedView extends StatelessWidget {
  const GroupsSelectedView({Key? key, required this.usersSelectedForTeam}) : super(key: key);
  final List<UserModel> usersSelectedForTeam;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'selected_people'.tr(),
        actions: const [SizedBox()],
      ),
      onPageBuilder: (context, value) => _Body(usersSelectedForTeam: usersSelectedForTeam),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.usersSelectedForTeam}) : super(key: key);
  final List<UserModel> usersSelectedForTeam;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: usersSelectedForTeam.length,
      itemBuilder: (context, index) {
        return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileView(
                    userID: usersSelectedForTeam[index].id,
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(usersSelectedForTeam[index].imageURL),
            ),
            title: Text(usersSelectedForTeam[index].fullName),
            subtitle: Text(usersSelectedForTeam[index].position),
            trailing: const Icon(
              Icons.chevron_right,
            ));
      },
    );
  }
}
