import '../../../../../core/constant/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/widgets/base_appbar.dart';

class PostLikeView extends StatelessWidget {
  const PostLikeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'likes'.tr(),
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.profile);
          },
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/34814190?v=4'),
            ),
            title: const Text('Yunus Karaaslan'),
            subtitle: const Text('2 saat once'),
            trailing: IconButton(
              onPressed: () => true,
              icon: Image.asset(Assets.likeFilled),
            ),
          ),
        );
      },
    );
  }
}
