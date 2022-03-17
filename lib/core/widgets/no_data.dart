import 'package:atalay/core/base/view/base_view.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({Key? key, required this.text, required this.image, this.fun}) : super(key: key);
  final String text;
  final String image;
  final void Function()? fun;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (context, value) => _Body(
        text: text,
        image: image,
        fun: fun,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.text, required this.image, this.fun}) : super(key: key);
  final String text;
  final String image;
  final void Function()? fun;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: fun,
            child: Image.asset(
              image,
              scale: 5,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
