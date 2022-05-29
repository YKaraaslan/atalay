import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/routes.dart';

class SignUpBottomSheet extends StatelessWidget {
  const SignUpBottomSheet({
    Key? key,
    required this.cameraCallBack,
    required this.galleryCallBack,
    this.imagePath,
    this.isShowPhoto = false,
  }) : super(key: key);

  final VoidCallback cameraCallBack;
  final VoidCallback galleryCallBack;
  final bool isShowPhoto;
  final File? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isShowPhoto ? 190 : 140,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 4,
              width: 30,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Visibility(
                visible: isShowPhoto,
                child: ListTile(
                  leading: Icon(
                    Icons.image_search,
                    color: Colors.blue[300],
                  ),
                  title: Text('show_photo'.tr()),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.signupShowPhoto, arguments: imagePath);
                  },
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: Colors.blue[300],
                ),
                title: Text('camera'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  cameraCallBack();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Colors.blue[300],
                ),
                title: Text('gallery'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  galleryCallBack();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
