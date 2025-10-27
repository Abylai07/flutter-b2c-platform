import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';

enum ObtainmentStatus { initial, selected, success, error, loading }

extension ObtainmentStatusX on ObtainmentStatus {
  bool get isInitial => this == ObtainmentStatus.initial;
  bool get isSelected => this == ObtainmentStatus.selected;
  bool get isSuccess => this == ObtainmentStatus.success;
  bool get isError => this == ObtainmentStatus.error;
  bool get isLoading => this == ObtainmentStatus.loading;
}

class ObtainmentSelectState<T> extends Equatable {
  const ObtainmentSelectState( {
    this.status = ObtainmentStatus.initial,
    this.obtainmentList,
    this.textValues,
    this.selectedObtains,
    this.selectedReturns,
    this.returnList,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final ObtainmentStatus status;
  final List<IdNameEntity>? obtainmentList;
  final List<IdNameEntity>? returnList;
  final List<IdNameEntity>? selectedObtains;
  final List<IdNameEntity>? selectedReturns;
  final List<String>? textValues;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    obtainmentList,
    returnList,
    selectedObtains,
    selectedReturns,
    textValues,
    message,
    count,
    errorCode,
  ];

  ObtainmentSelectState copyWith({
    List<IdNameEntity>? obtainmentList,
    List<IdNameEntity>? returnList,
    List<IdNameEntity>? selectedObtains,
    List<IdNameEntity>? selectedReturns,
    List<String>? textValues,
    ObtainmentStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return ObtainmentSelectState(
      errorCode: errorCode,
      obtainmentList: obtainmentList ?? this.obtainmentList,
      returnList: returnList ?? this.returnList,
      selectedObtains: selectedObtains ?? this.selectedObtains,
      selectedReturns: selectedReturns ?? this.selectedReturns,
      textValues: textValues ?? this.textValues,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
