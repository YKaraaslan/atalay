import 'dart:developer';

import 'package:atalay/core/base/view/base_viewmodel.dart';
import 'package:atalay/core/base/view/connection/no_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T> extends StatefulWidget {
  const BaseView(
      {Key? key,
      required this.onPageBuilder,
      this.viewModel,
      this.onModelReady,
      this.onDispose,
      this.backgroundColor,
      this.appBar,
      this.bottomNavigationBar,
      this.drawer,
      this.floatingActionButton})
      : super(key: key);

  final Widget Function(BuildContext context, T value) onPageBuilder;
  final T? viewModel;
  final Function(T model)? onModelReady;
  final VoidCallback? onDispose;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Drawer? drawer;
  final FloatingActionButton? floatingActionButton;

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  late final BaseViewModel _viewModel = context.read<BaseViewModel>();

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) widget.onModelReady!(widget.viewModel);
    _viewModel.initStates();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) widget.onDispose!();
    _viewModel.subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    log('BUILD');
    return Consumer(
      builder: (context, BaseViewModel _viewModel, child) => Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: widget.bottomNavigationBar,
        drawer: widget.drawer,
        floatingActionButton: widget.floatingActionButton,
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: _viewModel.connected == true
            ? widget.onPageBuilder(context, widget.viewModel)
            : const NoConnectionView(),
      ),
    );
  }
}
