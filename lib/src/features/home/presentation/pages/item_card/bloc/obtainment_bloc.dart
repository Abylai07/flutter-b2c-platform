import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';

// Define the states
abstract class ObtainmentTypeState extends Equatable {
  const ObtainmentTypeState();

  @override
  List<Object> get props => [];
}

class ObtainmentTypeInitial extends ObtainmentTypeState {
  const ObtainmentTypeInitial();
}

class ObtainmentTypeChanged extends ObtainmentTypeState {
  final ObtainmentTypeEntity obtainmentType;

  const ObtainmentTypeChanged(this.obtainmentType);

  @override
  List<Object> get props => [obtainmentType];
}

// Define the events
abstract class ObtainmentTypeEvent extends Equatable {
  const ObtainmentTypeEvent();

  @override
  List<Object> get props => [];
}

class ChangeObtainmentType extends ObtainmentTypeEvent {
  final ObtainmentTypeEntity newType;

  const ChangeObtainmentType(this.newType);

  @override
  List<Object> get props => [newType];
}

// BLoC implementation
class ObtainmentTypeBloc extends Bloc<ObtainmentTypeEvent, ObtainmentTypeState> {

  ObtainmentTypeBloc() : super(const ObtainmentTypeInitial()) {
    on<ChangeObtainmentType>((event, emit) {
      emit(ObtainmentTypeChanged(event.newType));
    });
  }
}
