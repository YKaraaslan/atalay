import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/models/post_comment_model.dart';
import '../../../../../../core/service/service_path.dart';
import '../../../../../../core/widgets/post_comment_item.dart';
import '../post_likes/post_like_view.dart';
import '../posts_ui_model.dart';
import 'post_comment_ui_model.dart';
import 'post_comments_viewmodel.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => _Body(model: model),
      backgroundColor: Colors.white,
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
  late final PostCommentsViewModel _viewModel = context.read<PostCommentsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.commentController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              const BackButton(),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showBarModalBottomSheet(
                      context: context,
                      builder: (context) => PostLikesView(model: widget.model),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FutureBuilder(
                        future: _viewModel.getLikes(widget.model.postID),
                        builder: (context, snapshot) {
                          int counter = 0;
                          if (snapshot.hasData) {
                            counter = snapshot.data as int;
                          }
                          return Text("${counter.toString()} ${'likes_received'.tr()}");
                        },
                      ),
                      const SizedBox(width: 25),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: FirestoreQueryBuilder(
            query: ServicePath.postsCommentsCollectionReference(widget.model.postID).orderBy('commentedAt'),
            builder: (context, snapshot, _) {
              if (snapshot.hasError) {
                return Text('error ${snapshot.error}');
              }

              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.docs.length,
                    itemBuilder: (context, index) {
                      PostCommentModel model = PostCommentModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);

                      return FutureBuilder(
                        future: _viewModel.getUserInfos(model),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return PostCommentItem(model: snapshot.data as PostCommentUiModel);
                          }

                          return Container();
                        },
                      );
                    });
              }

              return Container();
            },
          ),
        ),
        _BottomPart(postID: widget.model.postID),
      ],
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key, required this.postID}) : super(key: key);
  final String postID;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        color: Colors.grey.shade100,
        padding: AppPaddings.appPadding,
        child: Consumer(
          builder: (context, PostCommentsViewModel _viewModel, child) => Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: TextFormField(
                    controller: _viewModel.commentController,
                    decoration: const InputDecoration(
                      hintText: 'Yorum yaz...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                    ),
                    maxLines: 5,
                    minLines: 1,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  if (_viewModel.commentController.text.isNotEmpty) {
                    _viewModel.comment(context, postID);
                  }
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.send,
                    color: Colors.blue[700],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
