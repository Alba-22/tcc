import 'package:flutter/material.dart';
import 'package:poc_tcc/widgets/failure_widget.dart';
import 'package:poc_tcc/widgets/notifier_builder.dart';
import 'package:poc_tcc/widgets/sucess_widget.dart';

import 'controller.dart';

class WithStatePage extends StatefulWidget {
  const WithStatePage({Key? key}) : super(key: key);

  @override
  State<WithStatePage> createState() => _WithStatePageState();
}

class _WithStatePageState extends State<WithStatePage> {
  final controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abordagem com Observer Pattern e State Pattern"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: NotifierBuilder(
            controller: controller,
            builder: () {
              final state = controller.state;
              if (state is InfoLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is InfoErrorState) {
                return FailureWidget(message: state.message);
              } else if (state is InfoSuccessState) {
                return SuccessWidget(data: state.successData);
              }
              return const Text("Aperte o botão para fazer a requisição");
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
