
import 'package:hive_flutter/adapters.dart';
part 'gruop.g.dart';

@HiveType(typeId: 1)
class Gruop extends HiveObject {
  // last used key   @HiveField(1)
  @HiveField(0)
  String name;

  // @HiveField(1)
  // HiveList<Task>? task;

  Gruop({required this.name});

  // void addTask(Box<Task> box, Task tasks) {
  //   task ??= HiveList(box);
  //   task?.add(tasks);
  //   save();
  // }
}
