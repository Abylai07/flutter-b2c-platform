part of 'password_bloc.dart';

@immutable
abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordsMatch extends PasswordState {
  final bool isConfirmPasswordObscure;

  const PasswordsMatch({
    required this.isConfirmPasswordObscure,
  });

  @override
  List<Object> get props => [ isConfirmPasswordObscure];
}

class PasswordsDoNotMatch extends PasswordState {
  final bool isConfirmPasswordObscure;

  const PasswordsDoNotMatch({
    required this.isConfirmPasswordObscure,
  });

  @override
  List<Object> get props => [isConfirmPasswordObscure];
}
