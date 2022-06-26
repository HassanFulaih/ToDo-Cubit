import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

class BuildTaskItem extends StatelessWidget {
  const BuildTaskItem({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    required this.id,
  }) : super(key: key);

  final int id;
  final String title;
  final String date;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id.toString()),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to delete this task?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$title removed successfully')));

                  AppCubit.get(context).deleteData(id);
                },
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Colors.red[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(width: 4),
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 6),
            Text('Delete', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[400],
          child: Text(
            title[0],
            style: const TextStyle(color: Colors.black),
          ),
        ),
        title: Text('$title | $time'),
        subtitle: Text(date),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData('done', id);
              },
              icon: Icon(Icons.check_box, color: Colors.green[300]),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData('archived', id);
              },
              icon: Icon(Icons.archive, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
