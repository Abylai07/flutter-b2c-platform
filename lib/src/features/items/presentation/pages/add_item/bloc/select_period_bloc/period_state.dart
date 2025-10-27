import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';

import '../../../../../domain/entity/order/select_period.dart';

enum PeriodStatus { initial, edit, success, error, loading }

extension PeriodStatusX on PeriodStatus {
  bool get isInitial => this == PeriodStatus.initial;
  bool get isEdit => this == PeriodStatus.edit;
  bool get isSuccess => this == PeriodStatus.success;
  bool get isError => this == PeriodStatus.error;
  bool get isLoading => this == PeriodStatus.loading;
}

class PeriodSelectState<T> extends Equatable {
  const PeriodSelectState( {
    this.status = PeriodStatus.initial,
    this.entity,
    this.selectedPeriods,
    this.selectRemove,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final PeriodStatus status;
  final List<IdNameEntity>? entity;
  final List<SelectPeriod>? selectedPeriods;
  final List<int>? selectRemove;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    selectedPeriods,
    selectRemove,
    message,
    count,
    errorCode,
  ];

  PeriodSelectState copyWith({
    List<IdNameEntity>? entity,
    List<SelectPeriod>? selectedPeriods,
    List<int>? selectRemove,
    PeriodStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return PeriodSelectState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectedPeriods: selectedPeriods ?? this.selectedPeriods,
      selectRemove: selectRemove ?? this.selectRemove,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}


