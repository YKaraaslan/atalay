import 'package:base_dialog/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/service/service_path.dart';
import '../profile_service.dart';

class ProfileUpdateViewModel extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController positionController;
  late TextEditingController aboutMeController;
  BaseDialog baseDialog = BaseDialog();
  late List<dynamic> labels;
  late GlobalKey<FormState> formKeyForDialog;
  late TextEditingController labelTextController;
  late UserModel? newModel;

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: 'OK', onPressed: () => true),
      ),
    );
  }

  Future<void> addLabel(BuildContext context) async {
    labelTextController.text = '';
    return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKeyForDialog,
          child: AlertDialog(
            title: const Text('İlgi Alanı Ekle'),
            content: TextFormField(
              autofocus: true,
              maxLength: 30,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'cannot_be_blank'.tr();
                }
                return null;
              },
              controller: labelTextController,
            ),
            actions: [
              TextButton(
                child: Text('cancel'.tr().toUpperCase()),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('add'.tr().toUpperCase()),
                onPressed: () {
                  if (formKeyForDialog.currentState!.validate()) {
                    if (labels.length >= 5) {
                      showSnackbar(context, 'labels_max_amount_reached'.tr());
                    } else {
                      labels.add(labelTextController.text.trim());
                      notifyListeners();
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onDeletedMethod(int index) {
    labels.removeAt(index);
    notifyListeners();
  }

  Future showDateTimePicker(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    birthdayController.text = DateFormat('dd MMMM yyyy').format(newDate!);
  }

  void dismissDialog(BuildContext context, text) {
    baseDialog.dismissDialog();
    return showSnackbar(context, text);
  }

  Future<void> getUserInfo() async {
    await ServicePath.usersCollectionReference.doc(ServicePath.auth.currentUser!.uid).get().then((value) {
      newModel = UserModel(
        id: value.id,
        name: value.get('name'),
        surname: value.get('surname'),
        fullName: value.get('fullName'),
        phone: value.get('phone'),
        birthday: value.get('birthday'),
        mail: value.get('mail'),
        password: value.get('password'),
        imageURL: value.get('imageURL'),
        signUpTime: value.get('signUpTime'),
        token: value.get('token'),
        signUpAcceptedTime: value.get('signUpAcceptedTime'),
        signUpAcceptedBy: value.get('signUpAcceptedBy'),
        authorization: value.get('authorization'),
        position: value.get('position'),
        online: value.get('online'),
        onlineTime: value.get('onlineTime'),
        aboutMe: value.get('aboutMe'),
        interests: value.get('interests'),
      );
    });

    nameController.text = newModel!.name;
    surnameController.text = newModel!.surname;
    phoneController.text = newModel!.phone;
    birthdayController.text = DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(newModel!.birthday.millisecondsSinceEpoch));
    positionController.text = newModel!.position;
    aboutMeController.text = newModel!.aboutMe;
    labels = newModel!.interests;
    notifyListeners();
  }

  Future<void> updateProfileInfo(BuildContext context) async {
    baseDialog.text = 'updating_post'.tr();
    baseDialog.showLoadingDialog(context);

    bool result = await updateProfileInfoService({
      'name': nameController.text.trim(),
      'surname': surnameController.text.trim(),
      'fullName': '${nameController.text.trim()} ${surnameController.text.trim()}',
      'phone': phoneController.text.trim(),
      'birthday': DateFormat('dd MMMM yyyy').parse(birthdayController.text.trim()),
      'position': positionController.text.trim(),
      'aboutMe': aboutMeController.text.trim(),
      'interests': labels,
    });

    if (result) {
      baseDialog.dismissDialog();
      Navigator.pop(context);
      showSnackbar(context, 'Basariyla Guncellendi');
    } else {
      baseDialog.dismissDialog();
      showSnackbar(context, 'Guncelleme Basarisiz');
    }
  }
}
