import '../constant/assets.dart';
import '../constant/routes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'base_bottom_sheet.dart';

class BasePost extends StatelessWidget {
  const BasePost({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34814190?v=4'),
            ),
            title: const Text('Yunus Karaaslan'),
            subtitle: const Text('Yazilim Muhendisi'),
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
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: SelectableText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                Routes.postDetails,
                arguments: index,
              );
            },
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Hero(
                  tag: 'image$index',
                  child: ExtendedImage.network(
                    'https://cdn.pixabay.com/photo/2017/02/08/17/24/fantasy-2049567__480.jpg',
                    fit: BoxFit.fill,
                    cache: true,
                    mode: ExtendedImageMode.gesture,
                    enableSlideOutPage: true,
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
              const Text('12'),
              const SizedBox(width: 25),
              IconButton(
                onPressed: () {},
                icon: SizedBox(
                  width: 20,
                  child: Image.asset(
                    Assets.comment,
                  ),
                ),
              ),
              const Text('4'),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('23 saat',
                        style: TextStyle(color: Colors.grey.shade600)),
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
