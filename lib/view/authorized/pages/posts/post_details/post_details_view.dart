import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_viewer/main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/assets.dart';
import '../../../../../../core/service/service_path.dart';
import '../../profile/profile_view.dart';
import '../post_comments/post_comments_view.dart';
import '../post_likes/post_like_view.dart';
import '../posts_ui_model.dart';
import 'post_details_viewmodel.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView(
      {Key? key, required this.model, required this.index, required this.onLikePressed, required this.onCommentPressed, required this.onDelete})
      : super(key: key);
  final PostUiModel model;
  final int index;
  final void Function() onLikePressed;
  final void Function() onCommentPressed;
  final void Function() onDelete;

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => _Body(
        model: widget.model,
        index: widget.index,
        onCommentPressed: widget.onCommentPressed,
        onLikePressed: widget.onLikePressed,
        onDelete: widget.onDelete,
      ),
      backgroundColor: Colors.black,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(
      {Key? key, required this.model, required this.index, required this.onLikePressed, required this.onCommentPressed, required this.onDelete})
      : super(key: key);
  final PostUiModel model;
  final int index;
  final void Function() onLikePressed;
  final void Function() onCommentPressed;
  final void Function() onDelete;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final PostDetailsViewModel _viewModel = context.read<PostDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileView(
                    userID: widget.model.authorID,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.model.authorImageURL),
              ),
              title: Text(
                widget.model.authorNameSurname,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                widget.model.authorPosition,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: IconButton(
                icon: const SizedBox(
                  width: 15,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  // Navigate to profile
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: SelectableText(
                widget.model.text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _viewModel.pageController,
              itemCount: widget.model.images.length,
              itemBuilder: (context, index) {
                return NetworkImageViewer(heroAttribute: widget.model.images[index], imageURL: widget.model.images[index]);
              },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomLeft,
            child: Visibility(
              visible: widget.model.labels.isNotEmpty,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                    widget.model.labels.length,
                    (index) => Chip(
                      label: Text(
                        widget.model.labels[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color.fromARGB(255, 42, 36, 49),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: ServicePath.postsLikesCollectionReference(widget.model.postID).snapshots(),
                          builder: (context, snapshot) {
                            String likes = "0";

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container();
                            }
                            if (snapshot.hasData) {
                              likes = snapshot.data!.docs.length.toString();
                            }

                            return Row(
                              children: [
                                SizedBox(
                                    width: 15,
                                    child: Image.asset(
                                      Assets.likeFilled,
                                      color: Colors.blue,
                                    )),
                                const SizedBox(width: 15),
                                Text(
                                  "$likes ${'likes_received'.tr()}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          }),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostLikesView(model: widget.model),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: ServicePath.postsCommentsCollectionReference(widget.model.postID).snapshots(),
                        builder: (context, snapshot) {
                          String comments = "0";

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container();
                          }
                          if (snapshot.hasData) {
                            comments = snapshot.data!.docs.length.toString();
                          }
                          return Row(
                            children: [
                              SizedBox(width: 15, child: Image.asset(Assets.groupsComments)),
                              const SizedBox(width: 15),
                              Text(
                                "$comments ${'comments_received'.tr()}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        }),
                    onPressed: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) => PostCommentsView(model: widget.model),
                      );
                    },
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: widget.onLikePressed,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: ServicePath.postsLikesCollectionReference(widget.model.postID).snapshots(),
                          builder: (context, snapshot) {
                            bool isLikedByMe = false;

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container();
                            }
                            if (snapshot.hasData) {
                              isLikedByMe = snapshot.data!.docs.any((element) => element.get("userID") == FirebaseAuth.instance.currentUser!.uid);
                            }

                            return Column(
                              children: [
                                isLikedByMe
                                    ? SizedBox(
                                        width: 15,
                                        child: Image.asset(
                                          Assets.likeFilled,
                                        ),
                                      )
                                    : SizedBox(
                                        width: 15,
                                        child: Image.asset(
                                          Assets.likeEmpty,
                                          color: Colors.white,
                                        ),
                                      ),
                                isLikedByMe
                                    ? Text(
                                        'liked'.tr(),
                                        style: const TextStyle(color: Colors.red),
                                      )
                                    : Text(
                                        'like'.tr(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                              ],
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: widget.onCommentPressed,
                      child: Column(
                        children: [
                          SizedBox(
                              width: 15,
                              child: Image.asset(
                                Assets.comment,
                                color: Colors.white,
                              )),
                          Text(
                            'comment'.tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
