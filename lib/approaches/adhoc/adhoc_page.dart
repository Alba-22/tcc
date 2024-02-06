import 'package:flutter/material.dart';
import 'package:poc_tcc/model/success_model.dart';
import 'package:poc_tcc/repository/get_information_from_network.dart';
import 'package:poc_tcc/widgets/failure_widget.dart';
import 'package:poc_tcc/widgets/sucess_widget.dart';

import '../../model/error_exception.dart';

class AdhocPage extends StatefulWidget {
  const AdhocPage({Key? key}) : super(key: key);

  @override
  State<AdhocPage> createState() => _AdhocPageState();
}

class _AdhocPageState extends State<AdhocPage> {
  bool isLoading = false;
  String? errorMessage;
  SuccessModel? successData;

  Future<void> getInformation() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
        successData = null;
      });
      final result = await getInformationFromNetwork();
      setState(() {
        successData = result;
        isLoading = false;
      });
    } on ErrorException catch (exception) {
      setState(() {
        errorMessage = exception.message;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abordagem Adhoc"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              FailureWidget(message: errorMessage!)
            else if (successData != null)
              SuccessWidget(data: successData!)
            else
              const Text("Aperte o botão para fazer a requisição"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getInformation();
        },
      ),
    );
  }
}
