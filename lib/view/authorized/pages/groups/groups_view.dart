import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/models/groups_model.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'extras/details/groups_details_view.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'groups'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, Routes.groupsCreate);
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  //late final GroupsViewModel _viewModel = context.watch<GroupsViewModel>();

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder(
      query: ServicePath.groupsCollectionReference.orderBy('createdAt', descending: true),
      builder: (context, snapshot, _) {
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                GroupsModel group = GroupsModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupsDetailsView(model: group),
                      ),
                    );
                  },
                  leading: Image.network(group.imageURL, width: 75),
                  title: Text(group.title),
                  subtitle: Text(group.explanation),
                  trailing: const Icon(Icons.chevron_right),
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}
