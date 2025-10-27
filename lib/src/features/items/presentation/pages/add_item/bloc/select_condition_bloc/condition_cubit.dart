import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_condition_usecase.dart';

import '../../../../../common/enums.dart';
import '../../../../../domain/entity/items/id_name_entity.dart';
import 'condition_state.dart';

class ConditionSelectCubit extends Cubit<ConditionSelectState> {
  ConditionSelectCubit(this.fetchConditionUseCase)
      : super(const ConditionSelectState());

  final FetchConditionUseCase fetchConditionUseCase;

  void fetchConditions({int? id}) async {
    emit(const ConditionSelectState(status: CubitStatus.loading));

    final failureOrAuth = await fetchConditionUseCase.fetchConditions();
    emit(
      failureOrAuth.fold(
        (l) => ConditionSelectState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          IdNameEntity? selectCondition;
          if (id != null) {
            for (final item in r) {
              if(item.id == id){
                selectCondition = item;
              }
            }
          } else {
            selectCondition = r[0];
          }
          return ConditionSelectState(
            status: CubitStatus.success,
            entity: r,
            selectCondition: selectCondition,
          );
        },
      ),
    );
  }

  void selectCondition(IdNameEntity? condition) {
    emit(state.copyWith(selectCondition: condition));
  }
}
