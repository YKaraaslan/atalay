import 'package:atalay/core/base/view/base_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
