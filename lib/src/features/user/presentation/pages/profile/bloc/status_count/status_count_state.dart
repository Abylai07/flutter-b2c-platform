import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../../../domain/entity/order/status_count_entity.dart';


class StatusCountState<T> extends Equatable {
  const StatusCountState({
    this.status = CubitStatus.initial,
    this.entity,
    this.selectStatus,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
  final StatusCountEntity? entity;
  final String? selectStatus;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectStatus,
    message,
    count,
    errorCode,
  ];

  StatusCountState copyWith({
    StatusCountEntity? entity,
    CubitStatus? status,
    String? selectStatus,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return StatusCountState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectStatus: selectStatus ?? this.selectStatus,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
