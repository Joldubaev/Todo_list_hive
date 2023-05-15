import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/domain/data_provider/box_manager.dart';
import 'package:flutter_todo_list/domain/entity/task.dart';
import 'package:flutter_todo_list/ui/navigaition/main_navigation.dart';
import 'package:flutter_todo_list/ui/widget/tasks/task_widget.dart';
import 'package:hive_flutter/adapters.dart';

class TaskWidgetModel extends ChangeNotifier {
  TaskWidgetModelConfiguration configuration;

  ValueListenable<Object>? _listenableBox;

  late final Future<Box<Task>> _box;
  var _tasks = <Task>[];
  List<Task> get task => _tasks.toList();

  TaskWidgetModel({required this.configuration}) {
    _setup();
  }

  // void _readTask() {
  //   _tasks = _gruop?.task ?? <Task>[];
  //   notifyListeners();
  // }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigaitionRouteName.taskForm,
        arguments: configuration.gruopKey);
  }

  // void _setupListenTasks() async {
  //   final box = await _gruopBox;
  //   _readTask();
  //   box.listenable(keys: <dynamic>[gruopKey]).addListener(_readTask);
  // }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  Future<void> readTaskFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskpBox(configuration.gruopKey);
    await readTaskFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(readTaskFromHive);
  }

  @override
  Future<void>dispose() async {
    _listenableBox?.removeListener(readTaskFromHive);
    await BoxManager.instance.closeBox((await _box));
    super.dispose();
  }
}

class TaskWidgetModelProvider extends InheritedNotifier {
  final TaskWidgetModel model;
  const TaskWidgetModelProvider(
      {super.key, required this.model, required this.child})
      : super(child: child, notifier: model);

  final Widget child;

  static TaskWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskWidgetModelProvider>();
  }

  static TaskWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskWidgetModelProvider>()
        ?.widget;
    return widget is TaskWidgetModelProvider ? widget : null;
  }
}
