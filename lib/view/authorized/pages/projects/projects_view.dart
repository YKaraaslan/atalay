import 'package:atalay/core/widgets/project_card.dart';
import 'package:atalay/view/authorized/pages/projects/projects_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/widgets/base_appbar.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    context.watch<ProjectsViewModel>();
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'projects'.tr(),
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
      child: Consumer(
        builder: (context, ProjectsViewModel viewModel, child) => Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(5),
                backgroundColor: Colors.blue.shade100,
                children: viewModel.tabs,
                groupValue: viewModel.segmentedControlGroupValue,
                onValueChanged: (value) {
                  viewModel.setSegmentedValue(value as int);
                },
              ),
            ),
            const SizedBox(height: 30),
            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const ProjectsCard(
                  title: 'App Animation',
                  subTitle: 'Today, created by Yunus Karaaslan',
                  photos: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
                    ),
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D'),
                    ),
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg'),
                    ),
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8&w=1000&q=80'),
                    ),
                    SizedBox(width: 5),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.add, color: Colors.white,),
                    ),
                  ],
                  dateStart: '20 Ocak 2022',
                  dateEnd: ' 13 Mart 2022'),
            )
          ],
        ),
      ),
    );
  }
}
