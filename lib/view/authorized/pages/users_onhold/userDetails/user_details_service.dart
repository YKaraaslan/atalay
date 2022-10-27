import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/models/users_onhold_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../firebase_options.dart';

Future acceptUserService(UserModel model) async {
  await ServicePath.usersCollectionReference.doc(model.id).set(model.toMap());
  await ServicePath.usersOnHoldCollectionReference.doc(model.id).delete();
}

Future declineUserService(UsersOnHoldModel model) async {
  FirebaseApp tempApp = await Firebase.initializeApp(name: 'temporaryLogin', options: DefaultFirebaseOptions.currentPlatform);
  UserCredential? userCredential = await FirebaseAuth.instanceFor(app: tempApp).signInWithEmailAndPassword(
    email: model.mail,
    password: model.password,
  );
  if (userCredential.user != null) {
    await userCredential.user!.delete();
  }
  await tempApp.delete();
  await ServicePath.usersOnHoldCollectionReference.doc(model.id).delete();
  await ServicePath.profilePhotoReference.child(model.id).delete();
}
