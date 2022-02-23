import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_textformfield.dart';
import '../unauthorized_baseview.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UnauthorizedBaseView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BaseTextFormField(
              hint: 'name'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              prefixIcon: const Icon(Icons.all_inclusive),
              fun: (value) {
               if (value == null || value.isEmpty) {
                  return 'name_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            BaseTextFormField(
              hint: 'surname'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              prefixIcon: const Icon(Icons.tune_sharp),
              fun: (value) {
               if (value == null || value.isEmpty) {
                  return 'surname_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            BaseTextFormField(
              hint: 'phone'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_android),
              fun: (value) {
               if (value == null || value.isEmpty) {
                  return 'phone_validator'.tr();
                } else if (value.length != 11) {
                  return 'phone_length_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            BaseTextFormField(
              hint: 'username'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.account_circle_sharp),
              fun: (value) {
               if (value == null || value.isEmpty) {
                  return 'login_username_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            BaseTextFormField(
              hint: 'password'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.password),
              fun: (value) {
               if (value == null || value.isEmpty) {
                  return 'password_validator'.tr();
                }
                return null;
              },
              isPassword: true,
            ),
            const SizedBox(height: 10),
            BaseTextFormField(
              hint: 'password_repeat'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.repeat),
              fun: (value) {
               if (value == null || value.isEmpty) {
                  return 'password_validator'.tr();
                }
                return null;
              },
              isPassword: true,
            ),
            const SizedBox(height: 10),
            BaseButton(
              text: 'sign_up'.tr(),
              fun: () {
                _formKey.currentState!.validate();
              },
            ),
          ],
        ),
      ),
    );
  }
}
