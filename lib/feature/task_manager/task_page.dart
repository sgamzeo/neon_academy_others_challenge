import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neon_others_challenge/core/helper/hive_manager.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _taskController = TextEditingController();
  final hiveManager = HiveManager();

  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    // initialize hive box safely
    _initFuture = hiveManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final box = hiveManager.taskBox;

        if (box == null) {
          return Scaffold(body: Center(child: Text('box not initialized')));
        }

        return Scaffold(
          appBar: AppBar(title: Text('TaskMaster')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(labelText: 'new task'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        final text = _taskController.text.trim();
                        if (text.isEmpty) return;
                        await hiveManager.addTask(text);
                        _taskController.clear();
                        setState(() {}); // refresh UI
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box b, _) {
                      if (b.isEmpty) {
                        return Center(child: Text('no tasks added yet'));
                      }
                      return ListView.builder(
                        itemCount: b.length,
                        itemBuilder: (context, index) {
                          final task = b.getAt(index) as Map;
                          return ListTile(
                            title: Text(
                              task['name'],
                              style: TextStyle(
                                decoration: task['done']
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            leading: Checkbox(
                              value: task['done'],
                              onChanged: (_) async {
                                await hiveManager.toggleDone(index);
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await hiveManager.deleteTask(index);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
