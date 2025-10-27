import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_places_usecase.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/bloc/place_list/place_list_state.dart';

import '../../../../../../domain/entity/items/item_detail_entity.dart';
import '../create_place/create_place_state.dart';

class PlaceListCubit extends Cubit<PlaceListState> {
  PlaceListCubit(this.useCase) : super(const PlaceListState());

  final FetchPlacesUseCase useCase;

  void fetchPlaceList({List<PlaceEntity>? places}) async {
    emit(state.copyWith(status: PlaceStatus.loading));

    final failureOrAuth = await useCase(null);

    emit(
      failureOrAuth.fold(
        (l) => state.copyWith(
          status: PlaceStatus.error,
          message: l.message,
        ),
        (r) {
          return state.copyWith(
            status: PlaceStatus.success,
            entity: r,
            selectPlace: r.isEmpty ? null : r[0],
            multiSelect: places
          );
        },
      ),
    );
  }

  void selectPlace(PlaceEntity? selectPlace, bool multiSelect) {
    if(multiSelect){
      List<PlaceEntity> list = List.from(state.multiSelect ?? []);
      if(list.any((element) => element.id == selectPlace?.id)){
        list.removeWhere((element) => element.id == selectPlace?.id);
        emit(state.copyWith(multiSelect: list));
      } else {
        list.add(selectPlace!);
        emit(state.copyWith(multiSelect: list));
      }
    } else {
      emit(state.copyWith(selectPlace: selectPlace));
    }
  }

  void selectShop(PlaceEntity? selectPlace) {
    emit(state.copyWith(shopAddress: selectPlace));
  }

  List<int> getSelectPlaces(){
    List<int> list = [];
    for(final item in state.multiSelect ?? []){
      list.add(item.id);
    }
    return list;
  }
}
