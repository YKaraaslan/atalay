import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/constant/styles.dart';
import '../../../../../../core/models/groups_model.dart';
import '../../../../../../core/service/service_path.dart';
import '../../../profile/profile_view.dart';
import '../../groups_update/groups_update_view.dart';
import 'groups_details_viewmodel.dart';

class GroupsDetailsView extends StatelessWidget {
  const GroupsDetailsView({Key? key, required this.model}) : super(key: key);
  final GroupsModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => _Body(model: model),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupsUpdateView(model: model),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final GroupsModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late final GroupDetailsViewModel _viewModel = context.read<GroupDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.controller = TabController(length: context.read<GroupDetailsViewModel>().tabs.length, vsync: this);
    _viewModel.pages = [
      Container(),
      Container(),
      Container(),
    ];
    Future.delayed(const Duration(microseconds: 0), (() {
      _viewModel.setTabs(widget.model);
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, GroupDetailsViewModel _viewModel, child) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: false,
            leading: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2), child: BackButton(color: Colors.black, onPressed: () => Navigator.pop(context))),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        color: Colors.grey,
                        child: Image.network(
                          widget.model.imageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            color: Colors.black.withOpacity(0.5),
                            padding: AppPaddings.appPadding,
                            child: Text(
                              widget.model.title,
                              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => true,
                          child: FutureBuilder<DocumentSnapshot>(
                            future: ServicePath.usersCollectionReference.doc(widget.model.userInCharge).get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sorumlu personel',
                                      style: cardTitleStyle(),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ProfileView(userID: snapshot.data!.get('id')),
                                          ),
                                        );
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(snapshot.data!.get('imageURL')),
                                      ),
                                      title: Text(snapshot.data!.get('fullName')),
                                      subtitle: Text(snapshot.data!.get('position')),
                                      trailing: const Icon(Icons.chevron_right),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text("-");
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Aciklama',
                          style: cardTitleStyle(),
                        ),
                        const SizedBox(height: 10),
                        Text(widget.model.explanation),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 470.0,
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: _viewModel.tabs,
              controller: _viewModel.controller,
            ),
          )
        ],
        body: TabBarView(
          controller: _viewModel.controller,
          children: _viewModel.pages,
        ),
      ),
    );
  }
}
