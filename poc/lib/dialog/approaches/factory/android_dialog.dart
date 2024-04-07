import 'package:flutter/material.dart';

import 'base_dialog.dart';

class AndroidDialog<T> implements BaseDialog {
  @override
  Future<T?> show(
    BuildContext context, {
    required String title,
    required String content,
    required List<DialogAction> actions,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
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
      },
    );
  }
}
