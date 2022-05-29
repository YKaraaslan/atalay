import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_textformfield.dart';

class MailChanger extends StatelessWidget {
  const MailChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Yeni Mail Adresi',
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

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    mailController = TextEditingController();
  }

  @override
  void dispose() {
    if (formKey.currentState != null) {
      formKey.currentState!.dispose();
    }
    mailController.dispose();
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
            const SizedBox(height: 30),
            _MailField(formKey: formKey, mailController: mailController),
          ],
        ),
      ),
    );
  }
}

class _MailField extends StatelessWidget {
  const _MailField({Key? key, required this.formKey, required this.mailController}) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController mailController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseTextFormField(
            hint: 'Yeni Mail Adresi',
            controller: mailController,
            textInputAction: TextInputAction.done,
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
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: OutlinedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('${mailController.text.trim()}\n\nOnaylıyor musunuz?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('İptal'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await ServicePath.auth.currentUser!.updateEmail(mailController.text.trim());
                            } catch (e) {
                              Navigator.pop(context);
                              showSnackbar(context, 'Bu mail adresi kullanılmaktadır.');
                              return;
                            }
                            Navigator.pop(context);
                            showSnackbar(context, 'Mail adresiniz güncellendi');
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Onayla'),
            ),
          ),
        ],
      ),
    );
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
