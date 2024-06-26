import 'package:flutter/material.dart';
import 'package:poc_tcc/dialog/approaches/factory/base_dialog.dart';
import 'package:poc_tcc/main.dart';

class FactoryDialogPage extends StatefulWidget {
  const FactoryDialogPage({Key? key}) : super(key: key);

  @override
  State<FactoryDialogPage> createState() => _FactoryDialogPageState();
}

class _FactoryDialogPageState extends State<FactoryDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Factory Dialog"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Aperte para abrir o Dialog"),
          onPressed: () {
            dialog.show(
              context,
              title: "Confirmação Necessária",
              content: "Deseja confirmar a operação?",
              actions: [
                DialogAction(text: "Sim", onPressed: () => Navigator.pop(context)),
                DialogAction(text: "Não", onPressed: () => Navigator.pop(context)),
              ],
            );
          },
        ),
      ),
    );
  }
}
