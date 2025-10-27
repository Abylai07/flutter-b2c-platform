import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_item_detail_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import '../../../bloc/base_state.dart';


class ItemDetailCubit extends Cubit<BaseState> {
  ItemDetailCubit(this.fetchItemDetailUseCase) : super(const BaseState());

  final FetchItemDetailUseCase fetchItemDetailUseCase;

  void fetchItemDetail(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await fetchItemDetailUseCase(PathParams(id.toString()));

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
