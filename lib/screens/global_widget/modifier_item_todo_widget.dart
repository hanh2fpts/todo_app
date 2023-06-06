import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class ModifierItemTodoWidget extends StatefulWidget {
  const ModifierItemTodoWidget({super.key});
  @override
  State<ModifierItemTodoWidget> createState() => _ModifierItemTodoWidgetState();
}

class _ModifierItemTodoWidgetState extends State<ModifierItemTodoWidget> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  var id = const Uuid().v4();
  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments;
    if (item != null) {
      titleController.text = (item as TodoModel).title.toString();
      descriptionController.text = item.description.toString();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: item == null ? const Text('Add New Todo') : const Text('Tods Details'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: BlocListener<OverviewCubit, OverviewState>(
        listener: (context, state) {
          if (state.status == OverviewStatus.success) {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [_TitleField(titleController), _DescriptionField(descriptionController)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            item == null
                ? context.read<OverviewCubit>().addTodo(TodoModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      id: id,
                    ))
                : context.read<OverviewCubit>().modifierTask(TodoModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: (item as TodoModel).id));
          },
          child: const Icon(Icons.check)),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Enter title',
        enabled: true,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter decription',
        enabled: true,
      ),
      maxLength: 200,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(200),
      ],
    );
  }
}
