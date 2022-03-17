import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key, required this.heroAttribute, required this.child}) : super(key: key);
  final String heroAttribute;
  final Widget child;

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> with SingleTickerProviderStateMixin {
  Animation<Matrix4>? _animation;
  late final AnimationController _animationController;
  TapDownDetails? _tapDownDetails;
  late final TransformationController _transformationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        _transformationController.value = _animation!.value;
      });
    _transformationController = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) => _tapDownDetails = details,
      onDoubleTap: () {
        const double scale = 3;
        final position = _tapDownDetails!.localPosition;
        final x = -position.dx * (scale - 1);
        final y = -position.dy * (scale - 1);
        final zoomed = Matrix4.identity()
          ..translate(x, y)
          ..scale(scale);
        final Matrix4 end = _transformationController.value.isIdentity() ? zoomed : Matrix4.identity();
        _transformationController.value = end;

        _animation = Matrix4Tween(
          begin: _transformationController.value,
          end: end,
        ).animate(CurveTween(curve: Curves.easeOut).animate(_animationController));

        _animationController.forward(from: 0);
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: 0.1,
        maxScale: 4.0,
        child: Hero(
          tag: widget.heroAttribute,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
