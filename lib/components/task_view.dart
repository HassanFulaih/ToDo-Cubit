import 'package:flutter/material.dart';

import 'task_item.dart';

class TaskView extends StatelessWidget {
  const TaskView(this.tasks, {Key? key}) : super(key: key);

  final List<Map<dynamic, dynamic>> tasks;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Text('No tasks yet, please add some!'),
          )
        : ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return BuildTaskItem(
                id: tasks[index]['id'],
                title: tasks[index]['title'],
                date: tasks[index]['date'],
                time: tasks[index]['time'],
                status: tasks[index]['status'],
              );
            },
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey[300], thickness: 2),
          );
  }
}
