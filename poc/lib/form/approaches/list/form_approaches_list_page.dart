import 'package:flutter/material.dart';
import 'package:poc_tcc/form/approaches/adhoc/adhoc_form_page.dart';
import 'package:poc_tcc/form/approaches/example/form_example_page.dart';
import 'package:poc_tcc/form/approaches/proposal/form_proposal_page.dart';

class FormApproachesListPage extends StatefulWidget {
  const FormApproachesListPage({Key? key}) : super(key: key);

  @override
  State<FormApproachesListPage> createState() => _FormApproachesListPageState();
}

class _FormApproachesListPageState extends State<FormApproachesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forms and Validation"),
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
                  MaterialPageRoute(builder: (context) => const FormExamplePage()),
                );
              },
              child: const Text("Example"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 48)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdhocFormPage()),
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
                  MaterialPageRoute(builder: (context) => const FormProposalPage()),
                );
              },
              child: const Text("Proposal"),
            ),
          ],
        ),
      ),
    );
  }
}
