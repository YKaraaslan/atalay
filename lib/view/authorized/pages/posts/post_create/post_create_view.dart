import 'package:atalay/core/base/view/base_view.dart';
import 'package:atalay/core/constant/paddings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/base_appbar.dart';

class PostCreateView extends StatelessWidget {
  const PostCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'post_create'.tr(),
        color: Colors.white,
      ),
      onPageBuilder: (context, value) => const _Body(),
      backgroundColor: Colors.white,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: GlobalKey<FormState>(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(border: InputBorder.none, hintText: "post_create_hint_text".tr()),
                maxLines: 15,
                maxLength: 500,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => true,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.new_label_outlined, color: Colors.grey.shade500),
                      const SizedBox(width: 5),
                      Text('add_label'.tr()),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => true,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.photo_library_outlined, color: Colors.grey.shade500),
                      const SizedBox(width: 5),
                      Text('add_image'.tr()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
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
                  children: [
                    Chip(
                      label: const Text('Yazilim'),
                      backgroundColor: Colors.blue.shade100,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      deleteIcon: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black54,
                        child:  Icon(Icons.close_rounded, size: 13,),
                      ),
                      onDeleted: () {},
                      elevation: 2,
                    ),
                    Chip(
                      label: const Text('Gomulu Sistemler'),
                      backgroundColor: Colors.blue.shade100,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      deleteIcon: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black54,
                        child:  Icon(Icons.close_rounded, size: 13,),
                      ),
                      onDeleted: () {},
                      elevation: 2,
                    ),
                    Chip(
                      label: const Text('Elektronik'),
                      backgroundColor: Colors.blue.shade100,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      deleteIcon: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black54,
                        child:  Icon(Icons.close_rounded, size: 13,),
                      ),
                      onDeleted: () {},
                      elevation: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: AppPaddings.appPadding,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(6, (index) {
                if (index == 5) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Icon(Icons.add, color: Colors.grey.shade500),
                  );
                }
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        onTap: () => true,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.black54.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
