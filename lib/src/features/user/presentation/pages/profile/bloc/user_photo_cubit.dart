import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/item_photo_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/user_photo_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class UserPhotoCubit extends Cubit<BaseState> {
  UserPhotoCubit(this.userPhotoUseCase) : super(const BaseState());

  final UserPhotoUseCase userPhotoUseCase;

  void updateUserPhoto(FormData data) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await userPhotoUseCase.updateUserImage(FormParams(data));

    emit(
      failureOrAuth.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }

  void removeUserPhoto() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await userPhotoUseCase.removeUserImage();

    emit(
      failureOrAuth.fold(
            (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) {
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }
}
