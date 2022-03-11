import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController? zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'profile'.tr(),
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.photo_camera),
                ),
                SizedBox(width: 25),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/34814190?v=4'),
                ),
                SizedBox(width: 25),
                CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.settings),
                ),
              ],
            ),
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                  text: 'Yunus Karaaslan',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: '   |   ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    TextSpan(
                      text: 'Yazilim Muhendisi',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ]),
            ),
            const SizedBox(height: 10),
            const Text(
              'Atalay Roket Takimi Yazilim Departmani Sorumlusu',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '15',
                      style: cardTitleStyle(),
                    ),
                    const Text('Gonderi'),
                  ],
                ),
                const SizedBox(width: 20),
                const VerticalDivider(),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '10',
                      style: cardTitleStyle(),
                    ),
                    const Text('Toplanti'),
                  ],
                ),
                const SizedBox(width: 20),
                const VerticalDivider(),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '7',
                      style: cardTitleStyle(),
                    ),
                    const Text('Gorev'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hakkimda',
                    style: cardTitleStyle(),
                  ),
                  const SizedBox(height: 10),
                   Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Ilgi Alanlarim',
                    style: cardTitleStyle(),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    children: const [
                       Chip(
                        label: Text(
                          'Yazilim',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                       Chip(
                        label: Text(
                          'Elektronik',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                       Chip(
                        label: Text(
                          'Yapay Zeka',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                       Chip(
                        label: Text(
                          'Mobil',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                       Chip(
                        label: Text(
                          'Flutter',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                       Chip(
                        label: Text(
                          'Web Gelistirme',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                       Chip(
                        label: Text(
                          'Tasarim',
                        ), //Text
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
