import 'package:flutter/material.dart';
import 'package:poc_tcc/dialog/approaches/factory/dialog_specification.dart';

class AndroidDialog implements BaseDialog {
  @override
  Widget create(BuildContext context, String title, String content, List<DialogAction> actions) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions.map<Widget>((e) {
        return TextButton(
          onPressed: e.onPressed,
          child: Text(e.text),
        );
      }).toList(),
    );
  }
}
