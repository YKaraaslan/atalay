import 'package:flutter/material.dart';

import 'core/base/view/base_view.dart';

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
    return Column(
      children: [
        const _Header(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: const [],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
