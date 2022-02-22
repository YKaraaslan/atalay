import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/assets.dart';
import '../../../core/constant/paddings.dart';
import '../../../core/constant/sizes.dart';
import '../../../core/constant/styles.dart';

class UnauthorizedBaseView extends StatelessWidget {
  const UnauthorizedBaseView({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: Sizes.height_35percent(context),
              width: Sizes.width_100percent(context),
              child: Image(
                image: AssetImage(Assets.loginBackground),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: Sizes.width_100percent(context),
              margin: EdgeInsets.only(top: Sizes.height_30percent(context)),
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
                      child:
                          Text('login_title', style: titleStyle(context)).tr(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    child,
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
