part of 'update_status_cubit.dart';

enum UpdateStatus { initial, success, sentOtp, needOtp, wrongOtp, error, loading}

extension UpdateStatusX on UpdateStatus {
  bool get isInitial => this == UpdateStatus.initial;
  bool get isNeedOtp => this == UpdateStatus.needOtp;
  bool get isSentOtp => this == UpdateStatus.sentOtp;
  bool get isWrongOtp => this == UpdateStatus.wrongOtp;
  bool get isSuccess => this == UpdateStatus.success;
  bool get isError => this == UpdateStatus.error;
  bool get isLoading => this == UpdateStatus.loading;
}

class UpdateStatusState<T> extends Equatable {
  const UpdateStatusState({
    this.status = UpdateStatus.initial,
    this.entity,
    this.selectStatus,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final UpdateStatus status;
  final T? entity;
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

  UpdateStatusState copyWith({
    T? entity,
    UpdateStatus? status,
    String? selectStatus,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return UpdateStatusState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      selectStatus: selectStatus ?? this.selectStatus,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
