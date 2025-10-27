import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/delete_me_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class DeleteMeCubit extends Cubit<BaseState> {
  DeleteMeCubit(this.deleteMeUseCase) : super(const BaseState());

  final DeleteMeUseCase deleteMeUseCase;

  void deleteMe() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await deleteMeUseCase(null);

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
