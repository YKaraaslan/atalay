import 'package:atalay/core/base/view/app_widget.dart';
import 'package:atalay/core/base/view/base_view.dart';
import 'package:atalay/core/constant/assets.dart';
import 'package:atalay/core/constant/paddings.dart';
import 'package:atalay/core/constant/sizes.dart';
import 'package:atalay/core/constant/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      backgroundColor: Theme.of(context).primaryColor,
      onPageBuilder: (context, value) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppWidget(
            child: SizedBox(
              height: Sizes.height_35percent(context),
              width: Sizes.width_50percent(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SvgPicture.asset(Assets.login_background),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppPaddings.appPadding,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: SizedBox(
                  width: Sizes.width_100percent(context),
                  child: Padding(
                    padding: AppPaddings.contentPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('login_title', style: titleStyle(context),).tr(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
