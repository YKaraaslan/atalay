import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/constant/routes.dart';
import '../../../../../../core/constant/sizes.dart';
import '../../../../../../core/widgets/base_appbar.dart';

class ProjectDetailsView extends StatelessWidget {
  const ProjectDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'App Animation',
        actions: [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      backgroundColor: Colors.white,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Today, Created by ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(
                      text: 'Yunus Karaaslan',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 35),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircularStepProgressIndicator(
                  width: Sizes.width_30percent(context),
                  height: Sizes.width_30percent(context),
                  totalSteps: 100,
                  currentStep: 75,
                  stepSize: 7,
                  selectedColor: Colors.greenAccent,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  selectedStepSize: 10,
                  roundedCap: (_, __) => true,
                  child: Center(
                    child: Text(
                      '%75',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.projectTeam);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('team'.tr(),
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    'https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    'https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg'),
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8&w=1000&q=80'),
                              ),
                              SizedBox(width: 5),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                    const Text('Deadline'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                        Text('20 Ocak 2022 - 13 Mart 2022',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 13)),
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              'Project',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 35),
            const Text(
              'Project Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: true,
              onChanged: (value) => false,
              title: const Text(
                'Kullanici arayuzu olusturulacak',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: true,
              onChanged: (value) => false,
              title: const Text(
                'Tanitim yapilacak',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: true,
              onChanged: (value) => false,
              title: const Text(
                'Dagitim yapilacak',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: false,
              onChanged: (value) => false,
              title: const Text('Geri bildirimler incelenecek'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }
}
