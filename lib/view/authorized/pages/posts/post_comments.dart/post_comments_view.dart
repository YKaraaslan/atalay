import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/widgets/base_posts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/post_comment_item.dart';

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'posts'.tr(),
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
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BasePost(index: index),
              Padding(
                padding: AppPaddings.appPadding,
                child: Text('comments'.tr() + ' (4)'),
              ),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const PostCommentItem();
                },
              ),
              const SizedBox(height: 104),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.transparent,
            padding: AppPaddings.appPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Material(
                    elevation: 4,
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Yorum yaz...',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                        ),
                        maxLines: 5,
                        minLines: 1,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () => true,
                  child: const Icon(Icons.send),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
