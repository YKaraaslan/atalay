import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/styles.dart';
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
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'name'.tr(),
                prefixIcon: const Icon(Icons.all_inclusive),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'name_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'surname'.tr(),
                prefixIcon: const Icon(Icons.tune_sharp),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'surname_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'phone'.tr(),
                prefixIcon: const Icon(Icons.phone_android),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'phone_validator'.tr();
                } else if (value.length != 11) {
                  return 'phone_length_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'username'.tr(),
                prefixIcon: const Icon(Icons.account_circle_sharp),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'login_username_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'password'.tr(),
                prefixIcon: const Icon(Icons.password),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'password_validator'.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: Sizes.width_100percent(context),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'sign_up',
                    style: buttonTextStyle(),
                  ).tr(),
                ),
                onPressed: () {
                  _formKey.currentState!.validate();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
