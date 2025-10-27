
import 'package:equatable/equatable.dart';

class FormState extends Equatable {
  final String inputValue;
  final bool isError;

  const FormState({required this.inputValue, required this.isError});

  FormState copyWith({String? inputValue, bool? isError}) {
    return FormState(
      inputValue: inputValue ?? this.inputValue,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [inputValue, isError];
}

