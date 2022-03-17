import 'package:flutter/material.dart';
import 'package:image_viewer/main.dart';

class NetworkGalleryViewer extends StatefulWidget {
  const NetworkGalleryViewer({Key? key, required this.index, required this.imageList}) : super(key: key);
  final int index;
  final List<String> imageList;

  @override
  State<NetworkGalleryViewer> createState() => _NetworkGalleryViewerState();
}

class _NetworkGalleryViewerState extends State<NetworkGalleryViewer> {
  late final PageController pageController = PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: widget.imageList.length,
      itemBuilder: (context, index) {
        return NetworkImageViewer(heroAttribute: widget.imageList[index], imageURL: widget.imageList[index]);
      },
    );
  }
}
