import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/widgets/base_appbar.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'notifications'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _NewNotificationNotifier(),
        const _NewNotifications(),
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) => const Divider(), childCount: 1),
        ),
        const _OldNotifications(),
      ],
    );
  }
}

class _OldNotifications extends StatelessWidget {
  const _OldNotifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      Assets.notificationBell,
                      scale: 1.7,
                    ),
                    title: const Text('Adiniza bir gorev olusturuldu'),
                    subtitle: const Text('App UI gelistirmeleri yapilacak'),
                    trailing: IconButton(
                      onPressed: () => true,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
          childCount: 1),
    );
  }
}

class _NewNotifications extends StatelessWidget {
  const _NewNotifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      Assets.notificationBell,
                      scale: 1.7,
                    ),
                    title: const Text('Adiniza bir gorev olusturuldu'),
                    subtitle: const Text('App UI gelistirmeleri yapilacak'),
                    trailing: const Icon(Icons.chevron_right),
                  );
                },
              ),
          childCount: 1),
    );
  }
}

class _NewNotificationNotifier extends StatelessWidget {
  const _NewNotificationNotifier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => Container(
                width: double.infinity,
                color: Colors.blue.shade200.withOpacity(0.5),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '2 yeni bildiriminiz mevcut',
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                  ),
                ),
              ),
          childCount: 1),
    );
  }
}
