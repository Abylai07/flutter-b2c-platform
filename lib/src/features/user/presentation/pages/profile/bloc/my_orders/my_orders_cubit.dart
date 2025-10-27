import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';

import '../../../../../domain/usecase/order/order_item_usecase.dart';
import 'my_orders_state.dart';


class MyOrdersCubit extends Cubit<MyOrdersState> {
  final PagingController<int, OrderItemEntity> pagingController =
  PagingController(firstPageKey: 1);
  final OrderItemUseCase orderItemUseCase;

  MyOrdersCubit(this.orderItemUseCase) : super(const MyOrdersState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, currentStatus, atClients);
    });
  }

  String currentStatus = '';
  bool atClients = false;

  Future<void> _fetchPage(int pageKey, String status, bool isMy) async {

    final failureOrAuth = await orderItemUseCase(OrderParams(page: pageKey, status: status, isMy: isMy));

    emit(
      failureOrAuth.fold(
            (l) {
          pagingController.error = l.message;
          return MyOrdersState(
            status: OrdersStatus.error,
            message: l.message,
          );
        },
            (r) {
          if (r.isLast) {
            pagingController.appendLastPage(r.itemEntity);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(r.itemEntity, nextPageKey);
          }

          return MyOrdersState(
            status: OrdersStatus.success,
            entity: r.itemEntity,
          );
        },
      ),
    );
  }

  void setStatusItems(String status,) {
    debugPrint('search call $status');
    if(status != 'all'){
      currentStatus = status;
    } else {
      currentStatus = '';
    }
    emit(state.copyWith(status: OrdersStatus.loading));
    pagingController.refresh();
  }

  void setOrderStatus(bool isMy) {
    atClients = isMy;
    emit(state.copyWith(status: OrdersStatus.loading));
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
