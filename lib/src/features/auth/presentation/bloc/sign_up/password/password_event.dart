part of 'password_bloc.dart';

@immutable
abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class MatchPassword extends PasswordEvent {
  final String password;
  final String confirmPassword;

  const MatchPassword({required this.confirmPassword, required this.password});

  @override
  List<Object> get props => [confirmPassword, password];
}

class ToggleConfirmPasswordObscure extends PasswordEvent {}