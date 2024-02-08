import 'package:flutter/material.dart';

import '../adhoc/adhoc_page.dart';
import '../sealed/sealed_page.dart';
import '../with_notifier/with_notifier_page.dart';
import '../with_state/with_state_page.dart';

class ApproachesListPage extends StatelessWidget {
  const ApproachesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Representation"),
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
                  MaterialPageRoute(builder: (context) => const AdhocPage()),
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
                  MaterialPageRoute(builder: (context) => const WithNotifierPage()),
                );
              },
              child: const Text("With Notifier"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WithStatePage()),
                );
              },
              child: const Text("With State"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SealedPage()),
                );
              },
              child: const Text("With Sealed"),
            ),
          ],
        ),
      ),
    );
  }
}
