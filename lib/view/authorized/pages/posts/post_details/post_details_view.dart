import 'package:atalay/view/authorized/pages/posts/post_details/post_details_viewmodel.dart';
import 'package:atalay/view/authorized/pages/posts/posts_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_viewer/main.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/widgets/base_bottom_sheet.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({Key? key, required this.model, required this.index}) : super(key: key);
  final PostUiModel model;
  final int index;

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
      onPageBuilder: (context, value) => _Body(model: widget.model, index: widget.index),
      backgroundColor: Colors.black,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model, required this.index}) : super(key: key);
  final PostUiModel model;
  final int index;

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
              Navigator.of(context).pushNamed(
                Routes.profile,
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Row(
                        children: [
                          SizedBox(width: 15, child: Image.asset(Assets.likeFilled)),
                          const SizedBox(width: 15),
                          Text(
                            "${widget.model.likes.toString()} ${'likes_received'.tr()}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          Routes.postLikes,
                        );
                      },
                    ),
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        SizedBox(width: 15, child: Image.asset(Assets.groupsComments)),
                        const SizedBox(width: 15),
                         Text(
                            "${widget.model.comments.toString()} ${'comments_received'.tr()}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Routes.postComments,
                        arguments: 1,
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
                      onPressed: () => true,
                      child: Column(
                        children: [
                          SizedBox(
                              width: 15,
                              child: Image.asset(
                                Assets.likeEmpty,
                                color: Colors.white,
                              )),
                           Text(
                            'like'.tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          Routes.postComments,
                          arguments: 1,
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                              width: 15,
                              child: Image.asset(
                                Assets.comment,
                                color: Colors.white,
                              )),
                           Text('comment'.tr(),
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
