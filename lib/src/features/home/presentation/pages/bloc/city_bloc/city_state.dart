
part of 'city_cubit.dart';

class CityState<T> extends Equatable {
  const CityState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectCity,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<CityEntity>? entity;
  final CityEntity? selectCity;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectCity,
    message,
    count,
    errorCode,
  ];

  CityState copyWith({
    List<CityEntity>? entity,
    CityEntity? selectCity,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return CityState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectCity: selectCity ?? this.selectCity,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}