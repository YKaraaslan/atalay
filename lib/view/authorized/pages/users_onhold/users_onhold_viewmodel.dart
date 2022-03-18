import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/models/users_onhold_model.dart';
import '../../../../core/service/service_path.dart';

class UsersOnHoldViewModel extends ChangeNotifier {
  final CollectionReference<UsersOnHoldModel> usersOnHoldCollection = ServicePath.usersOnHoldCollectionReference.withConverter<UsersOnHoldModel>(
     fromFirestore: (snapshot, _) => UsersOnHoldModel.fromJson(snapshot.data()!),
     toFirestore: (movie, _) => movie.toJson(),
   );
}