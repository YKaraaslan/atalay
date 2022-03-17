import '../../../core/constant/assets.dart';
import 'signup_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_textformfield.dart';
import '../unauthorized_baseview.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final SignUpViewModel _viewModel = context.read<SignUpViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.nameController = TextEditingController();
    _viewModel.surnameController = TextEditingController();
    _viewModel.phoneController = TextEditingController();
    _viewModel.birthdayController = TextEditingController();
    _viewModel.mailController = TextEditingController();
    _viewModel.passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.nameController.dispose();
    _viewModel.surnameController.dispose();
    _viewModel.phoneController.dispose();
    _viewModel.birthdayController.dispose();
    _viewModel.mailController.dispose();
    _viewModel.passwordController.dispose();
    _viewModel.image = null;
  }

  @override
  Widget build(BuildContext context) {
    return UnauthorizedBaseView(
      child: Form(
        key: _viewModel.formKey,
        child: Column(
          children: const [
            _Photo(),
            SizedBox(height: 10),
            _NameField(),
            SizedBox(height: 10),
            _SurnameField(),
            SizedBox(height: 10),
            _PhoneField(),
            SizedBox(height: 10),
            _Birthday(),
            SizedBox(height: 10),
            _MailField(),
            SizedBox(height: 10),
            _PasswordField(),
            SizedBox(height: 10),
            _PasswordRepeatField(),
            SizedBox(height: 10),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) => Center(
        child: InkWell(
          onTap: () {
            _viewModel.getSelection(context);
          },
          child: ClipOval(
            child: _viewModel.image == null
                ? Image.asset(Assets.profile,
                    width: 100, height: 100, fit: BoxFit.cover)
                : Hero(
                    tag: "photo",
                    child: Image.file(_viewModel.image!,
                        width: 100, height: 100, fit: BoxFit.cover),
                  ),
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'name'.tr(),
        controller: _viewModel.nameController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.name,
        prefixIcon: const Icon(Icons.all_inclusive),
        fun: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'name_validator'.tr();
          }
          return null;
        },
      ),
    );
  }
}

class _SurnameField extends StatelessWidget {
  const _SurnameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'surname'.tr(),
        controller: _viewModel.surnameController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.name,
        prefixIcon: const Icon(Icons.tune_sharp),
        fun: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'surname_validator'.tr();
          }
          return null;
        },
      ),
    );
  }
}

class _Birthday extends StatelessWidget {
  const _Birthday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'birthday'.tr(),
        controller: _viewModel.birthdayController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.datetime,
        prefixIcon: const Icon(Icons.date_range_outlined),
        isReadOnly: true,
        fun: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'birthday_validator'.tr();
          }
          return null;
        },
        onTap: () {
          _viewModel.showDateTimePicker(context);
        },
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'phone'.tr(),
        controller: _viewModel.phoneController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.phone,
        prefixIcon: const Icon(Icons.phone_android),
        fun: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'phone_validator'.tr();
          } else if (value.length != 11) {
            return 'phone_length_validator'.tr();
          }
          return null;
        },
      ),
    );
  }
}

class _MailField extends StatelessWidget {
  const _MailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'mail'.tr(),
        controller: _viewModel.mailController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.emailAddress,
        prefixIcon: const Icon(Icons.mail_outline),
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
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'password'.tr(),
        controller: _viewModel.passwordController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.streetAddress,
        prefixIcon: const Icon(Icons.password),
        fun: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'password_validator'.tr();
          } else if (value.length < 8) {
            return 'password_length_validator'.tr();
          }
          return null;
        },
        isPassword: true,
      ),
    );
  }
}

class _PasswordRepeatField extends StatelessWidget {
  const _PasswordRepeatField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) =>
          BaseTextFormField(
        hint: 'password_repeat'.tr(),
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        prefixIcon: const Icon(Icons.repeat),
        fun: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'password_validator'.tr();
          }
          if (value != _viewModel.passwordController.text) {
            return 'password_not_match'.tr();
          }
          return null;
        },
        isPassword: true,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SignUpViewModel _viewModel, child) => BaseButton(
        text: 'sign_up'.tr(),
        fun: () {
          if (_viewModel.formKey.currentState!.validate()) {
            if (_viewModel.image == null) {
              return _viewModel.showSnackbar(context, 'photo_validator'.tr());
            }
            _viewModel.signUp(context);
          }
        },
      ),
    );
  }
}
