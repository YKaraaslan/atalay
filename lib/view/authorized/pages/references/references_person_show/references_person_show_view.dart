import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/main.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/reference_model.dart';
import '../references_person_update/references_person_update_view.dart';
import 'references_person_show_viewmodel.dart';

class ReferencesPersonShowView extends StatelessWidget {
  const ReferencesPersonShowView({Key? key, required this.model}) : super(key: key);
  final ReferenceModel model;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'references'.tr(),
        actions: const [],
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
  late final ReferencesPersonShowViewModel _viewModel = context.read<ReferencesPersonShowViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.nameTextController = TextEditingController();
    _viewModel.surnameTimeTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.mailTextController = TextEditingController();
    _viewModel.phoneTextController = TextEditingController();

    _viewModel.setAll(widget.model);
  }

  @override
  void dispose() {
    super.dispose();
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
          builder: (context, ReferencesPersonShowViewModel viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Photo(model: widget.model),
              const SizedBox(height: 20),
              const _NameSurname(),
              const SizedBox(height: 20),
              const _Description(),
              const SizedBox(height: 20),
              const _Mail(),
              const SizedBox(height: 20),
              const _Phone(),
              const SizedBox(height: 50),
              _DeleteReferenceButton(widget: widget),
              const SizedBox(height: 10),
              _UpdateReference(widget: widget),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateReference extends StatelessWidget {
  const _UpdateReference({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final _Body widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Sizes.width_65percent(context),
        child: OutlinedButton(
          child: const Text(
            'Referansi Duzenle',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReferencesPersonUpdateView(model: widget.model),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DeleteReferenceButton extends StatelessWidget {
  const _DeleteReferenceButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final _Body widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: Sizes.width_65percent(context),
        child: OutlinedButton(
          child: const Text(
            'Referansi Sil',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            context.read<ReferencesPersonShowViewModel>().delete(context, widget.model);
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
      controller: context.read<ReferencesPersonShowViewModel>().phoneTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Telefon',
      ),
      readOnly: true,
    );
  }
}

class _Mail extends StatelessWidget {
  const _Mail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<ReferencesPersonShowViewModel>().mailTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Mail',
      ),
      readOnly: true,
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
      controller: context.read<ReferencesPersonShowViewModel>().descriptionTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Aciklama',
      ),
      readOnly: true,
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
            controller: context.read<ReferencesPersonShowViewModel>().nameTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Isim',
            ),
            readOnly: true,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: context.read<ReferencesPersonShowViewModel>().surnameTimeTextController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Soyisim',
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key, required this.model}) : super(key: key);
  final ReferenceModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesPersonShowViewModel viewModel, child) => Center(
        child: Visibility(
          visible: model.imageURL != '',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NetworkImageViewer(heroAttribute: 'imagePerson', imageURL: model.imageURL),
                ),
              );
            },
            child: ClipOval(
              child: Hero(tag: 'imagePerson', child: Image.network(model.imageURL, width: 100, height: 100, fit: BoxFit.cover)),
            ),
          ),
        ),
      ),
    );
  }
}
