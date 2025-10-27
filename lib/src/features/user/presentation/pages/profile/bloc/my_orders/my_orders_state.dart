import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';


enum OrdersStatus { initial, search, success, error, loading }

extension OrdersStatusX on OrdersStatus {
  bool get isInitial => this == OrdersStatus.initial;
  bool get isSearch => this == OrdersStatus.search;
  bool get isSuccess => this == OrdersStatus.success;
  bool get isError => this == OrdersStatus.error;
  bool get isLoading => this == OrdersStatus.loading;
}

class MyOrdersState<T> extends Equatable {
  const MyOrdersState({
    this.status = OrdersStatus.initial,
    this.entity,
    this.selectCategory,
    this.selectSubCategory,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final OrdersStatus status;
  final List<OrderItemEntity>? entity;
  final CategoryEntity? selectCategory;
  final SubcategoryEntity? selectSubCategory;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectCategory,
    selectSubCategory,
    message,
    count,
    errorCode,
  ];

  MyOrdersState copyWith({
    List<OrderItemEntity>? entity,
    OrdersStatus? status,
    CategoryEntity? selectCategory,
    SubcategoryEntity? selectSubCategory,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return MyOrdersState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectCategory: selectCategory ?? this.selectCategory,
      selectSubCategory: selectSubCategory ?? this.selectSubCategory,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
