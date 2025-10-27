import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../entity/items/item_detail_entity.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchItemDetailUseCase extends UseCase<ItemDetailEntity?, PathParams> {
  FetchItemDetailUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<Either<Failure, ItemDetailEntity>> call(PathParams? params) async {
    return await repository.fetchItemDetail(params);
  }
}


