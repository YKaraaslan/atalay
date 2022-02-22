import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: widget.child,
      tween: Tween<double>(begin: 50, end: 0),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      builder: (BuildContext _context, double _value, Widget? _child) {
        return Padding(
          padding: EdgeInsets.only(top: _value.toDouble()),
          child: _child,
        );
      },
    );
  }
}
