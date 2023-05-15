import 'package:flutter/material.dart';
import 'package:flutter_todo_list/ui/widget/gruop_form/gruop_form_widget_model.dart';

class GruopFormWidget extends StatefulWidget {
  const GruopFormWidget({super.key});

  @override
  State<GruopFormWidget> createState() => _GruopFormWidgetState();
}

class _GruopFormWidgetState extends State<GruopFormWidget> {
  final _model = GruopFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GruopFormWidgetModelProvider(
        model: _model, child: const _GruopFormWidgetBody());
  }
}

class _GruopFormWidgetBody extends StatelessWidget {
  const _GruopFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Gruop')),
      body: Center(
        child: Container(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _GruopNameWidget(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GruopFormWidgetModelProvider.read(context)
            ?.model
            .saveGruop(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GruopNameWidget extends StatelessWidget {
  const _GruopNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GruopFormWidgetModelProvider.watch(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Name Gruop',
        errorText: model?.errorText,
      ),
      onChanged: (value) => model?.nameGroup = value,
      onEditingComplete: () => model?.saveGruop(context),
    );
  }
}
