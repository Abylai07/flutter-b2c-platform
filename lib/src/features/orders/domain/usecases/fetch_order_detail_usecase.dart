import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/orders/domain/repositories/order_repository.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../entity/items/item_detail_entity.dart';
import '../../entity/order/order_detail_entity.dart';

class FetchOrderDetailUseCase extends UseCase<OrderDetailEntity?, PathParams> {
  FetchOrderDetailUseCase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, OrderDetailEntity>> call(PathParams? params) async {
    return await repository.fetchOrderDetail(params);
  }
}


