import 'package:flutter/material.dart';
import 'package:flutter_todo_list/ui/widget/groups/groups_widget.dart';
import 'package:flutter_todo_list/ui/widget/gruop_form/gruop_form_widget.dart';
import 'package:flutter_todo_list/ui/widget/task_form/task_form_widget.dart';
import 'package:flutter_todo_list/ui/widget/tasks/task_widget.dart';

abstract class MainNavigaitionRouteName {
  static const gruops = '/';
  static const gruopsForm = '/groupsForm';
  static const task = '/task';
  static const taskForm = '/task/form';
}

class MainNavigaition {
  final initialRoute = MainNavigaitionRouteName.gruops;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigaitionRouteName.gruops: (context) => const GroupsWidget(),
    MainNavigaitionRouteName.gruopsForm: (context) => const GruopFormWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigaitionRouteName.task:
        final configuration =
            settings.arguments as TaskWidgetModelConfiguration;
        return MaterialPageRoute(builder: (context) {
          return TaskWidget(
            configuration: configuration,
          );
        });
      case MainNavigaitionRouteName.taskForm:
        final gruopKey = settings.arguments as int;
        return MaterialPageRoute(builder: (context) {
          return TaskFormWidget(
            gruopKey: gruopKey,
          );
        });
      default:
        const widget = Text('Navigation Error !!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
