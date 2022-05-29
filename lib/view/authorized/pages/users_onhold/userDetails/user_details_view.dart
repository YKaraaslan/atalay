import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:provider/provider.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constant/paddings.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/models/authorization_model.dart';
import '../../../../../core/models/users_onhold_model.dart';
import '../../../../../core/service/service_path.dart';
import '../../../../../core/widgets/base_appbar.dart';
import '../../../../../core/widgets/base_textfield.dart';
import 'user_details_viewmodel.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        title: 'users_onhold_single'.tr(),
        actions: const [],
      ),
      onPageBuilder: (context, value) => const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final UserDetailsViewModel _viewModel = context.read<UserDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.formKey = GlobalKey<FormState>();
    _viewModel.roleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    if (_viewModel.formKey.currentState != null) {
      _viewModel.formKey.currentState!.dispose();
    }
    _viewModel.roleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel.model = ModalRoute.of(context)!.settings.arguments as UsersOnHoldModel;
    return Padding(
      padding: AppPaddings.contentPadding,
      child: Column(
        children: [
          _Photo(imageURL: _viewModel.model.imageURL),
          const SizedBox(height: 15),
          _NameSurnameField(fullName: _viewModel.model.fullName),
          const SizedBox(height: 15),
          _PhoneField(phone: _viewModel.model.phone),
          const SizedBox(height: 15),
          _Birthday(birthday: DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(_viewModel.model.birthday.millisecondsSinceEpoch)).toString()),
          const SizedBox(height: 15),
          _MailField(mail: _viewModel.model.mail),
          const SizedBox(height: 15),
          Align(alignment: Alignment.centerLeft, child: Text('authentication'.tr())),
          const _AuthField(),
          const _RoleField(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(child: _DeclineButton()),
              SizedBox(width: 25),
              Expanded(child: _AcceptButton()),
            ],
          ),
        ],
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({Key? key, required this.imageURL}) : super(key: key);
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.basePhotoViewer, arguments: imageURL);
      },
      child: Hero(
        tag: 'photo',
        child: ClipOval(
          child: Image.network(imageURL, width: 100, height: 100, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _NameSurnameField extends StatelessWidget {
  const _NameSurnameField({
    Key? key,
    required this.fullName,
  }) : super(key: key);

  final String fullName;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hint: "${'name'.tr()} ${'surname'.tr()}",
      text: fullName,
      prefixIcon: const Icon(Icons.all_inclusive),
    );
  }
}

class _Birthday extends StatelessWidget {
  const _Birthday({Key? key, required this.birthday}) : super(key: key);
  final String birthday;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hint: 'birthday'.tr(),
      text: birthday,
      prefixIcon: const Icon(Icons.date_range_outlined),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    Key? key,
    required this.phone,
  }) : super(key: key);
  final String phone;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hint: 'phone'.tr(),
      text: phone,
      prefixIcon: const Icon(Icons.phone_android),
    );
  }
}

class _MailField extends StatelessWidget {
  const _MailField({
    Key? key,
    required this.mail,
  }) : super(key: key);
  final String mail;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      hint: 'mail'.tr(),
      text: mail,
      prefixIcon: const Icon(Icons.mail_outline),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserDetailsViewModel viewModel, child) => FirestoreQueryBuilder(
        query: ServicePath.authorizationCollectionReference.orderBy('index'),
        builder: (context, snapshot, child) {
          if (snapshot.isFetching) {
            return const AnimatedShimmer(
              height: 10,
              width: 150,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            );
          }
          if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          for (var doc in snapshot.docs) {
            try {
              AuthorizationModel model = AuthorizationModel.fromMap(doc.data() as Map<String, Object?>);
              if (viewModel.dropDownItems!.any((element) => element.value == doc.id)) {
                continue;
              }
              viewModel.dropDownItems!.add(DropdownMenuItem(value: doc.id, child: Text(model.name)));
            } on Exception {
              continue;
            }
          }
          return DropdownButtonFormField(
            items: viewModel.dropDownItems,
            value: viewModel.dropDownItems!.first.value,
            onChanged: (value) {
              viewModel.auth = value as String;
            },
          );
        },
      ),
    );
  }
}

class _RoleField extends StatelessWidget {
  const _RoleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserDetailsViewModel viewModel, child) => Form(
        key: viewModel.formKey,
        child: TextFormField(
          maxLength: 50,
          decoration: InputDecoration(
            labelText: 'role'.tr(),
            hintText: 'software_developer'.tr(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'role_validator'.tr();
            }
            return null;
          },
        ),
      ),
    );
  }
}

class _AcceptButton extends StatelessWidget {
  const _AcceptButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserDetailsViewModel viewmodel, child) => OutlinedButton(
        onPressed: () {
          if (viewmodel.formKey.currentState!.validate()) {
            viewmodel.acceptUser(context);
          }
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.green,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('confirm_user'.tr(), style: const TextStyle(fontSize: 13, color: Colors.green)),
        ),
      ),
    );
  }
}

class _DeclineButton extends StatelessWidget {
  const _DeclineButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserDetailsViewModel viewmodel, child) => OutlinedButton(
        onPressed: () {
          if (viewmodel.formKey.currentState!.validate()) {
            viewmodel.declineUser(context);
          }
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.orange,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('decline_user'.tr(), style: const TextStyle(fontSize: 13, color: Colors.orange)),
        ),
      ),
    );
  }
}
