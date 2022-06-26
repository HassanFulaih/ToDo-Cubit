import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterStates>(
      listener: (context, CounterStates state) {
        if (state is CounterPlusState) {
          log('CounterPlusState ${state.counter}');
        } else if (state is CounterMinusState) {
          log('CounterMinusState ${state.counter}');
        } else {
          log('CounterInitialState');
        }
      },
      builder: (ctx, state) => Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Transform.scale(
          scale: 2,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    CounterCubit.get(ctx).decrement();
                  },
                  child: const Text('Minus'),
                ),
                Text(
                  '${CounterCubit.get(ctx).counter}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    CounterCubit.get(ctx).increment();
                  },
                  child: const Text('Plus'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
