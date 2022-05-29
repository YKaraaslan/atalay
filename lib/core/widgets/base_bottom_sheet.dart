import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../view/authorized/pages/posts/post_update/post_update_view.dart';
import '../../view/authorized/pages/posts/posts_ui_model.dart';
import '../constant/assets.dart';

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
      child: _Column(model: model, onDelete: onDelete),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({
    Key? key,
    required this.model,
    required this.onDelete,
  }) : super(key: key);

  final PostUiModel model;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _DragArea(),
        _Item(
          model: model,
          leading: Assets.edit,
          title: 'edit'.tr(),
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
        _Item(
          model: model,
          leading: Assets.delete,
          title: 'delete'.tr(),
          onTap: () {
            Navigator.pop(context);
            onDelete();
          },
        ),
      ],
    );
  }
}

class _DragArea extends StatelessWidget {
  const _DragArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.minimize,
        color: Colors.blue[200],
        size: 25,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.model,
    required this.leading,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final PostUiModel model;
  final String leading;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        leading,
        width: 25,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
