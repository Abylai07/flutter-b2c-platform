import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_items_usecase.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';

import '../../../../common/enums.dart';
import '../../../../domain/entity/items/item_entity.dart';

class ItemsCubit extends Cubit<BaseState> {
  final PagingController<int, ItemEntity> pagingController =
  PagingController(firstPageKey: 1);
  final FetchItemsUseCase fetchItemsUseCase;

  ItemsCubit(this.fetchItemsUseCase) : super(const BaseState()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, currentSearchQuery);
    });
  }

  String currentSearchQuery = '';
  List<ItemEntity> initialResults = [];

  Future<void> _fetchPage(int pageKey, String searchQuery) async {

    final failureOrAuth = await fetchItemsUseCase(ItemsParams(page: pageKey.toString(), query: searchQuery));

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
          if (pageKey == 1 && searchQuery.isEmpty && initialResults.isEmpty) {
            initialResults = r.itemEntity;
          }
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

  void searchItems(String query) {
    debugPrint('search call $query');
    currentSearchQuery = query;
    if (query.isEmpty) {
      pagingController.refresh();
      _restoreInitialResults();
    } else {
      pagingController.refresh();
    }
  }

  void _restoreInitialResults() {
    pagingController.itemList = initialResults;
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
