import 'package:flutter/widgets.dart';

import '../../../../core/service/service_path.dart';

class GroupsViewModel extends ChangeNotifier {
  Future getImageLinks(List people) async {
    List<String> imageURLs = [];

    await ServicePath.usersCollectionReference.get().then(
      (value) {
        for (var item in value.docs) {
          if (people.any((element) => element == item.get('id'))) {
            imageURLs.add(item.get('imageURL'));
          }
        }
      },
    );

    return imageURLs;
  }
}
