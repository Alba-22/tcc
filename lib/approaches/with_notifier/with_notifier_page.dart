import 'package:flutter/material.dart';
import 'package:poc_tcc/approaches/with_notifier/controller.dart';
import 'package:poc_tcc/widgets/failure_widget.dart';
import 'package:poc_tcc/widgets/notifier_builder.dart';
import 'package:poc_tcc/widgets/sucess_widget.dart';

class WithNotifierPage extends StatefulWidget {
  const WithNotifierPage({Key? key}) : super(key: key);

  @override
  State<WithNotifierPage> createState() => _WithNotifierPageState();
}

class _WithNotifierPageState extends State<WithNotifierPage> {
  final controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abordagem com Observer Pattern"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: NotifierBuilder(
            controller: controller,
            builder: () {
              if (controller.isLoading) {
                return const CircularProgressIndicator();
              } else if (controller.errorMessage != null) {
                return FailureWidget(message: controller.errorMessage!);
              } else if (controller.successData != null) {
                return SuccessWidget(data: controller.successData!);
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
