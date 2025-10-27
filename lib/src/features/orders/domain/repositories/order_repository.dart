import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/status_count_entity.dart';

import '../../core/error/failure.dart';
import '../entity/items/item_detail_entity.dart';
import '../entity/order/order_detail_entity.dart';
import '../entity/order/order_item_entity.dart';

abstract class OrderRepository {

  Future<Either<Failure, Map<String, dynamic>>> bookItem(params);

  Future<Either<Failure, PaginationOrderEntity>> fetchOrderItem(params);

  Future<Either<Failure, OrderDetailEntity>> fetchOrderDetail(params);

  Future<Either<Failure, StatusCountEntity>> fetchStatusCount(params);

  Future<Either<Failure, Map<String, dynamic>>> updateStatus(params);


}