import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_viewer/main.dart';

class FileGalleryViewer extends StatefulWidget {
  const FileGalleryViewer({Key? key, required this.index, required this.imageList}) : super(key: key);
  final int index;
  final List<File> imageList;

  @override
  State<FileGalleryViewer> createState() => _FileGalleryViewerState();
}

class _FileGalleryViewerState extends State<FileGalleryViewer> {
  late final PageController pageController = PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: widget.imageList.length,
      itemBuilder: (context, index) {
        return FileImageViewer(heroAttribute: widget.imageList[index].toString(), imagePath: widget.imageList[index]);
      },
    );
  }
}
