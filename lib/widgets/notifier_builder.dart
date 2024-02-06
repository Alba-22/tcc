import 'package:flutter/material.dart';
import 'package:poc_tcc/common/notifier.dart';

class NotifierBuilder extends StatefulWidget {
  final Notifier controller;
  final Widget Function() builder;

  const NotifierBuilder({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  State<NotifierBuilder> createState() => _NotifierBuilderState();
}

class _NotifierBuilderState extends State<NotifierBuilder> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  void listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }
}
