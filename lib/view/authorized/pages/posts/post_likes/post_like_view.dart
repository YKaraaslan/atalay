import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/classes/time_ago.dart';
import '../../../../../../core/constant/assets.dart';
import '../../../../../../core/models/post_like_model.dart';
import '../../../../../../core/service/service_path.dart';
import '../../../../../../core/widgets/no_data.dart';
import '../../profile/profile_view.dart';
import '../posts_ui_model.dart';
import 'post_like_ui_model.dart';
import 'post_like_viewmodel.dart';

class PostLikesView extends StatelessWidget {
  const PostLikesView({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => _Body(model: model),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final PostLikeViewModel _viewModel = context.read<PostLikeViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.uiModel = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BackButton(),
          Expanded(
            child: FirestoreQueryBuilder(
              query: ServicePath.postsLikesCollectionReference(widget.model.postID).orderBy('likedAt'),
              builder: (context, snapshot, _) {
                if (snapshot.isFetching || snapshot.isFetchingMore) {
                  return const _ShimmerEffect();
                }
                if (snapshot.hasError) {
                  return Text('error ${snapshot.error}');
                }
                if (snapshot.docs.isNotEmpty && snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.docs.length,
                    itemBuilder: (context, index) {
                      PostLikeModel post = PostLikeModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileView(
                                userID: post.userID,
                              ),
                            ),
                          );
                        },
                        child: FutureBuilder(
                          future: _viewModel.getUserInfos(post),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const _ShimmerEffect();
                            } else if (snapshot.hasData) {
                              PostLikeUiModel model = snapshot.data as PostLikeUiModel;
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(model.imageURL),
                                ),
                                title: Text(model.nameSurname),
                                subtitle: Text(TimeAgo.timeAgoSinceDate(model.likedAt)),
                                trailing: CircleAvatar(radius: 15, backgroundColor: Colors.transparent, child: Image.asset(Assets.likeFilled)),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return NoDataView(
                    text: "no_like_yet".tr(),
                    image: Assets.thumbsUp,
                    fun: () {
                      _viewModel.like();
                    },
                  );
                }
              },
            ),
          ),
        ],
      );
    } catch (e) {
      return NoDataView(
        text: "no_like_yet".tr(),
        image: Assets.thumbsUp,
        fun: () {
          _viewModel.like();
        },
      );
    }
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      trailing: AnimatedShimmer.round(
        size: 25,
      ),
    );
  }
}
