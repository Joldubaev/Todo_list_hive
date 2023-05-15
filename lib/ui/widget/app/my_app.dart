import 'package:flutter/material.dart';
import 'package:flutter_todo_list/ui/navigaition/main_navigation.dart';

class MyApp extends StatelessWidget {
  static final mainNavigaition = MainNavigaition();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: mainNavigaition.routes,
      initialRoute: mainNavigaition.initialRoute,
      onGenerateRoute: mainNavigaition.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
