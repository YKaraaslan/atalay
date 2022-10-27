import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/reference_model.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import 'references_person_update_viewmodel.dart';

class ReferencesPersonUpdateView extends StatelessWidget {
  const ReferencesPersonUpdateView({Key? key, required this.model}) : super(key: key);
  final ReferenceModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Referansi Guncelle',
        actions: [SizedBox()],
      ),
      onPageBuilder: (context, value) => _Body(model: model),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final ReferenceModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ReferencesPersonUpdateViewModel _viewModel = context.read<ReferencesPersonUpdateViewModel>();

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
    _viewModel.model = widget.model;
    _viewModel.setAll(widget.model);
    _viewModel.getCompanyInfo(widget.model.companyID);
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
          builder: (context, ReferencesPersonUpdateViewModel viewModel, child) => Form(
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
                _CompanyField(),
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
          text: 'Referansi Guncelle',
          fun: () async {
            if (context.read<ReferencesPersonUpdateViewModel>().formKey.currentState!.validate()) {
              await context.read<ReferencesPersonUpdateViewModel>().updateReference(context);
            }
          },
        ),
      ),
    );
  }
}

class _CompanyField extends StatelessWidget {
  const _CompanyField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesPersonUpdateViewModel viewModel, child) => SizedBox(
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (viewModel.companySelected != null) {
              return Card(
                child: ListTile(
                  onTap: () {
                    viewModel.navigateAndDisplaySelection(context);
                  },
                  leading: viewModel.companySelected!.imageURL == ''
                      ? CircleAvatar(
                          backgroundImage: AssetImage(
                            Assets.groupsTeam,
                          ),
                          backgroundColor: Colors.transparent,
                        )
                      : CircleAvatar(
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

class _Phone extends StatelessWidget {
  const _Phone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesPersonUpdateViewModel>().phoneTextController,
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
      controller: context.read<ReferencesPersonUpdateViewModel>().mailTextController,
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
      controller: context.read<ReferencesPersonUpdateViewModel>().descriptionTextController,
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
            controller: context.read<ReferencesPersonUpdateViewModel>().nameTextController,
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
            controller: context.read<ReferencesPersonUpdateViewModel>().surnameTimeTextController,
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
      builder: (context, ReferencesPersonUpdateViewModel viewModel, child) => Center(
        child: InkWell(
          onTap: () {
            viewModel.openGallery(context);
          },
          child: ClipOval(
            child: viewModel.image == null
                ? (viewModel.model.imageURL == ''
                    ? Image.asset(Assets.profile, width: 100, height: 100, fit: BoxFit.cover)
                    : Hero(
                        tag: 'photo',
                        child: Image.network(viewModel.model.imageURL, width: 100, height: 100, fit: BoxFit.cover),
                      ))
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
