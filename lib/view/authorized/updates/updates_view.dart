import 'package:flutter/material.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/paddings.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'v1.0.1 Güncellemesi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Güncelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
