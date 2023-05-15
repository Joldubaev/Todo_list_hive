import 'package:flutter/material.dart';
import 'package:flutter_todo_list/ui/widget/app/my_app.dart';
import 'package:hive_flutter/adapters.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}



