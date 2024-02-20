import 'package:flutter/material.dart';

abstract interface class BaseDialog {
  Widget create(BuildContext context, String title, String content, List<DialogAction> actions);
}

class DialogAction {
  String text;
  void Function() onPressed;

  DialogAction({
    required this.text,
    required this.onPressed,
  });
}
