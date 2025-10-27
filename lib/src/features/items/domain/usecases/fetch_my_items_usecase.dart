import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchMyItemUseCase extends UseCase<PaginationMyItemEntity?, PaginationParams> {
  FetchMyItemUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<Either<Failure, PaginationMyItemEntity>> call(PaginationParams? params) async {
    return await repository.fetchMyItems(params);
  }
}

class PaginationParams {
  const PaginationParams({required this.page, this.status = '',});

  final int page;
  final String status;

}
