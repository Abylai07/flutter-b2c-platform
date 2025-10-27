import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/features/auth/domain/entities/auth_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signIn(params);

  Future<Either<Failure, Map<String, dynamic>>> signUpOtp(params);

  Future<Either<Failure, AuthEntity>> signUpCode(params);

  Future<Either<Failure, UserEntity>> signUpData(params);

  Future<Either<Failure, Map<String, dynamic>>> signUpPassword(params);
}