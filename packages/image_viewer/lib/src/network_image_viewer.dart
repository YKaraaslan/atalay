import 'package:flutter/material.dart';

import 'base_view.dart';

class NetworkImageViewer extends StatelessWidget {
  const NetworkImageViewer(
      {Key? key, required this.heroAttribute, required this.imageURL})
      : super(key: key);
  final String heroAttribute;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      heroAttribute: heroAttribute,
      child: Image.network(
        imageURL,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
