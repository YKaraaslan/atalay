import 'forgot_password_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_textformfield.dart';
import '../unauthorized_baseview.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final ForgotPasswordViewModel _viewModel = context.read<ForgotPasswordViewModel>();

  @override
  void initState() {
    super.initState();

    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.mailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.mailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnauthorizedBaseView(
      child: Form(
        key: _viewModel.formKey,
        child: Column(
          children: const [
            _MailField(),
            SizedBox(height: 15),
            _ButtonField(),
          ],
        ),
      ),
    );
  }
}

class _MailField extends StatelessWidget {
  const _MailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ForgotPasswordViewModel _viewModel, child) => BaseTextFormField(
        hint: 'mail'.tr(),
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.emailAddress,
        prefixIcon: const Icon(Icons.mail_outline),
        controller: _viewModel.mailController,
        fun: (value) {
          if (value == null || value.isEmpty) {
            return 'mail_validator'.tr();
          }
          if (!EmailValidator.validate(value.trim()) ||
              !value.toString().trim().endsWith('.com')) {
            return 'mail_invalid_validator'.tr();
          }
          return null;
        },
      ),
    );
  }
}

class _ButtonField extends StatelessWidget {
  const _ButtonField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ForgotPasswordViewModel _viewModel, child) =>
          BaseButton(
        text: 'reset_password'.tr(),
        fun: () {
          if (_viewModel.formKey.currentState!.validate()) {
            _viewModel.resetPassword(context);
          }
        },
      ),
    );
  }
}
