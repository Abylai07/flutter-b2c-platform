import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchConditionUseCase {
  FetchConditionUseCase(this.repository);

  final ItemRepository repository;

  Future<Either<Failure, List<IdNameEntity>>> fetchConditions() async {
    return await repository.fetchConditionList();
  }
}



