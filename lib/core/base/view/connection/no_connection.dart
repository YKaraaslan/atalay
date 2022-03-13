import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constant/assets.dart';
import '../../../constant/colors.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Assets.noConnectionBackground,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                Assets.noConnection,
                color: Colors.white,
                scale: 4,
              )),
              const SizedBox(height: 15),
              Text(
                'no_connection_found'.tr(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
