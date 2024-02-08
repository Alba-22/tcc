import 'package:flutter/material.dart';
import 'package:poc_tcc/form/widgets/custom_button.dart';

class FormExamplePage extends StatefulWidget {
  const FormExamplePage({Key? key}) : super(key: key);

  @override
  State<FormExamplePage> createState() => _FormExamplePageState();
}

class _FormExamplePageState extends State<FormExamplePage> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exemplo de Formulário")),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.isEmpty ?? false) return "Preencha o campo";
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Registrar",
              onTap: () {
                if (formKey.currentState?.validate() ?? false) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
