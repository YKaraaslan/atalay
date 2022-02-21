import 'package:atalay/core/base/view/base_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}