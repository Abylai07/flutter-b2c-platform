import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';

import '../../../../../../common/utils/geocoding/geocoding_model.dart';


enum PlaceStatus { initial, search, success, error, loading }

extension PlaceStatusX on PlaceStatus {
  bool get isInitial => this == PlaceStatus.initial;
  bool get isSearch => this == PlaceStatus.search;
  bool get isSuccess => this == PlaceStatus.success;
  bool get isError => this == PlaceStatus.error;
  bool get isLoading => this == PlaceStatus.loading;
}

class CreatePlaceState<T> extends Equatable {
  const CreatePlaceState({
    this.status = PlaceStatus.initial,
    this.entity,
    this.searchResult,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final PlaceStatus status;
  final PlaceEntity? entity;
  final String message;
  final List<GeocodingModel>? searchResult;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    message,
    count,
    searchResult,
    errorCode,
  ];

  CreatePlaceState copyWith({
    PlaceEntity? entity,
    PlaceStatus? status,
    String? message,
    List<GeocodingModel>? searchResult,
    int? count,
    int? errorCode,
  }) {
    return CreatePlaceState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      status: status ?? this.status,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
