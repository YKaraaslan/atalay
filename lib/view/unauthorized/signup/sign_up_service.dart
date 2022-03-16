import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../core/models/users_onhold_model.dart';
import '../../../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/service/service_path.dart';

UserCredential? userCredential;

Future<String?> signUpService(String mail, String password) async {
  try {
    FirebaseApp tempApp = await Firebase.initializeApp(name: 'temporaryRegister', options: DefaultFirebaseOptions.currentPlatform);
    userCredential = await FirebaseAuth.instanceFor(app: tempApp).createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );
    if (userCredential!.user != null) {
      return userCredential!.user!.uid;
    }
    tempApp.delete();
    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'weak-password';
    } else if (e.code == 'email-already-in-use') {
      return 'email-already-in-use';
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<bool> signUpRegisterService(UsersOnHoldModel model) async {
  bool result = false;
  await ServicePath.usersOnHoldCollectionReference.doc(model.id).set(model.toMap()).then((value) => result = true).catchError((error) {
    deleteUser();
    return result = false;
  });
  return result;
}

Future<bool> signUpPhotoService(File image, String id) async {
  bool result = true;
  await ServicePath.profilePhotoReference.child(id).putFile(image).then((p0) => result = true).catchError((error) {
    deleteUser();
    deleteUserDatabase(id);
    return result = false;
  });
  return result;
}

Future<String> signUpPhotoURL(String id) async {
  return await ServicePath.profilePhotoReference.child(id).getDownloadURL();
}

void deleteUser() {
  if (userCredential != null && userCredential!.user != null) {
    userCredential!.user!.delete();
  }
}

Future deleteUserDatabase(String id) async {
  await ServicePath.usersCollectionReference.doc(id).delete();
  await ServicePath.profilePhotoReference.child(id).delete();
}

Future getToken() async {
  String token = "";
  await FirebaseMessaging.instance.getToken().then((value) {
    token = value ?? "";
    return token;
  });
  
  return token;
}
