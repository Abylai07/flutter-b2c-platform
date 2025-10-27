import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/item_photo_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/user_photo_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class LoadingCubit extends Cubit<BaseState> {
  LoadingCubit() : super(const BaseState(status: CubitStatus.loading));


  void setLoading() async {
    emit(const BaseState(status: CubitStatus.loading));
  }

  void setSuccess() async {
    emit(const BaseState(status: CubitStatus.success));
  }
}
