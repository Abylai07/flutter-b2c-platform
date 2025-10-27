import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import '../../../../domain/usecase/item/create_item_usecase.dart';
import '../../../bloc/base_state.dart';

class CreateItemCubit extends Cubit<BaseState> {
  CreateItemCubit(this.createItemUseCase) : super(const BaseState());

  final CreateItemUseCase createItemUseCase;

  void createItem(Map<String, dynamic> data) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await createItemUseCase(MapParams(data));

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
