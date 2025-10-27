import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class CreatePlaceUseCase extends UseCase<PlaceEntity?, MapParams> {
  CreatePlaceUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<Either<Failure, PlaceEntity>> call(MapParams? params) async {
    return await repository.createPlace(params);
  }
}


