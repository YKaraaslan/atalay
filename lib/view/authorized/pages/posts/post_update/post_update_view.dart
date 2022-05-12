import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/constant/sizes.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../../../../core/widgets/base_button.dart';
import '../../../../../../core/widgets/file_gallery_view.dart';
import '../posts_ui_model.dart';
import 'post_update_viewmodel.dart';

class PostUpdateView extends StatelessWidget {
  const PostUpdateView({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'post_update'.tr(),
        color: Colors.white,
        actions: const [],
      ),
      onPageBuilder: (context, value) => _Body(model: model),
      backgroundColor: Colors.white,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final PostUiModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final PostUpdateViewModel _viewModel = context.read<PostUpdateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
    _viewModel.labelTextController = TextEditingController();
    _viewModel.postController = TextEditingController();
    _viewModel.labels = [];
    _viewModel.images = [];
    _viewModel.imagesLink = [];
    _viewModel.model = widget.model;

    Future.delayed(const Duration(microseconds: 1), () {
      _viewModel.setData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.labelTextController.dispose();
    _viewModel.postController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _viewModel.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _viewModel.postController,
                decoration: InputDecoration(border: InputBorder.none, hintText: 'post_create_hint_text'.tr()),
                maxLines: 15,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'post_create_validator'.tr();
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => _viewModel.addLabel(context),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.new_label_outlined, color: Colors.grey.shade500),
                      const SizedBox(width: 5),
                      Text('add_label'.tr()),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _viewModel.getSelection(context);
                },
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(Icons.photo_library_outlined, color: Colors.grey.shade500),
                      const SizedBox(width: 5),
                      Text('add_image'.tr()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 5,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Consumer(
                  builder: (context, PostUpdateViewModel viewModel, child) => Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(
                      viewModel.labels.length,
                      (index) => Chip(
                        label: Text(viewModel.labels[index]),
                        backgroundColor: Colors.blue.shade100,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        deleteIcon: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close_rounded,
                            size: 13,
                          ),
                        ),
                        onDeleted: () {
                          viewModel.onDeletedMethod(index);
                        },
                        elevation: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer(
            builder: (context, PostUpdateViewModel viewModel, child) => Padding(
              padding: AppPaddings.appPadding,
              child: Visibility(
                visible: viewModel.images.isNotEmpty || viewModel.imagesLink.isNotEmpty,
                child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    viewModel.images.length + viewModel.imagesLink.length,
                    (index) {
                      if ((viewModel.images.isEmpty && viewModel.imagesLink.isEmpty) || index == viewModel.maxAllowedImage) {
                        return Container();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FileGalleryViewer(
                                imageList: viewModel.images,
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: index.toString(),
                                child: index >= viewModel.imagesLink.length
                                    ? Image.file(
                                        viewModel.images[index - viewModel.imagesLink.length],
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        viewModel.imagesLink[index],
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                onTap: () {
                                  viewModel.deleteImage(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.black54.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, size: 13, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Sizes.width_65percent(context),
              child: BaseButton(
                text: 'post_update'.tr(),
                fun: () {
                  if (_viewModel.formKey.currentState!.validate()) {
                    _viewModel.updatePost(context);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
