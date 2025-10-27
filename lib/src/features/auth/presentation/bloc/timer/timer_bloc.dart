import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Timer Event
abstract class TimerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartTimer extends TimerEvent {}

class Tick extends TimerEvent {
  final int duration;

  Tick(this.duration);

  @override
  List<Object> get props => [duration];
}

class ResetTimer extends TimerEvent {}

// Timer State
abstract class TimerState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerRunInProgress extends TimerState {
  final int duration;

  TimerRunInProgress(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerRunComplete extends TimerState {}

// Timer Bloc
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  Timer? _timer;

  TimerBloc() : super(TimerInitial()) {
    on<StartTimer>(_onStartTimer);
    on<Tick>(_onTick);
    on<ResetTimer>(_onResetTimer);
  }

  void _onStartTimer(StartTimer event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(_duration));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(Tick(_duration - timer.tick));
    });
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    if (event.duration > 0) {
      emit(TimerRunInProgress(event.duration));
    } else {
      _timer?.cancel();
      emit(TimerRunComplete());
    }
  }

  void _onResetTimer(ResetTimer event, Emitter<TimerState> emit) {
    _timer?.cancel();
    emit(TimerInitial());
  }
}
