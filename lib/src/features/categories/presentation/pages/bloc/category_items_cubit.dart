import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_items_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';
import '../../../../domain/entity/items/item_entity.dart';

class CategoryItemsCubit extends Cubit<BaseState> {
  final PagingController<int, ItemEntity> pagingController =
      PagingController(firstPageKey: 1);
  final FetchItemsUseCase fetchItemsUseCase;

  CategoryItemsCubit(this.fetchItemsUseCase) : super(const BaseState()) {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey, newId);
    });
  }

  int newId = 0;
  Future<void> fetchPage(int pageKey, int id) async {
    emit(const BaseState(status: CubitStatus.loading));
    pagingController.refresh();
    newId = id;
    final failureOrAuth = await fetchItemsUseCase(ItemsParams(page: pageKey.toString(), categoryId: id));

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

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
