import 'package:atalay/core/constant/assets.dart';
import 'package:atalay/core/constant/colors.dart';
import 'package:flutter/material.dart';

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
              const Text(
                'Internet baglantisi bulunamadi.\nBaglantinizi kontrol ediniz.',
                style: TextStyle(
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
