import 'package:atalay/core/classes/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/models/announcement_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/theme/dark_theme_provider.dart';
import '../../../../core/widgets/base_appbar.dart';
import '../../../../core/widgets/weekly_days.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'dashboard'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final DashboardViewModel _viewModel = context.read<DashboardViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.announcementController = TextEditingController();
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.announcementController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: AppPaddings.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WeeklyDays(),
            const SizedBox(height: 20),
            const _Announcement(),
            const SizedBox(height: 10),
            Text(
              'Proje Durumu',
              style: cardTitleStyle(),
            ),
            const SizedBox(height: 10),
            const _ProjectsStatus(),
            const SizedBox(height: 30),
            Text(
              'Görevlerim',
              style: cardTitleStyle(),
            ),
            const SizedBox(height: 10),
            const _MyDuties(),
          ],
        ),
      ),
    );
  }
}

class _MyDuties extends StatelessWidget {
  const _MyDuties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: ListTile(
                  title: Text('Dashboard Design'),
                  subtitle: LinearProgressIndicator(value: 0.5),
                ),
              ),
              const SizedBox(width: 20),
              const CircleAvatar(
                radius: 15,
                backgroundImage:
                    NetworkImage('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
              ),
              const SizedBox(width: 5),
              const CircleAvatar(
                radius: 15,
                backgroundImage:
                    NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
              ),
              const SizedBox(width: 5),
              const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage('https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg'),
              ),
              const SizedBox(width: 10),
              IconButton(onPressed: () => true, icon: const Icon(Icons.chevron_right))
            ],
          ),
        );
      },
    );
  }
}

class _Announcement extends StatelessWidget {
  const _Announcement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: ServicePath.announcementCollectionReference.orderBy('createdAt', descending: true).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          AnnouncementModel model = AnnouncementModel.fromJson(snapshot.data!.docs.first.data() as Map<String, Object?>);
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: AppPaddings.appPadding,
                decoration: BoxDecoration(
                    color: context.read<DarkThemeProvider>().darkTheme ? Theme.of(context).cardColor : const Color.fromARGB(255, 213, 231, 247), borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Duyuru',
                          style: cardTitleStyle(),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(Assets.megaphone, width: 20),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(model.text),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: ServicePath.usersCollectionReference.doc(model.createdBy).get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserModel userModel = UserModel.fromJson(snapshot.data!.data() as Map<String, Object?>);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(userModel.imageURL),
                                radius: 10,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                userModel.fullName,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(width: 10),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: context.read<AuthProvider>().announcementsCreate,
                child: Consumer(
                  builder: (context, DashboardViewModel viewmodel, child) => Align(
                    alignment: Alignment.topRight,
                    child: OutlinedButton(
                      onPressed: () => viewmodel.addAnnouncement(context),
                      child: const Text('Duyuru Ekle'),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class _ProjectsStatus extends StatelessWidget {
  const _ProjectsStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: ServicePath.projectsCollectionReference.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int total = snapshot.data!.docs.length;
          int active = snapshot.data!.docs.where((element) => element.get('status') == 'active').length;
          int finished = snapshot.data!.docs.where((element) => element.get('status') == 'finished').length;

          return Row(
            children: [
              Stack(
                children: [
                  CircularStepProgressIndicator(
                    width: Sizes.width_40percent(context),
                    height: Sizes.width_40percent(context),
                    totalSteps: 100,
                    currentStep: total > 0 ? 100 : 0,
                    stepSize: 10,
                    selectedColor: Colors.orange,
                    padding: 0,
                    selectedStepSize: 15,
                    roundedCap: (_, __) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$total',
                          style: defaultDateTextStyle(context),
                        ),
                        const Text('Toplam Proje'),
                      ],
                    ),
                  ),
                  CircularStepProgressIndicator(
                    width: Sizes.width_40percent(context),
                    height: Sizes.width_40percent(context),
                    totalSteps: 100,
                    currentStep: 100 * active ~/ total,
                    stepSize: 0,
                    selectedColor: Colors.blue[700],
                    unselectedColor: Colors.transparent,
                    padding: 0,
                    selectedStepSize: 15,
                    roundedCap: (_, __) => true,
                  ),
                  CircularStepProgressIndicator(
                    width: Sizes.width_40percent(context),
                    height: Sizes.width_40percent(context),
                    totalSteps: 100,
                    currentStep: 100 * finished ~/ total,
                    stepSize: 0,
                    selectedColor: Colors.yellow[600],
                    unselectedColor: Colors.transparent,
                    padding: 0,
                    selectedStepSize: 15,
                    roundedCap: (_, __) => true,
                  ),
                ],
              ),
              const SizedBox(width: 35),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: const CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$total',
                              style: defaultDateTextStyle(context),
                            ),
                            Text(
                              'Toplam Proje',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.blue[700],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$active',
                              style: defaultDateTextStyle(context),
                            ),
                            Text(
                              'Aktif Proje',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 6),
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.yellow[600],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$finished',
                              style: defaultDateTextStyle(context),
                            ),
                            Text(
                              'Biten Proje',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
