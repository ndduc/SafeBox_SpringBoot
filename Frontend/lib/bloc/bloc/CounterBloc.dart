import 'package:bloc/bloc.dart';

import '../event/CounterEvent.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    // Register event handlers
    on<IncrementEvent>((event, emit) => emit(state + 1));
    on<DecrementEvent>((event, emit) => emit(state - 1));
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield state + 1;
    } else if (event is DecrementEvent) {
      yield state - 1;
    }
  }
}