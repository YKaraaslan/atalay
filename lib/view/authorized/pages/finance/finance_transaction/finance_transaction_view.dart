import '../../../../../core/theme/dark_theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/service/service_path.dart';
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
    _viewModel.transactedAt = DateTime.now();

    _viewModel.isAdd = true;
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
        child: Form(
          key: context.read<FinanceTransactionViewModel>().formKeyForDialog,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Balance(),
              _Description(),
              _MoneyAmount(),
              SizedBox(height: 10),
              _BalanceStatus(),
              _DateTimePicker(),
              SizedBox(height: 10),
              _Button(),
              SizedBox(height: 10),
            ],
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
        child: Consumer<FinanceTransactionViewModel>(
          builder: (context, viewModel, child) => BaseButton(
            text: 'finance_transaction_create'.tr(),
            fun: () {
              if (viewModel.formKeyForDialog.currentState!.validate()) {
                viewModel.createFinanceTransaction(context);
              }
            },
          ),
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceTransactionViewModel>(
      builder: (context, viewModel, child) => SizedBox(
        height: 250,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(
                color: context.read<DarkThemeProvider>().darkTheme ? Colors.white : Colors.black,
              ),
            ),
          ),
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (value) {
              viewModel.changeTransactedAt(value);
            },
            mode: CupertinoDatePickerMode.dateAndTime,
            use24hFormat: true,
            maximumDate: DateTime.now(),
          ),
        ),
      ),
    );
  }
}

class _BalanceStatus extends StatelessWidget {
  const _BalanceStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceTransactionViewModel>(
      builder: (context, viewModel, child) => RichText(
        text: TextSpan(
          text: "${'balance_status'.tr()}: ",
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: viewModel.moneyLast.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            const TextSpan(text: ' ₺'),
          ],
        ),
      ),
    );
  }
}

class _MoneyAmount extends StatelessWidget {
  const _MoneyAmount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceTransactionViewModel>(
      builder: (context, viewModel, child) => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: viewModel.moneyController,
              decoration: InputDecoration(
                labelText: 'finance_create_amount'.tr(),
                icon: const Icon(Icons.attach_money),
              ),
              maxLength: 10,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'cannot_be_blank'.tr();
                }
                if (double.tryParse(value) == null) {
                  return 'provide_valid_number'.tr();
                }
                return null;
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  value = '0';
                }
                viewModel.changeMoneyLast(double.tryParse(value));
              },
            ),
          ),
          const SizedBox(width: 10),
          viewModel.isAdd
              ? OutlinedButton(
                  onPressed: () {
                    viewModel.changeIsAdd(false);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.green.withOpacity(0.5),
                    ),
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : OutlinedButton(
                  onPressed: () {
                    viewModel.changeIsAdd(true);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.red.withOpacity(0.5),
                    ),
                  ),
                  child: const Text(
                    '-',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceTransactionViewModel>(
      builder: (context, viewModel, child) => TextFormField(
        controller: viewModel.titleTextController,
        decoration: InputDecoration(
          labelText: 'finance_create_explanation'.tr(),
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
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceTransactionViewModel>(
      builder: (context, viewModel, child) => StreamBuilder<DocumentSnapshot>(
        stream: ServicePath.applicationFinancesCollectionReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            viewModel.money = double.parse(snapshot.data!.get('balance').toString());
            return RichText(
              text: TextSpan(
                text: "${'balance'.tr()}: ",
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: viewModel.money.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  const TextSpan(text: ' ₺'),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
