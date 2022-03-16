import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/service/service_path.dart';

Future<dynamic> loginService(LoginModel model) async {
  try {
    await ServicePath.auth.signInWithEmailAndPassword(
        email: model.mail, password: model.password);
    return "true";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'user-not-found';
    } else if (e.code == 'wrong-password') {
      return 'wrong-password';
    } else {
      return "false";
    }
  }
}

Future<bool> updatePasswordandToken(LoginModel model) async {
  try {
    await ServicePath.usersCollectionReference
        .where('mail', isEqualTo: model.mail)
        .get()
        .then((value) {
      DocumentReference<Object?> docRef = ServicePath.usersCollectionReference.doc(value.docs.first.id);
          docRef.update({'password': model.password});
          docRef.update({'token': getToken()});
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<String> checkIfUser(LoginModel model) async {
  String result = "not_found";
  try {
    await ServicePath.usersOnHoldCollectionReference
        .where('mail', isEqualTo: model.mail)
        .get()
        .then((value) {
      if (value.docs.first.exists) {
        result = "exists";
      }
    });
  } catch (e) {
    return result;
  }

  return result;
}

Future getToken() async {
  String token = "";
  await FirebaseMessaging.instance.getToken().then((value) {
    token = value ?? "";
    return token;
  });
  
  return token;
}
