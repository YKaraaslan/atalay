import 'package:atalay/core/base/view/base_view.dart';
import 'package:base_dialog/main.dart';
import 'package:flutter/material.dart';

class TrainingView extends StatelessWidget {
  const TrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        child: const Text("TIKLA"),
        onPressed: () async {
          var a = BaseDialog();
          a.showLoadingDialog(context);
          await Future.delayed(const Duration(seconds: 2), () {
            a.dismissDialog();
          });
        },
      ),
    );
  }
}
