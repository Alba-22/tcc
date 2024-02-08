import 'package:flutter/material.dart';
import 'package:poc_tcc/form/approaches/proposal/custom_text_field.dart';
import 'package:poc_tcc/form/approaches/proposal/form_manager.dart';
import 'package:poc_tcc/form/utils/notifier_builder.dart';
import 'package:poc_tcc/form/utils/validator.dart';
import 'package:poc_tcc/form/widgets/custom_button.dart';

class FormProposalPage extends StatefulWidget {
  const FormProposalPage({Key? key}) : super(key: key);

  @override
  State<FormProposalPage> createState() => _FormProposalPageState();
}

class _FormProposalPageState extends State<FormProposalPage> {
  final formManager = FormManager();

  @override
  void initState() {
    super.initState();
    formManager.setForms({
      "email": FormObjectParameters(
        label: "E-mail",
        validator: (v) => Validator(v).isEmailValid().build(),
      ),
      "password": FormObjectParameters(
        label: "Senha",
        validator: (v) => Validator(v).minLength(12).isPasswordValid().isRequired().build(),
      ),
      "confirm_password": FormObjectParameters(
        label: "Confirmar Senha",
        validator: (v) => Validator(v)
            .isEqualTo(formManager.forms["password"]!.controller.text, "As senhas devem ser iguais")
            .isRequired()
            .build(),
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Proposal"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: NotifierBuilder(
          controller: formManager,
          builder: () {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(form: formManager.forms["email"]!),
                const SizedBox(height: 12),
                CustomTextField(form: formManager.forms["password"]!),
                const SizedBox(height: 12),
                CustomTextField(form: formManager.forms["confirm_password"]!),
                const SizedBox(height: 24),
                CustomButton(
                  text: "Entrar",
                  width: double.infinity,
                  isDisabled: !formManager.isValid,
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
