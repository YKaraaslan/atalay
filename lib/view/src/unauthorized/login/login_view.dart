import 'package:atalay/core/constant/assets.dart';
import 'package:atalay/core/constant/paddings.dart';
import 'package:atalay/core/constant/sizes.dart';
import 'package:atalay/core/constant/styles.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/base/view/base_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: Sizes.height_40percent(context),
              child: Image(
                image: AssetImage(Assets.loginBackground),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: Sizes.width_100percent(context),
              margin: EdgeInsets.only(top: Sizes.height_35percent(context)),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: AppPaddings.contentPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('login_title', style: titleStyle(context)).tr(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'username'.tr(),
                              prefixIcon: const Icon(
                                  Icons.supervised_user_circle_rounded),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'login_username_validator'.tr();
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'password'.tr(),
                              prefixIcon: const Icon(Icons.password),
                            ),
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password_validator'.tr();
                              }
                              return null;
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, right: 20, bottom: 10),
                            alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: true, onChanged: (value) {}),
                                        const Text('remember_me').tr()
                                      ],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'forgot_password',
                                  ).tr(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Sizes.width_100percent(context),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'login',
                                  style: buttonTextStyle(),
                                ).tr(),
                              ),
                              onPressed: () {
                                _formKey.currentState!.validate();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('dont_have_an_account').tr(),
                        TextButton(
                          child: const Text('sign_up_now').tr(),
                          onPressed: () {},
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Assets.facebook),
                            radius: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(Assets.instagram),
                          radius: 22,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(Assets.linkedin),
                          radius: 22,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(Assets.twitter),
                          radius: 22,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
