import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/domain/data_provider/box_manager.dart';
import 'package:flutter_todo_list/domain/entity/gruop.dart';
import 'package:flutter_todo_list/ui/navigaition/main_navigation.dart';
import 'package:flutter_todo_list/ui/widget/tasks/task_widget.dart';
import 'package:hive_flutter/adapters.dart';

class GruopsWidgetModel extends ChangeNotifier {
  late final Future<Box<Gruop>> _box;
  ValueListenable<Object>? _listenableBox;

  var _gruops = <Gruop>[];
  List<Gruop> get gruops => _gruops.toList();
  GruopsWidgetModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigaitionRouteName.gruopsForm);
  }

  Future<void> showTask(BuildContext context, int gruopIndex) async {
    final gruop = (await _box).getAt(gruopIndex);
    if (gruop != null) {
      final configuration =
          TaskWidgetModelConfiguration(gruop.key as int, gruop.name);

      unawaited(
        Navigator.of(context)
            .pushNamed(MainNavigaitionRouteName.task, arguments: configuration),
      );
    }
  }

  Future<void> readBoxFromHive() async {
    _gruops = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> deleteGruop(int gruopIndex) async {
    final box = await _box;
    final gruopKey = (await _box).keyAt(gruopIndex) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(gruopKey);
    Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(gruopIndex);
  }

  void _setup() async {
    _box = BoxManager.instance.openGroupBox();
    await readBoxFromHive();
    _listenableBox =(await _box).listenable(); 
    _listenableBox?.addListener(readBoxFromHive);
  }
  @override
 Future<void> dispose()async {
    _listenableBox?.removeListener(readBoxFromHive);
   await BoxManager.instance.closeBox((await _box));
    super.dispose();
  }
}

class GruopsWidgetModelProvider extends InheritedNotifier {
  final GruopsWidgetModel model;
  const GruopsWidgetModelProvider(
      {super.key, required this.model, required this.child})
      : super(child: child, notifier: model);

  final Widget child;

  static GruopsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GruopsWidgetModelProvider>();
  }

  static GruopsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GruopsWidgetModelProvider>()
        ?.widget;
    return widget is GruopsWidgetModelProvider ? widget : null;
  }
}
