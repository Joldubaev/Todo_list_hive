import 'package:flutter/material.dart';
import 'package:flutter_todo_list/domain/data_provider/box_manager.dart';
import 'package:flutter_todo_list/domain/entity/task.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  int gruopKey;
  var _textTask = '';
  bool get isValid => _textTask.trim().isNotEmpty;

  set textTask(String value){
    final isTaskTextEmpty = _textTask.trim().isEmpty;
    _textTask =value;
    if(value.trim().isEmpty != isTaskTextEmpty){
      notifyListeners();

    }
  }

  TaskFormWidgetModel({
    required this.gruopKey,
  });

  void saveTask(BuildContext context) async {
    final textTask = _textTask.trim();
    if (_textTask.isEmpty) return;

    final task = Task(isDone: false, text: textTask);
    final box = await BoxManager.instance.openTaskpBox(gruopKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;
  const TaskFormWidgetModelProvider(
      {super.key, required this.model, required this.child})
      : super(child: child, notifier: model);

  final Widget child;

  static TaskFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider oldWidget) {
    return false;
  }
}
