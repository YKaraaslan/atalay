import 'package:atalay/core/base/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/main.dart';

class BasePhotoViewer extends StatelessWidget {
  const BasePhotoViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => const _Body(),
      backgroundColor: Colors.black,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageURL = ModalRoute.of(context)!.settings.arguments as String;
    return Center(
      child: NetworkImageViewer(
        heroAttribute: 'photo',
        imageURL: imageURL,
      )
    );
  }
}