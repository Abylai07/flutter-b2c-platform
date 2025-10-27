import 'package:dio/dio.dart';
import 'package:b2c_platform/src/features/orders/data/models/order_item.dart';
import 'package:b2c_platform/src/features/orders/data/models/status_count_model.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/status_count_entity.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/change_item_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../../domain/entity/order/order_detail_entity.dart';
import '../../domain/usecase/order/order_item_usecase.dart';
import '../models/items/item_detail_model.dart';
import '../models/orders/order_detail_model.dart';

abstract class OrderRemoteDataSource {
  Future<Map<String, dynamic>> bookItem(MapParams params);

  Future<Map<String, dynamic>> updateStatus(PathMapParams params);

  Future<PaginationOrderEntity> fetchOrderItems(OrderParams params);

  Future<StatusCountEntity> fetchStatusCount(PathParams params);

  Future<OrderDetailEntity> fetchOrderDetail(PathParams params);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final API api;

  OrderRemoteDataSourceImpl(this.api);

  @override
  Future<Map<String, dynamic>> bookItem(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}orders/create/',
        data: params.data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<PaginationOrderEntity> fetchOrderItems(OrderParams params) async {
    try {
      String link = params.status.isEmpty
          ? '${constants.host}orders/?page=${params.page}'
          : params.isMy && params.status.isEmpty
              ? '${constants.host}orders/?page=${params.page}&for_my_items=${params.isMy}'
              : !params.isMy && params.status.isNotEmpty
                  ? '${constants.host}orders/?page=${params.page}&status=${params.status}'
                  : '${constants.host}orders/?page=${params.page}&for_my_items=${params.isMy}&status=${params.status}';
      if (params.isMy) {
        link = '$link&for_my_items=${params.isMy}';
      }
      final response = await api.dio.get(link);

      if (response.statusCode == 200) {
        List<OrderItemEntity> itemEntity = (response.data['results'] as List)
            .map((e) => OrderItemModel.fromJson(e))
            .toList();
        return PaginationOrderEntity(
          isLast: response.data['next'] == null,
          itemEntity: itemEntity,
        );
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<StatusCountEntity> fetchStatusCount(PathParams params) async {
    try {
      final response = await api.dio.get(
        params.path.isEmpty
            ? '${constants.host}orders/statuses-count/'
            : '${constants.host}orders/statuses-count/?for_my_items=true',
      );

      if (response.statusCode == 200) {
        return StatusCountModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateStatus(PathMapParams params) async {
    print('params ${params.data}');
    try {
      final response = params.data.isNotEmpty
          ? await api.dio.put(
              '${constants.host}orders/update-status/${params.path}',
              data: params.data,
            )
          : await api.dio.post(
              '${constants.host}orders/otp-update-status/${params.path}',
              data: {},
            );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<OrderDetailEntity> fetchOrderDetail(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}orders/${params.path}/',
      );

      if (response.statusCode == 200) {
        return OrderDetailModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
