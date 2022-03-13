import 'dart:io';

import 'signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../../../core/service/service_path.dart';


UserCredential? userCredential;

Future<String?> signUpService(TextEditingController mailController,
    TextEditingController passwordController) async {
  try {
    userCredential = await ServicePath.auth.createUserWithEmailAndPassword(
      email: mailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (userCredential!.user != null) {
      return userCredential!.user!.uid;
    }
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

Future<bool> signUpRegisterService(SignUpModel model) async {
  bool result = false;
  await ServicePath.usersCollectionReference
      .doc(model.id)
      .set({
        'id': model.id,
        'name': model.name,
        'surname': model.surname,
        'full_name': '${model.name} ${model.surname}',
        'phone': model.phone,
        'birthday': model.birthday,
        'mail': model.mail,
        'password': model.password,
        'signUpDateTime': model.signUpDateTime,
        'authorization': model.authorization,
        'position': model.position,
        'online': model.online,
        'onlineTime': model.onlineTime,
      })
      .then((value) => result = true)
      .catchError((error) {
        deleteUser();
        return result = false;
      });
  return result;
}

Future<bool> signUpPhotoService(File image, String id) async {
  bool result = true;
  await ServicePath.profilePhotoReference
      .child(id)
      .putFile(image)
      .then((p0) => result = true)
      .catchError((error) {
    deleteUser();
    deleteUserDatabase(id);
    return result = false;
  });
  return result;
}

void deleteUser() {
  if (userCredential != null && userCredential!.user != null) {
    userCredential!.user!.delete();
  }
}

Future deleteUserDatabase(String id) async {
  await ServicePath.usersCollectionReference.doc(id).delete();
}
