import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/models/company_model.dart';
import 'references_add_to_companies_viewmodel.dart';

class ReferencesAddToCompaniesView extends StatelessWidget {
  const ReferencesAddToCompaniesView({Key? key, required this.referenceCompanyModel}) : super(key: key);
  final CompanyModel? referenceCompanyModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'choose_for_team'.tr(),
        actions: const [SizedBox()],
      ),
      onPageBuilder: (context, value) => _Body(referenceCompanyModel: referenceCompanyModel),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, Routes.companyCreate);
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key, required this.referenceCompanyModel}) : super(key: key);
  final CompanyModel? referenceCompanyModel;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ReferencesAddToCompaniesViewModel _viewModel = context.read<ReferencesAddToCompaniesViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.companyModels = [];
    _viewModel.selectedCompany = widget.referenceCompanyModel;
    _viewModel.getCompanies();
  }

  bool isSelected(ReferencesAddToCompaniesViewModel _viewModel, int index) {
    if (_viewModel.selectedCompany == null) {
      return false;
    }
    return _viewModel.selectedCompany!.id == _viewModel.companyModels[index].id;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ReferencesAddToCompaniesViewModel _viewModel, child) {
        if (_viewModel.companyModels.isEmpty) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) => const _ShimmerEffect(),
          );
        }
        return Stack(
          children: [
            ListView.builder(
              itemCount: _viewModel.companyModels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    _viewModel.selectUser(index);
                    return Navigator.pop(context, _viewModel.selectedCompany);
                  },
                  leading: _viewModel.companyModels[index].imageURL == ''
                      ? CircleAvatar(
                          backgroundImage: AssetImage(Assets.groups),
                          backgroundColor: Colors.transparent,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(_viewModel.companyModels[index].imageURL),
                        ),
                  title: isSelected(_viewModel, index)
                      ? Text(
                          _viewModel.companyModels[index].companyName,
                          style: const TextStyle(color: Colors.blue),
                        )
                      : Text(_viewModel.companyModels[index].companyName),
                  subtitle: isSelected(_viewModel, index)
                      ? Text(
                          _viewModel.companyModels[index].description,
                          style: TextStyle(color: Colors.blue[300]),
                        )
                      : Text(_viewModel.companyModels[index].description),
                  trailing: isSelected(_viewModel, index)
                      ? const Icon(
                          Icons.check,
                          color: Colors.blue,
                        )
                      : const SizedBox(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerEffect extends StatelessWidget {
  const _ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: AnimatedShimmer.round(
              size: 45,
            ),
            title: const AnimatedShimmer(
              height: 10,
              width: 10,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            subtitle: const AnimatedShimmer(
              height: 10,
              width: 100,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }
}
