import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';


class ConditionSelectState<T> extends Equatable {
  const ConditionSelectState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectCondition,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final List<IdNameEntity>? entity;
  final IdNameEntity? selectCondition;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectCondition,
    message,
    count,
    errorCode,
  ];

  ConditionSelectState copyWith({
    List<IdNameEntity>? entity,
    IdNameEntity? selectCondition,
    CubitStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return ConditionSelectState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectCondition: selectCondition ?? this.selectCondition,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
