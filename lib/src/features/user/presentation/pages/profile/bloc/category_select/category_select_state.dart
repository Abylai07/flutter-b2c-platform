import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';


enum CategoryStatus { initial, search, success, error, loading }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isSearch => this == CategoryStatus.search;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isLoading => this == CategoryStatus.loading;
}

class CategorySelectState<T> extends Equatable {
  const CategorySelectState({
    this.status = CategoryStatus.initial,
    this.entity,
    this.selectCategory,
    this.selectSubCategory,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CategoryStatus status;
  final List<CategoryEntity>? entity;
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

  CategorySelectState copyWith({
    List<CategoryEntity>? entity,
    CategoryStatus? status,
    CategoryEntity? selectCategory,
    SubcategoryEntity? selectSubCategory,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return CategorySelectState(
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
