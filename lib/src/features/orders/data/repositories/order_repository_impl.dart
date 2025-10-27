import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/status_count_entity.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';
import '../../domain/entity/order/order_detail_entity.dart';
import '../../domain/repository/abstract_order_service_profile.dart';
import '../datasources/order_remote_data_source.dart';

class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final OrderRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, Map<String, dynamic>>> bookItem(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.bookItem(params));
  }

  @override
  Future<Either<Failure, PaginationOrderEntity>> fetchOrderItem(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchOrderItems(params));
  }

  @override
  Future<Either<Failure, StatusCountEntity>> fetchStatusCount(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchStatusCount(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateStatus(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.updateStatus(params));
  }

  @override
  Future<Either<Failure, OrderDetailEntity>> fetchOrderDetail(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchOrderDetail(params));
  }
}
