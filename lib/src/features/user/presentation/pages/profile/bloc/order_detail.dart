import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/enums.dart';
import '../../../../domain/usecase/order/fetch_order_detail_usecase.dart';
import '../../../../domain/usecase/user/fetch_user_usecase.dart';
import '../../../bloc/base_state.dart';

class OrderDetailCubit extends Cubit<BaseState> {
  OrderDetailCubit(this.useCase) : super(const BaseState());

  final FetchOrderDetailUseCase useCase;

  void fetchOrderDetail(int id) async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await useCase(PathParams(id.toString()));

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
