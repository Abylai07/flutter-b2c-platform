import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_my_items_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';

class MyItemCubit extends Cubit<BaseState> {
  final PagingController<int, MyItemEntity> pagingController =
      PagingController(firstPageKey: 1);
  final FetchMyItemUseCase fetchItemsUseCase;

  MyItemCubit(this.fetchItemsUseCase) : super(const BaseState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, currentStatus);
    });
  }

  String currentStatus = '';

  Future<void> _fetchPage(int pageKey, String status) async {
    final failureOrAuth = await fetchItemsUseCase(
        PaginationParams(page: pageKey, status: status));

    print('_fetchPage $status');
    emit(
      failureOrAuth.fold(
        (l) {
          pagingController.error = l.message;
          return BaseState(
            status: CubitStatus.error,
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

          return BaseState(
            status: CubitStatus.success,
            entity: r,
          );
        },
      ),
    );
  }

  void setStatusItems(String status) {
    currentStatus = status;
    pagingController.refresh();
    emit(state.copyWith(status: CubitStatus.loading));
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
