import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/models/company_model.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'references_company_show/references_company_show_view.dart';
import 'references_independent/references_independent_view.dart';

class ReferencesView extends StatelessWidget {
  const ReferencesView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'references'.tr(),
        zoomDrawerController: zoomDrawerController,
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, Routes.referencesCreate);
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  //late final ReferencesViewModel _viewModel = context.read<ReferencesViewModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: ServicePath.referencesCollectionReference.where('companyID', isEqualTo: '').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Visibility(
                    visible: snapshot.data!.docs.isNotEmpty,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReferencesIndependenView(),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(Assets.groupsProjects),
                        backgroundColor: Colors.transparent,
                      ),
                      title: const Text(
                        'Bagimsiz',
                        style: TextStyle(color: Colors.blue),
                      ),
                      subtitle: Text('${snapshot.data!.docs.length} Referans bulunmaktadir'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                }
                return Container();
              }),
          FirestoreQueryBuilder(
            query: ServicePath.companiesCollectionReference.orderBy('createdAt', descending: true),
            builder: (context, snapshot, _) {
              if (snapshot.hasError) {
                return Text('error ${snapshot.error}');
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    CompanyModel company = CompanyModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReferencesCompanyShowView(model: company),
                          ),
                        );
                      },
                      leading: company.imageURL != '' ? CircleAvatar(
                        backgroundImage: NetworkImage(company.imageURL),
                      ) : CircleAvatar(
                        backgroundImage: AssetImage(Assets.groupCreatePhoto),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(company.companyName),
                      subtitle: FutureBuilder<QuerySnapshot>(
                        future: ServicePath.referencesCollectionReference.where('companyID', isEqualTo: company.id).get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data!.docs.length} Referans bulunmaktadir');
                          }
                          return const Text('Referans bulunmamaktadir');
                        },
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
