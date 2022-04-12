import 'package:atalay/core/constant/paddings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_button.dart';
import 'finance_transaction_viewmodel.dart';

class FinanceTransactionView extends StatefulWidget {
  const FinanceTransactionView({Key? key}) : super(key: key);

  @override
  State<FinanceTransactionView> createState() => _FinanceTransactionViewState();
}

class _FinanceTransactionViewState extends State<FinanceTransactionView> {
  late final FinanceTransactionViewModel _viewModel = context.read<FinanceTransactionViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKeyForDialog = GlobalKey<FormState>();
    _viewModel.titleTextController = TextEditingController();
    _viewModel.moneyController = TextEditingController();

    _viewModel.isAdd = true;
    _viewModel.money = 1000;
    _viewModel.moneyLast = _viewModel.money;
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKeyForDialog.currentState != null) {
      _viewModel.formKeyForDialog.currentState!.dispose();
    }
    _viewModel.titleTextController.dispose();
    _viewModel.moneyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'finance_transaction'.tr(),
        actions: const [],
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
      child: Padding(
        padding: AppPaddings.appPadding,
        child: Consumer(
          builder: (context, FinanceTransactionViewModel _viewModel, child) => Form(
            key: _viewModel.formKeyForDialog,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (context, FinanceTransactionViewModel _viewModel, child) => RichText(
                    text: TextSpan(
                      text: 'Bakiye: ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: _viewModel.money.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                        const TextSpan(text: ' ₺'),
                      ],
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, FinanceTransactionViewModel _viewModel, child) => TextFormField(
                    decoration: InputDecoration(
                      labelText: "project_title".tr(),
                      icon: const Icon(Icons.title),
                    ),
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'cannot_be_blank'.tr();
                      }
                      return null;
                    },
                  ),
                ),
                Consumer(
                  builder: (context, FinanceTransactionViewModel _viewModel, child) => Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _viewModel.moneyController,
                          decoration: InputDecoration(
                            labelText: "project_title".tr(),
                            icon: const Icon(Icons.attach_money),
                          ),
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'cannot_be_blank'.tr();
                            }
                            if (double.tryParse(value) == null) {
                              return 'Gecerli bir sayi giriniz';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.isEmpty) {
                              value = '0';
                            }
                            _viewModel.changeMoneyLast(double.tryParse(value));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      _viewModel.isAdd
                          ? OutlinedButton(
                              onPressed: () {
                                _viewModel.changeIsAdd(false);
                              },
                              child: const Text(
                                '+',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.green.withOpacity(0.5),
                                ),
                              ),
                            )
                          : OutlinedButton(
                              onPressed: () {
                                _viewModel.changeIsAdd(true);
                              },
                              child: const Text(
                                '-',
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red.withOpacity(0.5),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Consumer(
                  builder: (context, FinanceTransactionViewModel _viewModel, child) => RichText(
                    text: TextSpan(
                      text: 'Bakiye Durumu: ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: _viewModel.moneyLast.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                        const TextSpan(text: ' ₺'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (value) {},
                    mode: CupertinoDatePickerMode.dateAndTime,
                    use24hFormat: true,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Sizes.width_65percent(context),
                    child: Consumer(
                      builder: (context, FinanceTransactionViewModel _viewModel, child) => BaseButton(
                        text: 'post_create'.tr(),
                        fun: () {
                          if (_viewModel.formKeyForDialog.currentState!.validate()) {
                            _viewModel.createFinanceTransaction(context);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
