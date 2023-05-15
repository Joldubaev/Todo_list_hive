import 'package:flutter/material.dart';
import 'package:flutter_todo_list/ui/widget/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final int gruopKey;

  const TaskFormWidget({super.key, required this.gruopKey});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormWidgetModel(gruopKey: widget.gruopKey);
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
      model: _model,
      child: const _TeksFormWidgetBody(),
    );
  }
}

class _TeksFormWidgetBody extends StatelessWidget {
  const _TeksFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.watch(context)?.model;
    final actionButton = FloatingActionButton(
      onPressed: () => model?.saveTask(context),
      child: const Icon(Icons.done),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _TaksNameWidget(),
          ),
        ),
      ),
      floatingActionButton: model?.isValid == true ? actionButton : null,
    );
  }
}

class _TaksNameWidget extends StatelessWidget {
  const _TaksNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Task Name',
      ),
      onChanged: (value) => model?.textTask = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
