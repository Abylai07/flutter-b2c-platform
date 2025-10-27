import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/city_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> fetchUserInfo();

  Future<Either<Failure, List<CityEntity>>> fetchCityList();

  Future<Either<Failure, Map<String, dynamic>>> deleteMe();

  Future<Either<Failure, Map<String, dynamic>>> logout();

  Future<Either<Failure, Map<String, dynamic>>> updateUserImage(params);

  Future<Either<Failure, Map<String, dynamic>>> removeUserImage();
}
