import 'package:atalay/core/base/view/base_view.dart';
import 'package:atalay/core/constant/assets.dart';
import 'package:atalay/view/authorized/pages/social/social_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import 'messages/messages_view.dart';
import 'posts/posts_view.dart';

class SocialView extends StatefulWidget {
  const SocialView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  State<SocialView> createState() => _SocialViewState();
}

class _SocialViewState extends State<SocialView> {
  late final SocialViewModel _viewModel = context.watch<SocialViewModel>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => IndexedStack(
        index: _viewModel.currentIndex,
        children: [
          PostsView(zoomDrawerController: widget.zoomDrawerController),
          MessagesView(zoomDrawerController: widget.zoomDrawerController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _viewModel.currentIndex,
        onTap: (index) {
          _viewModel.setPage(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                Assets.socialPosts,
                height: 30,
              ),
              label: "posts".tr()),
          BottomNavigationBarItem(
              icon: Image.asset(
                Assets.socialMessages,
                height: 30,
                color: Colors.blue,
              ),
              label: "messages".tr()),
        ],
      ),
    );
  }
}
