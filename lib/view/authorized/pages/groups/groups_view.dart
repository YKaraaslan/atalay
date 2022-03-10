import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/paddings.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/widgets/base_appbar.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({Key? key, required this.zoomDrawerController})
      : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'groups'.tr(),
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        100,
        (index) {
          return Padding(
            padding: AppPaddings.cardContentPadding,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.groupsDetails);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: AppPaddings.appPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Grup $index',
                        style: cardTitleStyle(),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Grup bilgisi $index',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 20),
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
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Expanded(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('10 katilimci')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
