import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_for%20_update.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/select_period.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_types_usecase.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_period_bloc/period_state.dart';

import '../../../../../domain/entity/items/id_name_entity.dart';

class PeriodSelectCubit extends Cubit<PeriodSelectState> {
  PeriodSelectCubit(this.fetchTypesUseCase) : super(const PeriodSelectState());

  final FetchTypesUseCase fetchTypesUseCase;

  void fetchPeriodTypes({ItemForUpdateEntity? myItem}) async {
    emit(const PeriodSelectState(status: PeriodStatus.loading));

    final failureOrAuth = await fetchTypesUseCase.fetchPeriods();
    emit(
      failureOrAuth.fold(
        (l) => PeriodSelectState(
          status: PeriodStatus.error,
          message: l.message,
        ),
        (r) {
          List<SelectPeriod> selectedPeriods = [];
          if(myItem != null){
             for(final item in myItem.periods){
               for(final period in r){
                 if(item.period == period.id.toString()){
                   selectedPeriods.add(SelectPeriod(period: period, price: item.price.toInt().toString()));
                 }
               }
             }
          } else {
            selectedPeriods = [SelectPeriod(period: r[0])];
          }
          return PeriodSelectState(
              status: PeriodStatus.success,
              entity: r,
              selectedPeriods: selectedPeriods,
          );
        },
      ),
    );
  }



  void setEditState() {
    emit(state.copyWith(status: PeriodStatus.edit));
  }

  void setSuccessState() {
    emit(state.copyWith(status: PeriodStatus.success));
  }

  void removeSelected() {
    final selectedPeriods = state.selectedPeriods!;
    selectedPeriods.removeWhere((element) => state.selectRemove?.contains(element.period.id) ?? false);
    if(selectedPeriods.isEmpty){
      selectedPeriods.add(SelectPeriod(period: state.entity!.first));
    }
    emit(state.copyWith(
      status: PeriodStatus.success,
      selectedPeriods: selectedPeriods,
    ));
  }

  void selectRemove(int id) {
    List<int> newList = List.from(state.selectRemove ?? []);
    if (newList.contains(id)) {
      newList.remove(id);
      emit(state.copyWith(
        selectRemove: newList,
      ));
    } else {
      newList.add(id);
      emit(state.copyWith(
        selectRemove: newList,
      ));
    }
  }

  void addPeriod(List<SelectPeriod>? periods) {
    emit(state.copyWith(
      selectedPeriods: periods,
    ));
  }

  void selectPeriods(int index, IdNameEntity period) {
    final newPeriods = state.selectedPeriods ?? [];
    newPeriods[index].period = period;
    emit(state.copyWith(selectedPeriods: newPeriods));
  }

  void updateTextValue(int index, String value) {
    final newTextValues = state.selectedPeriods ?? [];
    newTextValues[index].price = value;
    emit(state.copyWith(selectedPeriods: newTextValues));
  }

  bool validateTextFields() {
    return (state.selectedPeriods?.every((value) => value.price != null && value.price!.isNotEmpty) ?? false);
  }
}
