import 'references_person_show_viewmodel.dart';
import '../references_person_update/references_person_update_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/main.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/constant/paddings.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/models/reference_model.dart';

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
          builder: (context, ReferencesPersonShowViewModel _viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Photo(model: widget.model),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _viewModel.nameTextController,
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
                      controller: _viewModel.surnameTimeTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Soyisim',
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.descriptionTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aciklama',
                ),
                      readOnly: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.mailTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mail',
                ),
                      readOnly: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.phoneTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefon',
                ),
                      readOnly: true,
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: OutlinedButton(
                    child: const Text(
                      'Referansi Sil',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      _viewModel.delete(context, widget.model);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
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
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key, required this.model}) : super(key: key);
  final ReferenceModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesPersonShowViewModel _viewModel, child) => Center(
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
