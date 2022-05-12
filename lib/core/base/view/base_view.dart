import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_viewmodel.dart';
import 'connection/no_connection.dart';

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
  State<BaseView> createState() => _BaseViewState();
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
    return Consumer(
      builder: (context, BaseViewModel viewModel, child) => Scaffold(
        appBar: widget.appBar,
        bottomNavigationBar: widget.bottomNavigationBar,
        drawer: widget.drawer,
        floatingActionButton: widget.floatingActionButton,
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: viewModel.connected == true
            ? widget.onPageBuilder(context, widget.viewModel)
            : const NoConnectionView(),
      ),
    );
  }
}
