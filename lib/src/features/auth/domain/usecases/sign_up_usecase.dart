import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/auth/domain/entities/auth_entity.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';


class SignOtpUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  SignOtpUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.signUpOtp(params);
  }
}

class SignVerifyUseCase extends UseCase<AuthEntity?, MapParams> {
  SignVerifyUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, AuthEntity>> call(MapParams? params) async {
    return await repository.signUpCode(params);
  }
}


class SignDataUseCase extends UseCase<UserEntity?, MapParams> {
  SignDataUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(MapParams? params) async {
    return await repository.signUpData(params);
  }
}

class SignPasswordUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  SignPasswordUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.signUpPassword(params);
  }
}


