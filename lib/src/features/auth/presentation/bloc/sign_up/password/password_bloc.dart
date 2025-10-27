import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  bool _isConfirmPasswordObscure = true;

  PasswordBloc() : super(PasswordInitial()) {
    on<MatchPassword>((event, emit) {
      if (event.confirmPassword == event.password) {
        emit(PasswordsMatch(
          isConfirmPasswordObscure: _isConfirmPasswordObscure,
        ));
      } else {
        emit(PasswordsDoNotMatch(
          isConfirmPasswordObscure: _isConfirmPasswordObscure,
        ));
      }
    });

    on<ToggleConfirmPasswordObscure>((event, emit) {
      _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
      _emitCurrentState(emit);
    });
  }

  void _emitCurrentState(Emitter<PasswordState> emit) {
    if (state is PasswordsMatch) {
      emit(PasswordsMatch(
        isConfirmPasswordObscure: _isConfirmPasswordObscure,
      ));
    } else if (state is PasswordsDoNotMatch) {
      emit(PasswordsDoNotMatch(
        isConfirmPasswordObscure: _isConfirmPasswordObscure,
      ));
    }
  }
}
