import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/user/domain/entities/city_entity.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';
import 'fetch_user_usecase.dart';


class FetchCityUseCase extends UseCase<List<CityEntity>?, PathParams> {
  FetchCityUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, List<CityEntity>>> call(PathParams? params) async {
    return await repository.fetchCityList();
  }
}

