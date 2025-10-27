import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_types_usecase.dart';

import '../../../../../domain/entity/items/id_name_entity.dart';
import '../../../../../domain/entity/items/item_for _update.dart';
import 'obtainment_state.dart';

class ObtainmentSelectCubit extends Cubit<ObtainmentSelectState> {
  ObtainmentSelectCubit(this.fetchTypesUseCase)
      : super(const ObtainmentSelectState());

  final FetchTypesUseCase fetchTypesUseCase;

  void fetchObtainment() async {
    emit(const ObtainmentSelectState(status: ObtainmentStatus.loading));

    final obtainment = await fetchTypesUseCase.fetchObtainment();
    final returns = await fetchTypesUseCase.fetchReturns();

    emit(
      obtainment.fold(
        (l) => ObtainmentSelectState(
          status: ObtainmentStatus.error,
          message: l.message,
        ),
        (obtain) => returns.fold(
          (l) => ObtainmentSelectState(
            status: ObtainmentStatus.error,
            message: l.message,
          ),
          (r) {
            return ObtainmentSelectState(
              status: ObtainmentStatus.success,
              obtainmentList: obtain,
              returnList: r,
            );
          },
        ),
      ),
    );
  }

  void selectObtain(IdNameEntity obtainment) {
    List<IdNameEntity> newList = state.selectedObtains ?? [];
    if(newList.contains(obtainment)){
      newList.remove(obtainment);
      emit(state.copyWith(
        selectedObtains: newList,
      ));
    } else {
      newList.add(obtainment);
      emit(state.copyWith(
        selectedObtains: newList,
      ));
    }
  }

  void selectObtainAndReturn(ItemForUpdateEntity myItem) {
    List<IdNameEntity> selectObtain = [];
    List<IdNameEntity> selectReturn = [];

    for(final item in state.obtainmentList!){
      if(myItem.obtainmentTypes.contains(item.id)){
        selectObtain.add(item);
      }
    }

    for(final item in state.returnList!){
      if(myItem.returnTypes.contains(item.id)){
        selectReturn.add(item);
      }
    }
    emit(state.copyWith(
      selectedReturns: selectReturn,
      selectedObtains: selectObtain,
    ));
  }

  void selectReturn(IdNameEntity returns) {
    List<IdNameEntity> newList = state.selectedReturns  ?? [];
    if(newList.contains(returns)){
      newList.remove(returns);
      emit(state.copyWith(
        selectedReturns: newList,
      ));
    } else {
      newList.add(returns);
      emit(state.copyWith(
        selectedReturns: newList,
      ));
    }
  }

  List<int> getSelectedObtainment(){
    if(state.selectedObtains == null) return [];
    List<int> idList = [];

    for(final item in state.selectedObtains!){
      idList.add(item.id);
    }
    return idList;
  }

  List<int> getSelectedReturns(){
    if(state.selectedReturns == null) return [];
    List<int> idList = [];

    for(final item in state.selectedReturns!){
      idList.add(item.id);
    }
    return idList;
  }
}
