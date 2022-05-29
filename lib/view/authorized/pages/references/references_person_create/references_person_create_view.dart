import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import 'references_person_create_viewmodel.dart';

class ReferencesPersonCreateView extends StatelessWidget {
  const ReferencesPersonCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'references'.tr(),
        actions: const [SizedBox()],
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
  late final ReferencesPersonCreateViewModel _viewModel = context.read<ReferencesPersonCreateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.nameTextController = TextEditingController();
    _viewModel.surnameTimeTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.mailTextController = TextEditingController();
    _viewModel.phoneTextController = TextEditingController();
    _viewModel.companySelected = null;
    _viewModel.image = null;
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.nameTextController.dispose();
    _viewModel.surnameTimeTextController.dispose();
    _viewModel.descriptionTextController.dispose();
    _viewModel.mailTextController.dispose();
    _viewModel.phoneTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Consumer(
          builder: (context, ReferencesPersonCreateViewModel viewModel, child) => Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Photo(),
                SizedBox(height: 20),
                _NameSurname(),
                SizedBox(height: 20),
                _Description(),
                SizedBox(height: 20),
                _Mail(),
                SizedBox(height: 20),
                _Phone(),
                SizedBox(height: 10),
                _CompanyTitleField(),
                SizedBox(height: 10),
                _CompanySelected(),
                SizedBox(height: 20),
                _Button(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompanyTitleField extends StatelessWidget {
  const _CompanyTitleField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sirket',
      style: TextStyle(color: Colors.grey[600]),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Sizes.width_65percent(context),
        child: BaseButton(
          text: 'create_event'.tr(),
          fun: () async {
            if (context.read<ReferencesPersonCreateViewModel>().formKey.currentState!.validate()) {
              context.read<ReferencesPersonCreateViewModel>().createReference(context);
            }
          },
        ),
      ),
    );
  }
}

class _CompanySelected extends StatelessWidget {
  const _CompanySelected({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesPersonCreateViewModel viewModel, child) => SizedBox(
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (viewModel.companySelected != null) {
              return Card(
                child: ListTile(
                  onTap: () {
                    viewModel.navigateAndDisplaySelection(context);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      viewModel.companySelected!.imageURL,
                    ),
                  ),
                  title: Text(viewModel.companySelected!.companyName),
                  subtitle: Text(viewModel.companySelected!.description),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    viewModel.navigateAndDisplaySelection(context);
                  },
                  leading: Image.asset(
                    Assets.meetups,
                    height: 30,
                  ),
                  title: const Text('Sirket'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _Phone extends StatelessWidget {
  const _Phone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesPersonCreateViewModel>().phoneTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Telefon',
      ),
      maxLength: 15,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'phone_validator'.tr();
        }
        return null;
      },
    );
  }
}

class _Mail extends StatelessWidget {
  const _Mail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesPersonCreateViewModel>().mailTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Mail',
      ),
      maxLength: 30,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'mail_validator'.tr();
        }
        if (!EmailValidator.validate(value.trim()) || !value.toString().trim().endsWith('.com')) {
          return 'mail_invalid_validator'.tr();
        }
        return null;
      },
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesPersonCreateViewModel>().descriptionTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Aciklama',
      ),
      maxLength: 100,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'cannot_be_blank'.tr();
        }
        return null;
      },
    );
  }
}

class _NameSurname extends StatelessWidget {
  const _NameSurname({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: context.read<ReferencesPersonCreateViewModel>().nameTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Isim',
            ),
            onTap: () {},
            maxLength: 30,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'cannot_be_blank'.tr();
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: context.read<ReferencesPersonCreateViewModel>().surnameTimeTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Soyisim',
            ),
            maxLength: 30,
            onTap: () {},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'cannot_be_blank'.tr();
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesPersonCreateViewModel viewModel, child) => Center(
        child: InkWell(
          onTap: () {
            viewModel.openGallery(context);
          },
          child: ClipOval(
            child: viewModel.image == null
                ? Image.asset(Assets.profile, width: 100, height: 100, fit: BoxFit.cover)
                : Hero(
                    tag: 'photo',
                    child: Image.file(viewModel.image!, width: 100, height: 100, fit: BoxFit.cover),
                  ),
          ),
        ),
      ),
    );
  }
}
