import '../../../../../core/base/view/base_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constant/assets.dart';
import '../../../../../core/widgets/base_bottom_sheet.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return BaseView(
      onPageBuilder: (context, value) => _Body(index: index),
      backgroundColor: Colors.black,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    animation = animationController.drive(Tween<double>(begin: 1, end: 3));
    animationController.duration = const Duration(milliseconds: 1);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      slidePageBackgroundHandler: (offset, size) => defaultSlidePageBackgroundHandler(color: Colors.transparent),
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: 'image${widget.index}',
                child: ExtendedImage.network(
                  'https://cdn.pixabay.com/photo/2017/02/08/17/24/fantasy-2049567__480.jpg',
                  fit: BoxFit.fill,
                  cache: true,
                  mode: ExtendedImageMode.gesture,
                  enableSlideOutPage: true,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 1.0,
                      animationMinScale: 0.9,
                      maxScale: 5.0,
                      animationMaxScale: 5.5,
                      speed: 1.0,
                      inertialSpeed: 100.0,
                      initialScale: 1.0,
                      inPageView: false,
                      initialAlignment: InitialAlignment.center,
                    );
                  },
                  onDoubleTap: (ExtendedImageGestureState state) {
                    var pointerDownPosition = state.pointerDownPosition;
                    double? begin = state.gestureDetails!.totalScale;
                    double end = 1.0;
                    if (state.gestureDetails!.totalScale == 1.0) {
                      end = 3.0;
                    }
                    dynamic Function() animationListener;
                    animationListener = () {
                      state.handleDoubleTap(
                          scale: animation.value,
                          doubleTapPosition: pointerDownPosition);
                    };
                    animation.removeListener(animationListener);
                    animationController.stop();
                    animationController.reset();
                    animation = animationController
                        .drive(Tween<double>(begin: begin, end: end));
                    animationController.addListener(animationListener);
                    animationController.forward();
                  },
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/34814190?v=4'),
                  ),
                  title: const Text(
                    'Yunus Karaaslan',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Yazilim Muhendisi',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: SizedBox(
                      width: 15,
                      child: Image.asset(
                        Assets.postMenu,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const BaseBottomSheet();
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: SelectableText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 15,
                                  child: Image.asset(Assets.likeFilled)),
                              const SizedBox(width: 15),
                              const Text(
                                'Yunus Karaaslan ve 15 kisi',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () => true,
                        ),
                      ),
                      TextButton(
                        child: Row(
                          children: [
                            SizedBox(
                                width: 15,
                                child: Image.asset(Assets.groupsComments)),
                            const SizedBox(width: 15),
                            const Text(
                              '4 Yorum',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () => true,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => true,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 15,
                                  child: Image.asset(
                                    Assets.likeEmpty,
                                    color: Colors.white,
                                  )),
                              const Text(
                                'Begen',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => true,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 15,
                                  child: Image.asset(
                                    Assets.comment,
                                    color: Colors.white,
                                  )),
                              const Text(
                                'Yorum Yap',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
