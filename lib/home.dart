import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'components/default_text_field.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, AppStates state) {
        if (state is AppInsertToDatabaseState) {
          _formKey.currentState!.save();
          Navigator.of(context).pop();
          _titleController.clear();
          _timeController.clear();
          _dateController.clear();
        }
      },
      builder: (ctx, state) => Scaffold(
        appBar: AppBar(title: Text(cubit.titles[cubit.currentIndex])),
        body: state is AppGetDatabaseLoadingState
            ? const Center(child: CircularProgressIndicator())
            : cubit.screens[cubit.currentIndex],
        floatingActionButton: Builder(
          builder: (ctx) {
            return FloatingActionButton(
              onPressed: () {
                if (cubit.isShown) {
                  if (_formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: _titleController.text,
                      time: _timeController.text,
                      date: _dateController.text,
                    );
                  }
                } else {
                  Scaffold.of(ctx)
                      .showBottomSheet(
                        elevation: 15,
                        (ctx) => Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultTextField(
                                  label: 'Task Title',
                                  type: TextInputType.text,
                                  controller: _titleController,
                                  prefix: const Icon(Icons.title),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please enter a title';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                DefaultTextField(
                                  label: 'Task Time',
                                  onTap: () {
                                    showTimePicker(
                                      context: ctx,
                                      initialTime: TimeOfDay.now(),
                                    ).then((val) {
                                      if (val != null) {
                                        _timeController.text =
                                            val.format(context);
                                      }
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  controller: _timeController,
                                  prefix:
                                      const Icon(Icons.watch_later_outlined),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please enter a time';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                DefaultTextField(
                                  label: 'Task Date',
                                  onTap: () {
                                    showDatePicker(
                                      context: ctx,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime.parse('2022-12-31'),
                                    ).then((val) {
                                      if (val != null) {
                                        _dateController.text =
                                            DateFormat.yMMMd().format(val);
                                      }
                                    });
                                  },
                                  type: TextInputType.datetime,
                                  controller: _dateController,
                                  prefix:
                                      const Icon(Icons.calendar_today_outlined),
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please enter a Date';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(false, Icons.edit);
                  });
                  cubit.changeBottomSheet(true, Icons.add);
                }
              },
              child: Icon(cubit.icon),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.currentIndex,
          onTap: (index) => cubit.changeTab(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Archive',
            ),
          ],
        ),
      ),
    );
  }
}
