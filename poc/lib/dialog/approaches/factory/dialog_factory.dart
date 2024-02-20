import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poc_tcc/dialog/approaches/factory/android_dialog.dart';
import 'package:poc_tcc/dialog/approaches/factory/base_dialog.dart';
import 'package:poc_tcc/dialog/approaches/factory/ios_dialog.dart';

class DialogFactory {
  static Future<T?> showAlertDialog<T>(
    BuildContext context, {
    required String title,
    required String content,
    required List<DialogAction> actions,
  }) {
    BaseDialog dialog;
    if (Platform.isIOS) {
      dialog = IosDialog();
    } else {
      dialog = AndroidDialog();
    }

    return showDialog<T>(
      context: context,
      builder: (context) {
        return dialog.create(context, title, content, actions);
      },
    );
  }
}
