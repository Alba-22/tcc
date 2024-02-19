import 'package:flutter/material.dart';
import 'package:poc_tcc/dialog/approaches/adhoc/adhoc_dialog_page.dart';
import 'package:poc_tcc/dialog/approaches/factory/factory_dialog_page.dart';

class DialogApproachesListPage extends StatefulWidget {
  const DialogApproachesListPage({Key? key}) : super(key: key);

  @override
  State<DialogApproachesListPage> createState() => _DialogApproachesListPageState();
}

class _DialogApproachesListPageState extends State<DialogApproachesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dialogs"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdhocDialogPage()),
                );
              },
              child: const Text("Adhoc"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FactoryDialogPage()),
                );
              },
              child: const Text("Factory"),
            ),
          ],
        ),
      ),
    );
  }
}
