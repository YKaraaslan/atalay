import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/widgets/base_appbar.dart';

class FinanceView extends StatelessWidget {
  const FinanceView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'finance'.tr(),
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            'Kullanilabilir Bakiye',
            style: cardTitleStyle(),
          ),
          const SizedBox(height: 10),
          const Text(
            '2,123.45 ₺',
            style: financeTitleStyle,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green.shade200,
                      ),
                      padding: AppPaddings.appPadding,
                      child: const Icon(Icons.add_shopping_cart),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text('Para Ekle')
                ],
              ),
              const SizedBox(width: 100),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.red.shade200,
                    ),
                    padding: AppPaddings.appPadding,
                    child: const Icon(Icons.exposure_minus_1),
                  ),
                  const SizedBox(height: 7),
                  const Text('Para Cikar')
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 10,
            color: Colors.grey.shade300,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              height: 1,
            ),
            itemCount: 15,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index % 2 == 0) {
                return const ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.move_down_rounded,
                        color: Colors.white,
                      )),
                  title: Text('- 128.00 ₺'),
                  subtitle: Text('Roket icin alim yapildi\n10.03.2022 14:30'),
                  isThreeLine: true,
                );
              } else {
                return const ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.move_up,
                        color: Colors.white,
                      )),
                  title: Text('+ 453.21 ₺'),
                  subtitle: Text(
                      'ABC Referansindan sponsorluk alindi\n10.03.2022 12:21'),
                  isThreeLine: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
