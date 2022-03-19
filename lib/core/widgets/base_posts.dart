import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../view/authorized/pages/social/posts/post_comments/post_comments_view.dart';
import '../../view/authorized/pages/social/posts/post_details/post_details_view.dart';
import '../../view/authorized/pages/social/posts/post_likes/post_like_view.dart';
import '../../view/authorized/pages/social/posts/posts_ui_model.dart';
import '../classes/time_ago.dart';
import '../constant/assets.dart';
import '../constant/routes.dart';
import '../service/service_path.dart';
import 'base_bottom_sheet.dart';

class BasePost extends StatelessWidget {
  const BasePost(
      {Key? key,
      required this.model,
      required this.onLikePressed,
      required this.onCommentPressed,
      required this.onSavePressed,
      required this.onDelete})
      : super(key: key);
  final PostUiModel model;
  final void Function() onLikePressed;
  final void Function() onCommentPressed;
  final void Function() onSavePressed;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                Routes.profile,
              );
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(model.authorImageURL),
                ),
              ),
              title: Text(model.authorNameSurname),
              subtitle: Text(model.authorPosition),
              trailing: model.authorID == FirebaseAuth.instance.currentUser!.uid
                  ? IconButton(
                      icon: SizedBox(
                        width: 15,
                        child: Image.asset(
                          Assets.postMenu,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BaseBottomSheet(
                              model: model,
                              onDelete: () {
                                onDelete();
                              },
                            );
                          },
                        );
                      },
                    )
                  : const SizedBox(),
            ),
          ),
          Visibility(
            visible: model.text.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: SelectableText(model.text),
            ),
          ),
          _ImagesLayout(
            model: model,
            onLikePressed: onLikePressed,
            onCommentPressed: onCommentPressed,
            onDelete: onDelete,
          ),
          Visibility(
            visible: model.labels.isNotEmpty,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(
                      model.labels.length,
                      (index) => Chip(
                        label: Text(
                          model.labels[index],
                          style: const TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        backgroundColor: const Color.fromARGB(255, 241, 248, 253),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if (model.postID.isNotEmpty) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: ServicePath.postsLikesCollectionReference(model.postID).snapshots(),
                      builder: (context, snapshot) {
                        String likes = "0";
                        bool isLikedByMe = false;

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container();
                        }
                        if (snapshot.hasData) {
                          likes = snapshot.data!.docs.length.toString();
                          isLikedByMe = snapshot.data!.docs.any((element) => element.get("userID") == FirebaseAuth.instance.currentUser!.uid);
                        }
                        return Row(
                          children: [
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: onLikePressed,
                              child: SizedBox(
                                width: 20,
                                child: isLikedByMe
                                    ? Image.asset(
                                        Assets.likeFilled,
                                        color: Colors.red,
                                      )
                                    : Image.asset(
                                        Assets.likeEmpty,
                                        color: Colors.black,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostLikeView(model: model),
                                  ),
                                );
                              },
                              child: Text(likes),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
              const SizedBox(width: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (model.postID.isNotEmpty) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: ServicePath.postsCommentsCollectionReference(model.postID).snapshots(),
                      builder: (context, snapshot) {
                        String comments = "0";
                        bool isCommentedByMe = false;

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container();
                        }

                        if (snapshot.hasData) {
                          comments = snapshot.data!.docs.length.toString();
                          isCommentedByMe = snapshot.data!.docs.any((element) => element.get("userID") == FirebaseAuth.instance.currentUser!.uid);
                        }

                        return InkWell(
                          onTap: () {
                            showBarModalBottomSheet(
                              context: context,
                              builder: (context) => PostCommentsView(postID: model.postID),
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: isCommentedByMe
                                    ? Image.asset(
                                        Assets.commentFilled,
                                        color: Colors.blue,
                                      )
                                    : Image.asset(
                                        Assets.comment,
                                      ),
                              ),
                              const SizedBox(width: 10),
                              Text(comments),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.isUpdated
                          ? "updated".tr() + " • " + TimeAgo.timeAgoSinceDate(model.publishedAt)
                          : TimeAgo.timeAgoSinceDate(model.publishedAt),
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: ServicePath.userSavedPostsCollectionReference(FirebaseAuth.instance.currentUser!.uid)
                            .where('postID', isEqualTo: model.postID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          bool isSaved = false;

                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              isSaved = true;
                            }
                          }

                          return IconButton(
                            onPressed: onSavePressed,
                            icon: SizedBox(
                              width: 20,
                              child: isSaved
                                  ? Image.asset(
                                      Assets.savePostsFilled,
                                      color: Colors.orange,
                                    )
                                  : Image.asset(
                                      Assets.savePosts,
                                    ),
                            ),
                          );
                        }),
                  ],
                ),
              )
            ],
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

class _ImagesLayout extends StatelessWidget {
  const _ImagesLayout({Key? key, required this.model, required this.onLikePressed, required this.onCommentPressed, required this.onDelete})
      : super(key: key);
  final PostUiModel model;
  final void Function() onLikePressed;
  final void Function() onCommentPressed;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: model.images.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.extent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(
            model.images.length < 3 ? model.images.length : 3,
            (index) {
              return _ImagePlaceHolder(
                model: model,
                onLikePressed: onLikePressed,
                onCommentPressed: onCommentPressed,
                onDelete: onDelete,
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceHolder extends StatelessWidget {
  const _ImagePlaceHolder(
      {Key? key, required this.model, required this.onLikePressed, required this.onCommentPressed, required this.onDelete, required this.index})
      : super(key: key);
  final PostUiModel model;
  final void Function() onLikePressed;
  final void Function() onCommentPressed;
  final void Function() onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailsView(
              model: model,
              index: index,
              onLikePressed: onLikePressed,
              onCommentPressed: onCommentPressed,
              onDelete: onDelete,
            ),
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: model.images[index].toString(),
              child: Image.network(
                model.images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            visible: index == 2 && model.images.length > 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Center(
                child: Text(
                  "+" + (model.images.length - 3).toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
