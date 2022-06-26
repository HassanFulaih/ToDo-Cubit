import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;
  void increment() {
    counter++;
    emit(CounterPlusState(counter));
  }

  void decrement() {
    counter--;
    emit(CounterMinusState(counter));
  }
}
