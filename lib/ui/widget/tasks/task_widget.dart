import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_list/ui/widget/tasks/task_widget_model.dart';

class TaskWidgetModelConfiguration{
  final int gruopKey;
  final String title;
  TaskWidgetModelConfiguration( this.gruopKey, this.title,);
}

class TaskWidget extends StatefulWidget {
  final TaskWidgetModelConfiguration configuration;
  const TaskWidget({super.key, required this.configuration,});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
 late final TaskWidgetModel _model;

@override
void initState() {
  super.initState();
 _model= TaskWidgetModel(configuration: widget.configuration);
}


@override
  void deactivate() async {
  await _model.dispose();
    super.deactivate();
  }
///  old version
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_model == null) {
  //     final gruopKey = ModalRoute.of(context)!.settings.arguments as int;
  //     _model = TaskWidgetModel(gruopKey: gruopKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TaskWidgetModelProvider(
          model: model, child: const TaskWidgetBody());
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? 'Task';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gruopsCpunt =
        TaskWidgetModelProvider.watch(context)?.model.task.length ?? 0;
    return ListView.separated(
      itemCount: gruopsCpunt,
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(
          indexList: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 3,
        );
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexList;
  const _TaskListRowWidget({super.key, required this.indexList});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.read(context)!.model;
    final tasks = model.task[indexList];
    final icon = tasks.isDone ? Icons.done : Icons.portrait;
    final style = tasks.isDone
        ? const TextStyle(
            decoration: TextDecoration.lineThrough,
          )
        : null;
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          // leading: FlutterLogo(),
          title: Text(
            tasks.text,
            style: style,
          ),
          trailing: Icon(icon),
          onTap: () => model.doneToggle(indexList),
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {
    TaskWidgetModelProvider.read(context)!.model.deleteTask(indexList);
  }
}
