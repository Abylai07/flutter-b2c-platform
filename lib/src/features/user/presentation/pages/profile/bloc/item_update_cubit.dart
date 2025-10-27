import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_item_for_update_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class ItemUpdateCubit extends Cubit<BaseState> {
  ItemUpdateCubit(this.fetchItemUpdateUseCase) : super(const BaseState());

  final FetchItemUpdateUseCase fetchItemUpdateUseCase;

  void fetchItemUpdate(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await fetchItemUpdateUseCase(PathParams(id.toString()));

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
