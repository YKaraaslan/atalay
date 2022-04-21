import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/models/post_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_posts.dart';
import 'post_comments/post_comments_view.dart';
import 'posts_viewmodel.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'posts'.tr(),
        color: Colors.white,
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, Routes.postCreate);
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
  late final PostsViewModel _viewModel = context.watch<PostsViewModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FirestoreQueryBuilder(
        query: ServicePath.postsCollectionReference.where("isVisible", isEqualTo: true).orderBy('publishedAt', descending: true),
        builder: (context, snapshot, _) {
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                PostModel post = PostModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);
                return FutureBuilder(
                  future: _viewModel.getUserInfos(post),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const _ShimmerEffect();
                      }
                      return BasePost(
                        model: snapshot.data,
                        onLikePressed: () {
                          _viewModel.like(snapshot.data);
                        },
                        onCommentPressed: () {
                          showBarModalBottomSheet(
                            context: context,
                            builder: (context) => PostCommentsView(model: snapshot.data),
                          );
                        },
                        onSavePressed: () {
                          _viewModel.save(snapshot.data);
                        },
                        onDelete: (){
                          _viewModel.delete(context, snapshot.data);
                        },
                      );
                    }
                    return const _ShimmerEffect();
                  },
                );
              },
            );
          } else {
            return const Text('-');
          }
        },
      ),
    );
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: AnimatedShimmer.round(
              size: 45,
            ),
            title: const AnimatedShimmer(
              height: 10,
              width: 10,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            subtitle: const AnimatedShimmer(
              height: 10,
              width: 100,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Column(
              children: const [
                AnimatedShimmer(
                  height: 10,
                  width: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                SizedBox(height: 5),
                AnimatedShimmer(
                  height: 10,
                  width: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                SizedBox(height: 5),
                AnimatedShimmer(
                  height: 10,
                  width: double.infinity,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }
}
