import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchItemsUseCase extends UseCase<PaginationItemEntity?, ItemsParams> {
  FetchItemsUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<Either<Failure, PaginationItemEntity>> call(ItemsParams? params) async {
    return await repository.fetchItems(params);
  }
}

class ItemsParams {
  const ItemsParams({required this.page, this.query = '', this.categoryId,});

  final String page;
  final String query;
  final int? categoryId;

}

