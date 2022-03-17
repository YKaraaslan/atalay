import 'package:atalay/core/classes/time_ago.dart';
import 'package:atalay/view/authorized/pages/posts/post_details/post_details_view.dart';
import 'package:atalay/view/authorized/pages/posts/posts_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constant/assets.dart';
import '../constant/routes.dart';
import 'base_bottom_sheet.dart';

class BasePost extends StatelessWidget {
  const BasePost({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

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
              leading: CircleAvatar(
                backgroundImage: NetworkImage(model.authorImageURL),
              ),
              title: Text(model.authorNameSurname),
              subtitle: Text(model.authorPosition),
              trailing: IconButton(
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
                      return const BaseBottomSheet();
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: SelectableText(model.text),
          ),
          _ImagesLayout(model: model),
          Visibility(
            visible: model.labels.isNotEmpty,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 5,
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
                          style: const TextStyle(color: Colors.blue),
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
              IconButton(
                onPressed: () {},
                icon: SizedBox(
                  width: 20,
                  child: Image.asset(
                    Assets.likeEmpty,
                    color: Colors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.postLikes);
                },
                child: Text(model.likes.toString()),
              ),
              const SizedBox(width: 25),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.postComments, arguments: 1);
                },
                icon: SizedBox(
                  width: 20,
                  child: Image.asset(
                    Assets.comment,
                  ),
                ),
              ),
              Text(model.comments.toString()),
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
                    IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        width: 20,
                        child: Image.asset(
                          Assets.savePosts,
                        ),
                      ),
                    ),
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
  const _ImagesLayout({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

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
          children: List.generate(model.images.length < 3 ? model.images.length : 3, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailsView(
                      model: model,
                      index: index,
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
          }),
        ),
      ),
    );
  }
}
