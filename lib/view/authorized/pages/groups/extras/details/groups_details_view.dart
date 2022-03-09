import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/assets.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/constant/styles.dart';
import 'groups_details_viewmodel.dart';

class GroupsDetailsView extends StatelessWidget {
  const GroupsDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();    
    _controller = TabController(length: context.read<GroupDetailsViewModel>().tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GroupDetailsViewModel _viewmodel = context.watch<GroupDetailsViewModel>();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          floating: false,
          leading: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.2),
            child: BackButton(color: Colors.black, onPressed: ()=> Navigator.pop(context))),
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
                      child: Image.asset(Assets.software, fit: BoxFit.cover,),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: AppPaddings.appPadding,
                        child: const Text('Yazilim Grubu', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sorumlu personel',
                              style: cardTitleStyle(),
                            ),
                            const ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://avatars.githubusercontent.com/u/34814190?v=4'),
                              ),
                              title: Text('Yunus Karaaslan'),
                              subtitle: Text('Yazilim muhendisi'),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Aciklama',
                        style: cardTitleStyle(),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
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
            tabs: _viewmodel.tabs,
            controller: _controller,
          ),
        )
      ],
      body: TabBarView(
        controller: _controller,
        children: _viewmodel.pages,
      ),
    );
  }
}
