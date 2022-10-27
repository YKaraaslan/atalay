import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import '../../../../../core/widgets/base_textformfield.dart';
import 'profile_update_viewmodel.dart';

class ProfileUpdateView extends StatelessWidget {
  const ProfileUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Profil Bilgileri',
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
  late final ProfileUpdateViewModel _viewModel = context.read<ProfileUpdateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.nameController = TextEditingController();
    _viewModel.surnameController = TextEditingController();
    _viewModel.phoneController = TextEditingController();
    _viewModel.birthdayController = TextEditingController();
    _viewModel.positionController = TextEditingController();
    _viewModel.aboutMeController = TextEditingController();
    _viewModel.labels = [];
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
    _viewModel.labelTextController = TextEditingController();

    Future.delayed(Duration.zero, _viewModel.getUserInfo);
  }

  @override
  void dispose() {
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.nameController.dispose();
    _viewModel.surnameController.dispose();
    _viewModel.phoneController.dispose();
    _viewModel.birthdayController.dispose();
    _viewModel.positionController.dispose();
    _viewModel.aboutMeController.dispose();
    _viewModel.labelTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            children: const [
              _NameField(),
              SizedBox(height: 20),
              _SurnameField(),
              SizedBox(height: 20),
              _PhoneField(),
              SizedBox(height: 20),
              _Birthday(),
              SizedBox(height: 20),
              _Position(),
              SizedBox(height: 20),
              _AboutMe(),
              SizedBox(height: 20),
              Divider(),
              _Interests(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Interests extends StatelessWidget {
  const _Interests({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => Column(
        children: [
          TextButton(onPressed: () => viewModel.addLabel(context), child: const Text('İlgi Alanı Ekle')),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 5,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                    viewModel.labels.length,
                    (index) => Chip(
                      label: Text(viewModel.labels[index]),
                      backgroundColor: Colors.blue.shade100,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      deleteIcon: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.close_rounded,
                          size: 13,
                        ),
                      ),
                      onDeleted: () {
                        viewModel.onDeletedMethod(index);
                      },
                      elevation: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseTextFormField(
        hint: 'name'.tr(),
        controller: viewModel.nameController,
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
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseTextFormField(
        hint: 'surname'.tr(),
        controller: viewModel.surnameController,
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
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseTextFormField(
        hint: 'birthday'.tr(),
        controller: viewModel.birthdayController,
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
          viewModel.showDateTimePicker(context);
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
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseTextFormField(
        hint: 'phone'.tr(),
        controller: viewModel.phoneController,
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

class _Position extends StatelessWidget {
  const _Position({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseTextFormField(
        hint: 'Pozisyon',
        controller: viewModel.positionController,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.text,
        prefixIcon: const Icon(Icons.settings_backup_restore),
        fun: (value) {
          return null;
        },
      ),
    );
  }
}

class _AboutMe extends StatelessWidget {
  const _AboutMe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseTextFormField(
        hint: 'Hakkimda',
        controller: viewModel.aboutMeController,
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.multiline,
        prefixIcon: const Icon(Icons.person_outlined),
        maxLines: 10,
        fun: (value) {
          return null;
        },
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
    return Consumer<ProfileUpdateViewModel>(
      builder: (context, viewModel, child) => BaseButton(
        text: 'Profilimi Guncelle',
        fun: () {
          if (viewModel.formKey.currentState!.validate()) {
            viewModel.updateProfileInfo(context);
          }
        },
      ),
    );
  }
}
