import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/assets.dart';
import '../../../../../core/models/reference_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../references_person_show/references_person_show_view.dart';

class ReferencesIndependenView extends StatelessWidget {
  const ReferencesIndependenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: const BaseAppBar(
        title: 'Bagimsiz Referanslar',
        actions: [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FirestoreQueryBuilder(
        query: ServicePath.referencesCollectionReference.where('companyID', isEqualTo: ''),
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
                  leading: referenceModel.imageURL != ''
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(referenceModel.imageURL),
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage(Assets.profile),
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
    );
  }
}
