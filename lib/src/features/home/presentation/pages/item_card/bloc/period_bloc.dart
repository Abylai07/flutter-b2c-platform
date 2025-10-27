import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/entity/items/item_entity.dart';

// Define the states
abstract class PeriodState extends Equatable {
  const PeriodState();

  @override
  List<Object> get props => [];
}

class PeriodInitial extends PeriodState {}


class PeriodWithPrice extends PeriodState {
  final PeriodEntity selectedPeriod;
  final int count;

  const PeriodWithPrice(this.selectedPeriod, this.count);

  @override
  List<Object> get props => [selectedPeriod, count];
}


// Define the events
abstract class PeriodEvent extends Equatable {
  const PeriodEvent();

  @override
  List<Object> get props => [];
}


class SelectPeriodWithPrice extends PeriodEvent {
  final PeriodEntity period;
  final int count;

  const SelectPeriodWithPrice(this.period, this.count);

  @override
  List<Object> get props => [period, count];
}

// BLoC implementation
class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodBloc() : super(PeriodInitial()) {

    on<SelectPeriodWithPrice>((event, emit) {
      emit(PeriodWithPrice(event.period, event.count));
    });
  }
}
