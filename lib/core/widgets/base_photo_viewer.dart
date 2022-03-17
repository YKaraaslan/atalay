import '../base/view/base_view.dart';
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
    List<dynamic> arguments = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    dynamic imageAttribute = arguments[0];
    String heroAttribute = arguments[1];
    String imageType = arguments[2];

    if (imageType == "network") {
      return NetworkImageViewer(
        heroAttribute: heroAttribute,
        imageURL: imageAttribute,
      );
    } else if (imageType == "asset") {
      return AssetImageViewer(
        heroAttribute: heroAttribute,
        imagePath: imageAttribute,
      );
    } else if (imageType == "file") {
      return FileImageViewer(
        heroAttribute: heroAttribute,
        imagePath: imageAttribute,
      );
    } else {
      return Container();
    }
  }
}
