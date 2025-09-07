import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();
  factory HiveManager() => _instance;
  HiveManager._internal();

  Box? _taskBox;

  Box? get taskBox => _taskBox;

  Future<void> init() async {
    await Hive.initFlutter(); // mobile initialization
    _taskBox = await Hive.openBox('tasks');
  }

  Future<void> addTask(String name) async {
    if (_taskBox == null) return;
    await _taskBox!.add({'name': name, 'done': false});
  }

  Future<void> toggleDone(int index) async {
    if (_taskBox == null) return;
    final task = _taskBox!.getAt(index) as Map;
    await _taskBox!.putAt(index, {'name': task['name'], 'done': !task['done']});
  }

  Future<void> deleteTask(int index) async {
    if (_taskBox == null) return;
    await _taskBox!.deleteAt(index);
  }

  ValueListenable<Box>? get listenable => _taskBox?.listenable();
}
