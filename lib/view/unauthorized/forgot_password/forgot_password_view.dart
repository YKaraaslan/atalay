import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_textformfield.dart';
import '../unauthorized_baseview.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

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
              prefixIcon: const Icon(Icons.account_circle_sharp),
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
              prefixIcon: const Icon(Icons.tune_sharp),
              fun: (value) {
                if (value == null || value.isEmpty) {
                  return 'phone_validator'.tr();
                } else if (value.length != 11) {
                  return 'phone_length_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            BaseButton(
              text: 'send'.tr(),
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
