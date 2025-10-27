import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/item_photo_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import '../../../bloc/base_state.dart';

class ItemPhotoCubit extends Cubit<BaseState> {
  ItemPhotoCubit(this.itemPhotoUseCase) : super(const BaseState());

  final ItemPhotoUseCase itemPhotoUseCase;

  void updateItemPhoto(FormData data) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await itemPhotoUseCase.updateItemPhoto(FormParams(data));

    emit(
      failureOrAuth.fold(
            (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => BaseState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }

  void deletePhoto(String path) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await itemPhotoUseCase.deleteItemPhoto(PathParams(path));

    emit(
      failureOrAuth.fold(
            (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
            (r) => BaseState(
          status: CubitStatus.success,
          entity: r,
        ),
      ),
    );
  }
}
