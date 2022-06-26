import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/observer.dart';
import 'home.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver();
  BlocOverrides.runZoned(
    () {
      runApp(
        BlocProvider(
          create: (BuildContext context) {
            return AppCubit()..createDatabase();
          },
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:  HomePage(),
    );
  }
}
