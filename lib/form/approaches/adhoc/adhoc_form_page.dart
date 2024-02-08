import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:poc_tcc/form/widgets/custom_button.dart';

class AdhocFormPage extends StatefulWidget {
  const AdhocFormPage({Key? key}) : super(key: key);

  @override
  State<AdhocFormPage> createState() => _AdhocFormPageState();
}

class _AdhocFormPageState extends State<AdhocFormPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isValid = false;

  void checkFields() {
    if (validateEmail(emailController.text) != null ||
        validatePassword(passwordController.text) != null ||
        validateEquality(passwordController.text, confirmPasswordController.text) != null) {
      isValid = false;
    } else {
      isValid = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adhoc Forms"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("E-mail"),
                  border: OutlineInputBorder(),
                ),
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validateEmail(value);
                },
                onChanged: (value) {
                  checkFields();
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Senha"),
                  border: OutlineInputBorder(),
                ),
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validatePassword(value);
                },
                onChanged: (value) {
                  checkFields();
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Confirmar Senha"),
                  border: OutlineInputBorder(),
                ),
                controller: confirmPasswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return validateEquality(value, passwordController.text);
                },
                onChanged: (value) {
                  checkFields();
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Entrar",
                width: double.infinity,
                isDisabled: !isValid,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    List<String> errors = [];
    if (value == null || value.isEmpty) {
      errors.add("O campo é obrigatório.");
    }
    if ((value?.length ?? 0) < 12) {
      errors.add("A senha deve conter ao menos 12 caracteres!");
    }
    if (!RegExp(r"^(?!.*\s)(?=.*\d)(?=.*[a-zA-Z]).+$").hasMatch(value ?? "")) {
      errors.add("A senha deve ter números e letras!");
    }
    return errors.isEmpty ? null : errors.join("\n");
  }

  String? validateEquality(String? value1, String value2) {
    if (value1 != value2) {
      return "Valores devem ser iguais";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!EmailValidator.validate(value)) {
      return "E-mail inválido";
    }
    return null;
  }
}
