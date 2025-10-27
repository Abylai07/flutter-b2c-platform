import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class UserTypeEvent extends Equatable {
  const UserTypeEvent();

  @override
  List<Object> get props => [];
}

class SelectUserType extends UserTypeEvent {
  final String userType;

  const SelectUserType(this.userType);

  @override
  List<Object> get props => [userType];
}

// States
abstract class UserTypeState extends Equatable {
  const UserTypeState();

  @override
  List<Object> get props => [];
}

class UserTypeInitial extends UserTypeState {}

class UserTypeSelected extends UserTypeState {
  final String userType;

  const UserTypeSelected(this.userType);

  @override
  List<Object> get props => [userType];
}

// Bloc
class UserTypeBloc extends Bloc<UserTypeEvent, UserTypeState> {
  UserTypeBloc() : super(UserTypeInitial()) {
    on<SelectUserType>((event, emit) {
      emit(UserTypeSelected(event.userType));
    });
  }
}
