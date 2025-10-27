import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/status_count_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import '../../../../../common/enums.dart';
import 'status_count_state.dart';

class StatusCountCubit extends Cubit<StatusCountState> {
  StatusCountCubit(this.statusCountUseCase)
      : super(const StatusCountState());

  final StatusCountUseCase statusCountUseCase;

  void fetchStatusCount(bool isMy, {String? status}) async {
    emit(const StatusCountState(status: CubitStatus.loading));

    final failureOrAuth = await statusCountUseCase(PathParams(isMy ? 'isMy' : ''));

    emit(
      failureOrAuth.fold(
          (l) => StatusCountState(
                status: CubitStatus.error,
                message: l.message,
              ), (r) {
            int count = r.closedCount + r.inProgressCount + r.acceptedCount + r.newCount;
        return StatusCountState(
          status: CubitStatus.success,
          entity: r,
          count: count,
          selectStatus: status
        );
      }),
    );
  }

  selectStatus(String status) async {
    emit(state.copyWith(selectStatus: status));
  }
}
