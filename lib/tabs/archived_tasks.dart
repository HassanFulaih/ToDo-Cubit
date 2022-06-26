import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/task_view.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, AppStates state) {
        // if (state is AppInsertToDatabaseState) {
        // }
      },
      builder: (ctx, state) {
        List<Map> tasks = AppCubit.get(ctx).archivedTasks;
        return TaskView(tasks);
      },
    );
  
  }
}
