import 'package:flutter/material.dart';
import 'package:flutter_todo_list/domain/data_provider/box_manager.dart';
import 'package:flutter_todo_list/domain/entity/gruop.dart';

class GruopFormWidgetModel extends ChangeNotifier {
  var _nameGroup = '';
  String? errorText;

  set nameGroup(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _nameGroup = value;
  }

  void saveGruop(BuildContext context) async {
    final nameGroup = _nameGroup.trim();
    if (nameGroup.isEmpty) {
      errorText = 'Enter name of gruop';
      notifyListeners();
      return;
    }

    final box = await BoxManager.instance.openGroupBox();
    final gruop = Gruop(name: nameGroup);
    await box.add(gruop);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}

class GruopFormWidgetModelProvider extends InheritedNotifier {
  final GruopFormWidgetModel model;
  const GruopFormWidgetModelProvider(
      {super.key, required this.model, required this.child})
      : super(
          child: child,
          notifier: model,
        );

  final Widget child;

  static GruopFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GruopFormWidgetModelProvider>();
  }

  static GruopFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GruopFormWidgetModelProvider>()
        ?.widget;
    return widget is GruopFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GruopFormWidgetModelProvider oldWidget) {
    return false;
  }
}
