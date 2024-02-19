import 'package:flutter/cupertino.dart';
import 'package:poc_tcc/dialog/approaches/factory/dialog_specification.dart';

class IosDialog implements BaseDialog {
  @override
  Widget create(BuildContext context, String title, String content, List<DialogAction> actions) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions.map<Widget>((e) {
        return CupertinoButton(
          onPressed: e.onPressed,
          child: Text(e.text),
        );
      }).toList(),
    );
  }
}
