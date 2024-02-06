import 'dart:math';

import '../model/success_model.dart';
import '../model/error_exception.dart';

Future<SuccessModel> getInformationFromNetwork() async {
  await Future.delayed(const Duration(seconds: 2));
  final isError = Random().nextInt(10) % 2 == 0;
  if (isError) {
    throw ErrorException("Ocorreu um erro ao buscar os dados");
  }
  return SuccessModel("Informação de sucesso!");
}
