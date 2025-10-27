import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureBloc extends Cubit<bool> {
  ObscureBloc() : super(true);

  void toggle() => emit(!state);
  void show() => emit(false);
  void hide() => emit(true);
}
