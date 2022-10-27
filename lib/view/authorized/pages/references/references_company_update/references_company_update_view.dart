import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/assets.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/constant/sizes.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../../../../core/widgets/base_button.dart';
import '../../../../../core/models/company_model.dart';
import 'references_company_update_viewmodel.dart';

class ReferencesCompanyUpdateView extends StatelessWidget {
  const ReferencesCompanyUpdateView({Key? key, required this.model}) : super(key: key);
  final CompanyModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Sirketi Duzenle',
        actions: [],
      ),
      onPageBuilder: (context, value) => _Body(model: model),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.model}) : super(key: key);
  final CompanyModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ReferencesCompanyUpdateViewModel _viewModel = context.read<ReferencesCompanyUpdateViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.nameTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.mailTextController = TextEditingController();
    _viewModel.phoneTextController = TextEditingController();
    _viewModel.locationTextController = TextEditingController();
    _viewModel.image = null;
    _viewModel.model = widget.model;
    _viewModel.setAll(widget.model);
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.nameTextController.dispose();
    _viewModel.descriptionTextController.dispose();
    _viewModel.mailTextController.dispose();
    _viewModel.phoneTextController.dispose();
    _viewModel.locationTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.contentPadding,
        child: Consumer(
          builder: (context, ReferencesCompanyUpdateViewModel viewModel, child) => Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Photo(),
                SizedBox(height: 20),
                _CompanyName(),
                SizedBox(height: 10),
                _Description(),
                SizedBox(height: 10),
                _Mail(),
                SizedBox(height: 10),
                _Phone(),
                SizedBox(height: 10),
                _Location(),
                SizedBox(height: 20),
                _UpdateButton(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Sizes.width_65percent(context),
        child: BaseButton(
          text: 'Sirketi Guncelle',
          fun: () async {
            if (context.read<ReferencesCompanyUpdateViewModel>().formKey.currentState!.validate()) {
              await context.read<ReferencesCompanyUpdateViewModel>().updateCompany(context);
            }
          },
        ),
      ),
    );
  }
}

class _Location extends StatelessWidget {
  const _Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesCompanyUpdateViewModel>().locationTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Lokasyon',
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

class _Phone extends StatelessWidget {
  const _Phone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesCompanyUpdateViewModel>().phoneTextController,
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
      controller: context.read<ReferencesCompanyUpdateViewModel>().mailTextController,
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
      controller: context.read<ReferencesCompanyUpdateViewModel>().descriptionTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Aciklama',
      ),
      maxLength: 100,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'cannot_be_blank'.tr();
        }
        return null;
      },
    );
  }
}

class _CompanyName extends StatelessWidget {
  const _CompanyName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesCompanyUpdateViewModel>().nameTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Sirket Ismi',
      ),
      onTap: () {},
      maxLength: 30,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'cannot_be_blank'.tr();
        }
        return null;
      },
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesCompanyUpdateViewModel viewModel, child) => Center(
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
