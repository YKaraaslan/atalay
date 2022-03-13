import 'dart:io';

import 'package:atalay/view/unauthorized/signup/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../../../core/service/service_path.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<String?> signUpService(TextEditingController mailController,
    TextEditingController passwordController) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: mailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (userCredential.user != null) {
      return userCredential.user!.uid;
    }
    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'weak-password';
    } else if (e.code == 'email-already-in-use') {
      return 'email-already-in-use';
    }
    else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future signUpRegisterService(SignUpModel model) async {
  await ServicePath.usersCollectionReference.doc(model.id).set({
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
  });
}

Future signUpPhotoService(File image, String id, double progressValue) async {}
