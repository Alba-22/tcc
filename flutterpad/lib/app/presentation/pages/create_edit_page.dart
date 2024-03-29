import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterpad/app/core/components/custom_app_bar.dart';
import 'package:flutterpad/app/core/components/custom_bottom_container.dart';
import 'package:flutterpad/app/core/components/custom_button.dart';
import 'package:flutterpad/app/core/components/custom_text_field.dart';
import 'package:flutterpad/app/core/di/di.dart';
import 'package:flutterpad/app/core/utils/custom_colors.dart';
import 'package:flutterpad/app/core/utils/form_manager.dart';
import 'package:flutterpad/app/core/utils/notifier_builder.dart';
import 'package:flutterpad/app/core/utils/validators.dart';
import 'package:flutterpad/app/domain/entities/task_entity.dart';
import 'package:flutterpad/app/presentation/stores/create_edit_store.dart';
import 'package:flutterpad/app/presentation/stores/get_tasks_store.dart';
import 'package:flutterpad/app/presentation/stores/synchronize_store.dart';
import 'package:intl/intl.dart';

class CreateEditPage extends StatefulWidget {
  final TaskEntity? task;

  const CreateEditPage({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<CreateEditPage> createState() => _CreateEditPageState();
}

class _CreateEditPageState extends State<CreateEditPage> {
  final formManager = FormManager();

  final store = locator.get<CreateEditStore>();
  final getStore = locator.get<GetTasksStore>();
  final syncStore = locator.get<SynchronizeStore>();

  @override
  void initState() {
    super.initState();
    formManager.setForms({
      "title": FormObjectParameters(
        label: "Título",
        placeholder: "Título da Tarefa",
        initialValue: widget.task?.text,
        validator: (value) => Validator(value).isRequired().maxLength(80).build(),
      ),
      "date": FormObjectParameters(
        label: "Data",
        placeholder: "XX/XX/XXXX",
        initialValue:
            widget.task != null ? DateFormat("dd/MM/yyyy").format(widget.task!.date) : null,
        validator: (value) => Validator(value).isRequired().isDateValid().build(),
      ),
      "time": FormObjectParameters(
        label: "Hora",
        placeholder: "XX:XX",
        initialValue: widget.task != null
            ? "${widget.task!.date.hour.toString().padLeft(2, "0")}:${widget.task!.date.minute.toString().padLeft(2, "0")}"
            : null,
        validator: (value) => Validator(value).isRequired().isHourValid().build(),
      ),
      "description": FormObjectParameters(
        label: "Anotação",
        placeholder: "Descreva a tarefa",
        totalLines: 5,
        initialValue: widget.task?.description,
        validator: (value) => Validator(value).maxLength(200).build(),
      ),
    });
    store.addListener(createEditListener);
  }

  void createEditListener() {
    final state = store.state;
    if (state is CreateEditTaskSuccessState) {
      getStore.getTasks();
      syncStore.synchronize();
      Navigator.pop(context);
    } else if (state is CreateEditTaskErrorState) {
      // TODO: error component
      log(state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Column(
        children: [
          CustomAppBar(text: widget.task != null ? "Editar Tarefa" : "Nova Tarefa"),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    CustomTextField(
                      form: formManager.forms["title"]!,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            form: formManager.forms["date"]!,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomTextField(
                            form: formManager.forms["time"]!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      form: formManager.forms["description"]!,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          CustomBottomContainer(
            child: NotifierBuilder(
              controller: formManager,
              builder: () {
                return NotifierBuilder(
                  controller: store,
                  builder: () {
                    return CustomButton(
                      text: widget.task != null ? "Editar" : "Salvar",
                      isDisabled: !formManager.isValid,
                      isLoading: store.state is CreateEditTaskLoadingState,
                      onTap: () {
                        final forms = formManager.forms;
                        store.createEditTask(
                          forms["title"]!.controller.text,
                          forms["date"]!.controller.text,
                          forms["time"]!.controller.text,
                          forms["description"]!.controller.text,
                          widget.task,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    store.removeListener(createEditListener);
    super.dispose();
  }
}
