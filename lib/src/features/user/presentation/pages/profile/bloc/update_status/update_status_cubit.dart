import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/change_item_usecase.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/update_status_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_status_state.dart';

class UpdateStatusCubit extends Cubit<UpdateStatusState> {
  UpdateStatusCubit(this.useCase) : super(const UpdateStatusState());

  final UpdateStatusUseCase useCase;

  void updateStatus(
      {required int id, required String status, String? otp}) async {
    emit(const UpdateStatusState(status: UpdateStatus.loading));

    final failureOrAuth = await useCase(PathMapParams(
      path: '$id${otp == null ? '/' : '/?code=$otp'}',
      data: status != 'accepted' && otp == null ? {} : {'status': status},
    ));

    emit(
      failureOrAuth.fold(
          (l) => UpdateStatusState(
                status: otp != null
                    ? UpdateStatus.wrongOtp
                    : UpdateStatus.error,
                message: l.message,
              ), (r) {
        return UpdateStatusState(
          status: status == 'accepted' || otp != null
              ? UpdateStatus.success
              : UpdateStatus.needOtp,
          entity: r,
        );
      }),
    );
  }

  selectStatus(String status) async {
    emit(state.copyWith(selectStatus: status));
  }
}
