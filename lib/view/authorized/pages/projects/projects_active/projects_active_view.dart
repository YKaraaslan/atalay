import 'package:flutter/material.dart';

import '../../../../../core/widgets/project_card.dart';

class ProjectsActive extends StatelessWidget {
  const ProjectsActive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ProjectsCard(
          title: 'App Animation',
          subTitle: 'Today, created by Yunus Karaaslan',
          percentage: (10 * index).toInt(),
          photos: const [
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
          dateStart: '20 Ocak 2022',
          dateEnd: ' 13 Mart 2022'),
    );
  }
}
