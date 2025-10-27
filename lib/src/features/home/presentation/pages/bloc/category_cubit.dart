import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_categories_usecase.dart';

import '../../../bloc/base_state.dart';


class CategoryCubit extends Cubit<BaseState> {
  CategoryCubit(this.fetchCategoriesUseCase) : super(const BaseState());

  final FetchCategoriesUseCase fetchCategoriesUseCase;

  void fetchCategories() async {
    emit(const BaseState(status: CubitStatus.loading));

    final failureOrAuth = await fetchCategoriesUseCase(null);

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
