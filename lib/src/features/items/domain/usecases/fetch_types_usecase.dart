import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchTypesUseCase {
  FetchTypesUseCase(this.repository);

  final ItemRepository repository;

  Future<Either<Failure, List<IdNameEntity>>> fetchPeriods() async {
    return await repository.fetchPeriodType();
  }


  Future<Either<Failure, List<IdNameEntity>>> fetchReturns() async {
    return await repository.fetchReturnTypes();
  }

  Future<Either<Failure, List<IdNameEntity>>> fetchObtainment() async {
    return await repository.fetchObtainment();
  }
}



