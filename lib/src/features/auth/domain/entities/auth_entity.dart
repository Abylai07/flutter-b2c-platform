import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? token;
  final String? refreshToken;

  const AuthEntity({
    this.token,
    this.refreshToken,
  });
  @override
  List<Object?> get props => [token, refreshToken];
}
