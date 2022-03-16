import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_viewer/main.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/widgets/base_bottom_sheet.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({Key? key}) : super(key: key);

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
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return BaseView(
      onPageBuilder: (context, value) => _Body(index: index),
      backgroundColor: Colors.black,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
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
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/34814190?v=4'),
              ),
              title: const Text(
                'Yunus Karaaslan',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'Yazilim Muhendisi',
                style: TextStyle(color: Colors.grey),
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
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: SelectableText(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
              child: NetworkImageViewer(
            heroAttribute: 'image${widget.index}',
            imageURL:
                'https://cdn.pixabay.com/photo/2017/02/08/17/24/fantasy-2049567__480.jpg',
          )),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Row(
                        children: [
                          SizedBox(
                              width: 15, child: Image.asset(Assets.likeFilled)),
                          const SizedBox(width: 15),
                          const Text(
                            'Yunus Karaaslan ve 15 kisi',
                            style: TextStyle(color: Colors.white),
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
                        SizedBox(
                            width: 15,
                            child: Image.asset(Assets.groupsComments)),
                        const SizedBox(width: 15),
                        const Text(
                          '4 Yorum',
                          style: TextStyle(color: Colors.white),
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
                          const Text(
                            'Begen',
                            style: TextStyle(color: Colors.white),
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
                          const Text(
                            'Yorum Yap',
                            style: TextStyle(color: Colors.white),
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
