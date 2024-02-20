import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdhocDialogPage extends StatefulWidget {
  const AdhocDialogPage({Key? key}) : super(key: key);

  @override
  State<AdhocDialogPage> createState() => _AdhocDialogPageState();
}

class _AdhocDialogPageState extends State<AdhocDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adhoc Dialog"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Aperte para abrir o Dialog"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                if (Platform.isIOS) {
                  return CupertinoAlertDialog(
                    title: const Text("Confirmação Necessária"),
                    content: const Text("Deseja confirmar a operação?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Sim"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Não"),
                      ),
                    ],
                  );
                } else {
                  return AlertDialog(
                    title: const Text("Confirmação Necessária"),
                    content: const Text("Deseja confirmar a operação?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Sim"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Não"),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
