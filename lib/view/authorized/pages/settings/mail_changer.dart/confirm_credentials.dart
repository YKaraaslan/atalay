import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_textformfield.dart';
import '../../../../unauthorized/login/login_model.dart';
import 'mail_changer.dart';

class ConfirmCredentials extends StatelessWidget {
  const ConfirmCredentials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Mail Adres Değişikliği',
        actions: [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController mailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    mailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    if (formKey.currentState != null) {
      formKey.currentState!.dispose();
    }
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Devam edebilmek için lütfen giriş yapınız.'),
            const SizedBox(height: 30),
            _FormField(formKey: formKey, mailController: mailController, passwordController: passwordController),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({Key? key, required this.formKey, required this.mailController, required this.passwordController}) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController mailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseTextFormField(
            hint: 'Mail',
            controller: mailController,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.mail_outline_outlined),
            fun: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'mail_validator'.tr();
              }
              if (!EmailValidator.validate(value.trim()) || !value.toString().trim().endsWith('.com')) {
                return 'mail_invalid_validator'.tr();
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          BaseTextFormField(
            hint: 'password'.tr(),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
            prefixIcon: const Icon(Icons.password_outlined),
            isPassword: true,
            controller: passwordController,
            fun: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'password_validator'.tr();
              } else if (value.length < 8) {
                return 'password_length_validator'.tr();
              }
              return null;
            },
          ),
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: OutlinedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                if (ServicePath.auth.currentUser!.email != mailController.text.trim()) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Mail adresi hesabınızla bağlantılı değildir. Lütfen kendi mail adresinizi yazdığınızdan emin olunuz'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'))
                        ],
                      );
                    },
                  );
                  return;
                }
                String signInResult = await loginService(LoginModel(mail: mailController.text.trim(), password: passwordController.text.trim()));
                if (signInResult == 'true') {
                  await ServicePath.auth.signInWithEmailAndPassword(email: mailController.text.trim(), password: passwordController.text.trim());
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MailChanger(),
                    ),
                  );
                } else if (signInResult == 'user-not-found') {
                  return showSnackbar(context, 'login_user_not_found'.tr());
                } else if (signInResult == 'wrong-password') {
                  return showSnackbar(context, 'login_wrong_password'.tr());
                } else {
                  return showSnackbar(context, 'login_failed'.tr());
                }
              },
              child: const Text('Devam Et'),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> loginService(LoginModel model) async {
    try {
      await ServicePath.auth.signInWithEmailAndPassword(email: model.mail, password: model.password);
      return 'true';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      } else if (e.code == 'wrong-password') {
        return 'wrong-password';
      } else {
        return 'false';
      }
    }
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: 'OK', onPressed: () => true),
      ),
    );
  }
}
