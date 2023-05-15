import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_list/ui/widget/groups/groups_widget_model.dart';


class GroupsWidget extends StatefulWidget {
  const GroupsWidget({super.key});

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GruopsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GruopsWidgetModelProvider(
        model: _model, child: const _GroupsWidgetBody());
  }
  @override
  void deactivate() async{
   await _model.dispose();
    super.deactivate();
  }
}


class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group'),
      ),
      body: const _GruopListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GruopsWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GruopListWidget extends StatelessWidget {
  const _GruopListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gruopsCpunt =
        GruopsWidgetModelProvider.watch(context)?.model.gruops.length ?? 0;
    return ListView.separated(
      itemCount: gruopsCpunt,
      itemBuilder: (BuildContext context, int index) {
        return _GruopListRowWidget(
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

class _GruopListRowWidget extends StatelessWidget {
  final int indexList;
  const _GruopListRowWidget({super.key, required this.indexList});

  @override
  Widget build(BuildContext context) {
    final model = GruopsWidgetModelProvider.read(context)!.model;
    final gruop = model.gruops[indexList];
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
          title: Text(gruop.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => model.showTask(context, indexList),
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {
    GruopsWidgetModelProvider.read(context)!.model.deleteGruop(indexList);
  }
}
