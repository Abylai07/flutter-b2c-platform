import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonBloc extends Cubit<bool> {
  ButtonBloc() : super(false);

  void toggle() => emit(!state);
  void setValue(bool value) => emit(value);
}
