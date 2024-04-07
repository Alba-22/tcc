import 'package:flutter/material.dart';

abstract interface class BaseDialog<T> {
  Future<T?> show(
    BuildContext context, {
    required String title,
    required String content,
    required List<DialogAction> actions,
  });
}

class DialogAction {
  String text;
  void Function() onPressed;

  DialogAction({
    required this.text,
    required this.onPressed,
  });
}
