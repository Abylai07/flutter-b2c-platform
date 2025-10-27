import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/core/check_error_type.dart';
import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/city_entity.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';
import 'package:b2c_platform/src/features/user/data/datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource dataSource;
  final NetworkOperationHelper networkOperationHelper;

  UserRepositoryImpl(this.dataSource, this.networkOperationHelper);

  @override
  Future<Either<Failure, UserEntity>> fetchUserInfo() async {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchUserInfo());
  }

  @override
  Future<Either<Failure, List<CityEntity>>> fetchCityList() {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchCityList());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteMe() {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.deleteMe());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.logout());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> removeUserImage() {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.removeUserImage());
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateUserImage(params) {
    return networkOperationHelper
        .performNetworkOperation(() => dataSource.updateUserImage(params));
  }
}
