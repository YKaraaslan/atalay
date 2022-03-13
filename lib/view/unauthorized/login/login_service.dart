import 'login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/service/service_path.dart';

Future<dynamic> loginService(LoginModel model) async {
  try {
    await ServicePath.auth
        .signInWithEmailAndPassword(email: model.userName, password: model.password);
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
