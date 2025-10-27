import 'package:bloc/bloc.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/form_bloc/form_state.dart';

class FormStateCubit extends Cubit<FormState> {
  FormStateCubit() : super(const FormState(inputValue: '', isError: false));

  void updateInputValue(String value) {
    emit(state.copyWith(inputValue: value, isError: false));
  }

  void showError() {
    emit(state.copyWith(isError: true));
  }
}
