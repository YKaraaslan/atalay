import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/models/users_onhold_model.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'users_onhold_viewmodel.dart';

class UsersOnHoldView extends StatefulWidget {
  const UsersOnHoldView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  State<UsersOnHoldView> createState() => _UsersOnHoldViewState();
}

class _UsersOnHoldViewState extends State<UsersOnHoldView> {
  late final UsersOnHoldViewModel _viewmodel = context.watch<UsersOnHoldViewModel>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'users_onhold'.tr(),
        zoomDrawerController: widget.zoomDrawerController,
        actions: const [],
      ),
      onPageBuilder: (context, value) => FirestoreQueryBuilder(
        query: _viewmodel.usersOnHoldCollection,
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

              UsersOnHoldModel usersOnHold = snapshot.docs[index].data() as UsersOnHoldModel;

              return Container(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.userDetails, arguments: usersOnHold);
                  },
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(usersOnHold.imageURL),
                  ),
                  title: Text(usersOnHold.fullName),
                  subtitle: Text(DateFormat('dd MMMM yyyy hh:mm a')
                      .format(DateTime.fromMillisecondsSinceEpoch(usersOnHold.signUpTime.millisecondsSinceEpoch))
                      .toString()),
                  trailing: const Icon(
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
