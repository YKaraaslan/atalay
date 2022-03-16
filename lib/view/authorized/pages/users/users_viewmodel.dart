import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/service/service_path.dart';

class UsersViewModel extends ChangeNotifier {
  final CollectionReference<UserModel> userCollection = ServicePath.usersCollectionReference.withConverter<UserModel>(
     fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
     toFirestore: (movie, _) => movie.toJson(),
   );
}