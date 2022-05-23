import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:image_viewer/main.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key, this.zoomDrawerController, required this.userID}) : super(key: key);

  final ZoomDrawerController? zoomDrawerController;
  final String userID;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'profile'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => _Body(userID: userID),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.userID}) : super(key: key);
  final String userID;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ProfileViewModel _viewModel = context.read<ProfileViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.appPadding,
        child: StreamBuilder<DocumentSnapshot>(
          stream: ServicePath.userDocumentReference(widget.userID).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _ShimmerEffect();
            }

            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _viewModel.getSelection(context);
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.photo_camera),
                        ),
                      ),
                      const SizedBox(width: 25),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NetworkImageViewer(
                                heroAttribute: 'image',
                                imageURL: snapshot.data!.get('imageURL'),
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'image',
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(snapshot.data!.get('imageURL')),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.settings),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(text: snapshot.data!.get('fullName'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), children: [
                      const TextSpan(
                        text: '   |   ',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      TextSpan(
                        text: snapshot.data!.get('position'),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '15',
                              style: cardTitleStyle(),
                            ),
                            const Text('Gonderi'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const VerticalDivider(),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '10',
                              style: cardTitleStyle(),
                            ),
                            const Text('Toplanti'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const VerticalDivider(),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '7',
                              style: cardTitleStyle(),
                            ),
                            const Text('Gorev'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hakkimda',
                          style: cardTitleStyle(),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!.get('aboutMe'),
                          style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Ilgi Alanlarim',
                          style: cardTitleStyle(),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: List.generate(
                            snapshot.data!.get('interests').length,
                            (index) => Chip(
                              label: Text(snapshot.data!.get('interests')[index]),
                              backgroundColor: Colors.blue.shade100,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              elevation: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const _ShimmerEffect();
          },
        ),
      ),
    );
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedShimmer.round(
              size: 50,
            ),
            const SizedBox(width: 25),
            AnimatedShimmer.round(
              size: 75,
            ),
            const SizedBox(width: 25),
            AnimatedShimmer.round(
              size: 50,
            ),
          ],
        ),
        const SizedBox(height: 20),
        const AnimatedShimmer(
          height: 10,
          width: 300,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        const SizedBox(height: 10),
        const AnimatedShimmer(
          height: 10,
          width: 300,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                AnimatedShimmer(
                  height: 10,
                  width: 25,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                SizedBox(height: 5),
                AnimatedShimmer(
                  height: 10,
                  width: 50,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                AnimatedShimmer(
                  height: 10,
                  width: 25,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                SizedBox(height: 5),
                AnimatedShimmer(
                  height: 10,
                  width: 50,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ],
            ),
            const SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                AnimatedShimmer(
                  height: 10,
                  width: 25,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                SizedBox(height: 5),
                AnimatedShimmer(
                  height: 10,
                  width: 50,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AnimatedShimmer(
                height: 10,
                width: 50,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 10),
              AnimatedShimmer(
                height: 10,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 5),
              AnimatedShimmer(
                height: 10,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 5),
              AnimatedShimmer(
                height: 10,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 30),
              AnimatedShimmer(
                height: 10,
                width: 50,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 10),
              SizedBox(height: 5),
              AnimatedShimmer(
                height: 10,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 5),
              AnimatedShimmer(
                height: 10,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 5),
              AnimatedShimmer(
                height: 10,
                width: double.infinity,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
