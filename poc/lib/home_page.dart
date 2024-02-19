import 'package:flutter/material.dart';
import 'package:poc_tcc/dialog/approaches/list/dialog_approaches_list_page.dart';
import 'package:poc_tcc/form/approaches/list/form_approaches_list_page.dart';
import 'package:poc_tcc/state/approaches/approaches_list/approaches_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POC TCC"),
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
                  MaterialPageRoute(builder: (context) => const ApproachesListPage()),
                );
              },
              child: const Text("State Representation"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormApproachesListPage()),
                );
              },
              child: const Text("Forms and Validation"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DialogApproachesListPage()),
                );
              },
              child: const Text("Dialog"),
            ),
          ],
        ),
      ),
    );
  }
}
