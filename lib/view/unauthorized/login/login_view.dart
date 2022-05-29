import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/assets.dart';
import '../../../core/constant/routes.dart';
import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_textformfield.dart';
import '../../unauthorized/unauthorized_baseview.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel _viewModel = context.read<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.mailController = TextEditingController();
    _viewModel.passwordController = TextEditingController();
    _viewModel.setFieldsforInit();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.mailController.dispose();
    _viewModel.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnauthorizedBaseView(
      child: Column(
        children: const [
          _FormField(),
          SizedBox(
            height: 5,
          ),
          _ExtrasField(),
          Divider(),
          SizedBox(
            height: 15,
          ),
          _SocialField(),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, LoginViewModel viewModel, child) => Form(
        key: viewModel.formKey,
        child: Column(
          children: [
            BaseTextFormField(
              hint: 'mail'.tr(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.mail_outline),
              controller: viewModel.mailController,
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
            const SizedBox(height: 10),
            BaseTextFormField(
              hint: 'password'.tr(),
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              prefixIcon: const Icon(Icons.password_outlined),
              isPassword: true,
              controller: viewModel.passwordController,
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
              margin: const EdgeInsets.only(top: 10, right: 20, bottom: 10),
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Checkbox(
                              value: viewModel.checked,
                              onChanged: (value) {
                                if (value != null) {
                                  viewModel.checkClicked(value);
                                }
                              }),
                          GestureDetector(onTap: () => viewModel.checkClickedReverse(), child: const Text('remember_me').tr())
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
                if (viewModel.formKey.currentState!.validate()) {
                  viewModel.login(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ExtrasField extends StatelessWidget {
  const _ExtrasField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class _SocialField extends StatelessWidget {
  const _SocialField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: const Text('our_social_media_accounts').tr()),
        const SizedBox(
          height: 15,
        ),
        Consumer(
          builder: (context, LoginViewModel viewModel, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => viewModel.instagram(),
                  icon: Image.asset(
                    Assets.instagram,
                    width: 75,
                    height: 75,
                  )),
              const SizedBox(
                width: 25,
              ),
              IconButton(
                  onPressed: () => viewModel.linkedin(),
                  icon: Image.asset(
                    Assets.linkedin,
                    width: 75,
                    height: 75,
                  )),
              const SizedBox(
                width: 25,
              ),
              IconButton(
                  onPressed: () => viewModel.twitter(),
                  icon: Image.asset(
                    Assets.twitter,
                    width: 75,
                    height: 75,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
