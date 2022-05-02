import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:image_viewer/main.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../core/models/company_model.dart';
import '../../../../../core/models/reference_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../references_company_update/references_company_update_view.dart';
import '../references_person_show/references_person_show_view.dart';
import 'references_company_show_viewmodel.dart';

class ReferencesCompanyShowView extends StatelessWidget {
  const ReferencesCompanyShowView({Key? key, required this.model}) : super(key: key);
  final CompanyModel model;

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
  final CompanyModel model;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ReferencesCompanyShowViewModel _viewModel = context.read<ReferencesCompanyShowViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.nameTextController = TextEditingController();
    _viewModel.descriptionTextController = TextEditingController();
    _viewModel.mailTextController = TextEditingController();
    _viewModel.phoneTextController = TextEditingController();
    _viewModel.locationTextController = TextEditingController();

    _viewModel.setAll(widget.model);
  }

  @override
  void dispose() {
    super.dispose();
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
          builder: (context, ReferencesCompanyShowViewModel _viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Photo(model: widget.model),
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.nameTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sirket Ismi',
                ),
                readOnly: true,
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _viewModel.locationTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Lokasyon',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              Text(
                'Referanslar',
                style: buttonTextStyle().copyWith(color: Colors.blue.shade800),
              ),
              const SizedBox(height: 10),
              FirestoreQueryBuilder(
                query: ServicePath.referencesCollectionReference.where('companyID', isEqualTo: widget.model.id),
                builder: (context, snapshot, _) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.docs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        ReferenceModel referenceModel = ReferenceModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);

                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReferencesPersonShowView(model: referenceModel),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              referenceModel.imageURL,
                            ),
                          ),
                          title: Text(referenceModel.fullName),
                          subtitle: Text(referenceModel.description),
                          trailing: const Icon(Icons.chevron_right),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: Sizes.width_65percent(context),
                  child: OutlinedButton(
                    child: const Text(
                      'Sirketi Sil',
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
                      'Sirketi Duzenle',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReferencesCompanyUpdateView(model: widget.model),
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
  final CompanyModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesCompanyShowViewModel _viewModel, child) => Center(
        child: Visibility(
          visible: model.imageURL != '',
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NetworkImageViewer(heroAttribute: 'image', imageURL: model.imageURL),
                ),
              );
            },
            child: ClipOval(
              child: Hero(tag: 'image', child: Image.network(model.imageURL, width: 100, height: 100, fit: BoxFit.cover)),
            ),
          ),
        ),
      ),
    );
  }
}
