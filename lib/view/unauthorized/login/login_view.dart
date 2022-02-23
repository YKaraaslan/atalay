import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/assets.dart';
import '../../../core/constant/routes.dart';
import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_textformfield.dart';
import '../../unauthorized/unauthorized_baseview.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return UnauthorizedBaseView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                BaseTextFormField(
                  hint: 'username'.tr(),
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
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
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  prefixIcon: const Icon(Icons.account_circle_sharp),
                  fun: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password_validator'.tr();
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 20, bottom: 10),
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text('remember_me').tr()
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: const Text(
                          'forgot_password',
                        ).tr(),
                      ),
                    ],
                  ),
                ),
                BaseButton(
                  text: 'login'.tr(),
                  fun: () {
                    _formKey.currentState!.validate();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('dont_have_an_account').tr(),
              TextButton(
                child: const Text('sign_up_now').tr(),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.signup);
                },
              )
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          Center(child: const Text('our_social_media_accounts').tr()),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(Assets.facebook),
                radius: 20,
              ),
              const SizedBox(
                width: 25,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(Assets.instagram),
                radius: 22,
              ),
              const SizedBox(
                width: 25,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(Assets.linkedin),
                radius: 22,
              ),
              const SizedBox(
                width: 25,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(Assets.twitter),
                radius: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
