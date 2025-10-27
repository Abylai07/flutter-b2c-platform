import 'package:equatable/equatable.dart';


enum SignUpStatus {
  initial,
  loading,
  successOtp,
  successVerify,
  successData,
  successPassword,
  errorOtp,
  errorVerify,
  errorData,
  errorPassword,
}

class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.entity,
    String? message,
  })  : message = message ?? '';

  final SignUpStatus status;
  final Map<String, dynamic>? entity;
  final String message;

  @override
  List<Object?> get props => [
    status,
    entity,
    message,
  ];

  SignUpState copyWith(
      {Map<String, dynamic>? entity,
        SignUpStatus? status,
        String? message,
      }) {
    return SignUpState(
      entity: entity ?? this.entity,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
