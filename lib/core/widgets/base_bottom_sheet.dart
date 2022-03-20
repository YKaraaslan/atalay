import '../constant/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/pages/posts/post_update/post_update_view.dart';
import '../../view/authorized/pages/posts/posts_ui_model.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({Key? key, required this.model, required this.onDelete}) : super(key: key);
  final PostUiModel model;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.minimize,
              color: Colors.blue[200],
              size: 25,
            ),
          ),
          ListTile(
            leading: Image.asset(
              Assets.edit,
              width: 25,
            ),
            title: Text('edit'.tr()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostUpdateView(model: model),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              Assets.delete,
              width: 25,
            ),
            title: Text('delete'.tr()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
