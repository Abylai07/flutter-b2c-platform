import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/core/check_error_type.dart';
import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/features/auth/domain/entities/auth_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:b2c_platform/src/features/auth/data/datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  final NetworkOperationHelper networkOperationHelper;

  AuthRepositoryImpl(this.dataSource, this.networkOperationHelper);

  @override
  Future<Either<Failure, AuthEntity>> signIn(params) {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.signIn(params));
  }

  @override
  Future<Either<Failure, AuthEntity>> signUpCode(params) {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpCode(params));
  }

  @override
  Future<Either<Failure, UserEntity>> signUpData(params) {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpData(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpOtp(params) {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpOtp(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpPassword(params) {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.signUpPassword(params));
  }
}