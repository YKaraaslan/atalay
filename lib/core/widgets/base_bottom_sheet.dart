import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    Key? key,
  }) : super(key: key);

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
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.report_problem_outlined,
                  color: Colors.orange[300],
                ),
                title: Text('report'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
