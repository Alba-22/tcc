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
        hide: false,
        validator: (v) => Validator(v).minLength(12).isPasswordValid().isRequired().build(),
      ),
      "confirm_password": FormObjectParameters(
        label: "Confirmar Senha",
        hide: false,
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
                CustomTextField(forms: formManager.forms, formRef: "email"),
                const SizedBox(height: 12),
                CustomTextField(forms: formManager.forms, formRef: "password"),
                const SizedBox(height: 12),
                CustomTextField(forms: formManager.forms, formRef: "confirm_password"),
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

// mixin FormMixin {
//   final Map<String, FormObject> _forms = {};

//   void setForms(Map<String, FOInput> input, VoidCallback onChange) {
//     for (final i in input.entries) {
//       _forms.addAll({
//         i.key: FormObject(
//           label: i.value.label,
//           validator: i.value.validator,
//           controller: TextEditingController(),
//           onChange: (p0) {
//             checkIsValid();
//             onChange();
//           },
//         ),
//       });
//     }
//   }

//   void checkIsValid() {
//     for (final item in _forms.entries) {
//       if (item.value.validator(item.value.controller.text) != null) {
//         _isValid = false;
//         return;
//       }
//     }
//     _isValid = true;
//     return;
//   }

//   Map<String, FormObject> get forms => _forms;

//   bool _isValid = false;

//   bool get isValid => _isValid;
// }

// typedef FOInput = ({
//   String label,
//   String? Function(String?) validator,
// });

// class FormObject {
//   final String label;
//   final String? Function(String?) validator;
//   final TextEditingController controller;
//   final void Function(String?) onChange;

//   FormObject({
//     required this.label,
//     required this.validator,
//     required this.controller,
//     required this.onChange,
//   });
// }
