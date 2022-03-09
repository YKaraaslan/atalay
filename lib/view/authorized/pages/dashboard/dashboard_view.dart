import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/widgets/base_appbar.dart';
import '../../../../core/widgets/weekly_days.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'dashboard'.tr(),
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

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
            const SizedBox(height: 30),
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
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
              ),
              const SizedBox(width: 5),
              const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
              ),
              const SizedBox(width: 5),
              const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg'),
              ),
              const SizedBox(width: 10),
              IconButton(
                  onPressed: () => true, icon: const Icon(Icons.chevron_right))
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
    return Container(
      width: double.infinity,
      padding: AppPaddings.appPadding,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 213, 231, 247),
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
          const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.')
        ],
      ),
    );
  }
}

class _ProjectsStatus extends StatelessWidget {
  const _ProjectsStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircularStepProgressIndicator(
              width: Sizes.width_40percent(context),
              height: Sizes.width_40percent(context),
              totalSteps: 100,
              currentStep: 100,
              stepSize: 10,
              selectedColor: Colors.orange,
              padding: 0,
              selectedStepSize: 15,
              roundedCap: (_, __) => true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '53',
                    style: defaultDateTextStyle,
                  ),
                  Text('Toplam Proje'),
                ],
              ),
            ),
            CircularStepProgressIndicator(
              width: Sizes.width_40percent(context),
              height: Sizes.width_40percent(context),
              totalSteps: 100,
              currentStep: 65,
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
              currentStep: 35,
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
                      const Text(
                        '14',
                        style: defaultDateTextStyle,
                      ),
                      Text(
                        'Yapildi',
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
                      const Text(
                        '23',
                        style: defaultDateTextStyle,
                      ),
                      Text(
                        'Yapilmakta',
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
                      const Text(
                        '35',
                        style: defaultDateTextStyle,
                      ),
                      Text(
                        'Yapilacak',
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
  }
}
