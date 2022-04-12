import 'package:atalay/core/models/finance_transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/routes.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/service/service_path.dart';
import '../../../../core/widgets/base_appbar.dart';
import 'finance_viewmodel.dart';

class FinanceView extends StatelessWidget {
  const FinanceView({Key? key, required this.zoomDrawerController}) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        zoomDrawerController: zoomDrawerController,
        title: 'finance'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, Routes.financeCreate);
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            'balance_available'.tr(),
            style: cardTitleStyle(),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, FinanceViewModel _viewModel, child) => StreamBuilder<DocumentSnapshot>(
              stream: ServicePath.applicationFinancesCollectionReference.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _viewModel.balance = double.parse(snapshot.data!.get('balance').toString());
                  return Text(
                    _viewModel.balance.toString() + ' ₺',
                    style: financeTitleStyle,
                  );
                }
                return Container();
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 10,
            color: Colors.grey.shade300,
          ),
          FirestoreQueryBuilder(
            query: ServicePath.financesCollectionReference.orderBy('transactedAt', descending: true),
            builder: (context, snapshot, _) {
              if (snapshot.hasError) {
                return Text('error ${snapshot.error}');
              }
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemCount: snapshot.docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                      snapshot.fetchMore();
                    }

                    FinanceTransactionModel model = FinanceTransactionModel.fromJson(snapshot.docs[index].data() as Map<String, Object?>);

                    if (model.type == "addition") {
                      return ListTile(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return _BottomSheet(id: snapshot.docs[index].id, model: model);
                            },
                          );
                        },
                        leading: const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.move_up,
                            color: Colors.white,
                          ),
                        ),
                        title: Text('+ ' + model.money.toString() + " ₺"),
                        subtitle: Text(model.title +
                            '\n' +
                            DateFormat('dd MMMM yyyy hh:mm')
                                .format(DateTime.fromMillisecondsSinceEpoch(model.transactedAt.millisecondsSinceEpoch))
                                .toString()),
                        isThreeLine: true,
                      );
                    } else {
                      return ListTile(
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return _BottomSheet(id: snapshot.docs[index].id, model: model);
                            },
                          );
                        },
                        leading: const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.move_down_rounded,
                            color: Colors.white,
                          ),
                        ),
                        title: Text('- ' + model.money.toString() + " ₺"),
                        subtitle: Text(model.title +
                            '\n' +
                            DateFormat('dd MMMM yyyy hh:mm')
                                .format(DateTime.fromMillisecondsSinceEpoch(model.transactedAt.millisecondsSinceEpoch))
                                .toString()),
                        isThreeLine: true,
                      );
                    }
                  },
                );
              }
              return Container();
            },
            pageSize: 20,
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key, required this.id, required this.model}) : super(key: key);
  final String id;
  final FinanceTransactionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.minimize,
              color: Colors.blue[200],
              size: 25,
            ),
          ),
          Consumer(
            builder: (context, FinanceViewModel _viewModel, child) => ListTile(
              leading: Image.asset(
                Assets.delete,
                width: 25,
              ),
              title: Text('delete'.tr()),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                _viewModel.delete(id, model);
              },
            ),
          ),
        ],
      ),
    );
  }
}
