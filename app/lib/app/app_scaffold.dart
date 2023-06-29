import 'package:flutter/material.dart';
import 'package:mtw_app/app/app_drawer.dart';

import '../utils/notifier.dart';

typedef OnScaffoldChanged<T> = Function(T sender, ScaffoldListenerArgs? args);

class AppScaffold extends StatefulWidget with Notifier {
  final Widget child;

  final AppDrawer drawer;
  AppScaffold({super.key, required this.child, required this.drawer});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();

  void setActions(List<Widget> actions) {
    notify(this, ScaffoldListenerArgs(actions));
  }

  static AppScaffold? maybeOf(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppScaffold>();
  }

  static AppScaffold of(BuildContext context) {
    final AppScaffold? result = maybeOf(context);
    assert(result != null, 'No AppActionBar found in context');
    return result!;
  }
}

class OnActionBarChangedNotifierListener<T>
    extends NotifierListener<T, ScaffoldListenerArgs> {
  OnActionBarChangedNotifierListener(OnScaffoldChanged callback)
      : super(callback);
}

class ScaffoldListenerArgs extends NotifierListenerArgs {
  final List<Widget> actions;

  const ScaffoldListenerArgs(this.actions);
}

class _AppScaffoldState extends State<AppScaffold> {
  List<Widget> _actions = const [];

  late var listener = OnActionBarChangedNotifierListener((sender, args) {
    if (args?.actions != _actions) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            _actions = args!.actions;
          }));
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        title: const Text('Mapping the World'),
        actions: _actions,
      ),
      body: widget.child,
    );
  }

  @override
  void dispose() {
    widget.removeListener(listener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.addListener(listener);
  }
}
