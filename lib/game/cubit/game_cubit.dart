import 'package:bloc/bloc.dart';

class GameCubit extends Cubit<int> {
  GameCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
