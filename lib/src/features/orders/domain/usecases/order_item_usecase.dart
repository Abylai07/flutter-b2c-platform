import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/repositories/order_repository.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';


class OrderItemUseCase extends UseCase<PaginationOrderEntity?, OrderParams> {
  OrderItemUseCase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, PaginationOrderEntity>> call(OrderParams? params) async {
    return await repository.fetchOrderItem(params);
  }
}

class OrderParams {
  const OrderParams({required this.page, this.status = '', this.isMy = false});

  final int page;
  final String status;
  final bool isMy;

}

