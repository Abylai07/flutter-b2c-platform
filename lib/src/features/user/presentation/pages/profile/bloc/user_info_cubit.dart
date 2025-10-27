import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/utils/shared_preference.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class UserInfoCubit extends Cubit<BaseState> {
  UserInfoCubit(this.fetchUserUseCase) : super(const BaseState());

  final FetchUserUseCase fetchUserUseCase;

  void fetchUserInfo() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await fetchUserUseCase(null);

    emit(
      failureOrAuth.fold(
        (l) => BaseState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          SharedPrefs().setCityId(r.city);
          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }
}
