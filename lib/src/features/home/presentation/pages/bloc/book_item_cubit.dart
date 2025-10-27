import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/book_item_usecase.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import '../../../bloc/base_state.dart';


class BookItemCubit extends Cubit<BaseState> {
  BookItemCubit(this.useCase) : super(const BaseState());

  final BookItemUseCase useCase;

  void bookItem(Map<String, dynamic> data) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await useCase(MapParams(data));

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
