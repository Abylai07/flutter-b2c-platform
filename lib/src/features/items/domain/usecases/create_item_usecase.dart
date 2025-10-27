import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../entity/items/create_item_entity.dart';
import '../../repository/abstract_item_service_profile.dart';


class CreateItemUseCase extends UseCase<CreateItemEntity?, MapParams> {
  CreateItemUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<Either<Failure, CreateItemEntity>> call(MapParams? params) async {
    return await repository.createItem(params);
  }
}


