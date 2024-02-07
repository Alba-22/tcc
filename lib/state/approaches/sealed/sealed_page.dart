import 'package:flutter/material.dart';

import '../../widgets/failure_widget.dart';
import '../../widgets/notifier_builder.dart';
import '../../widgets/sucess_widget.dart';
import 'controller.dart';

class SealedPage extends StatefulWidget {
  const SealedPage({Key? key}) : super(key: key);

  @override
  State<SealedPage> createState() => _SealedPageState();
}

class _SealedPageState extends State<SealedPage> {
  final controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abordagem com Classes Seladas"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: NotifierBuilder(
            controller: controller,
            builder: () {
              return switch (controller.state) {
                InfoInitialState() => const Text("Aperte o botão para fazer a requisição"),
                InfoLoadingState() => const CircularProgressIndicator(),
                InfoErrorState(message: final msg) => FailureWidget(message: msg),
                InfoSuccessState(successData: final data) => SuccessWidget(data: data),
              };
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getInformation();
        },
      ),
    );
  }
}
