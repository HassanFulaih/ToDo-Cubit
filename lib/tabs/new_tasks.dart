import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/task_view.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, AppStates state) {},
      builder: (ctx, state) {
        List<Map> tasks = AppCubit.get(ctx).newTasks;
        return TaskView(tasks);
      },
    );
  }
}
