import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/create_place_usecase.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import '../../../../../../common/utils/geocoding/geocoding_model.dart';
import 'create_place_state.dart';

class CreatePlaceCubit extends Cubit<CreatePlaceState> {
  CreatePlaceCubit(this.useCase) : super(const CreatePlaceState());

  final CreatePlaceUseCase useCase;

  void createPlace(Map<String, dynamic> data) async {
    emit(const CreatePlaceState(status: PlaceStatus.loading));

    final failureOrAuth = await useCase(MapParams(data));

    emit(
      failureOrAuth.fold(
        (l) => CreatePlaceState(
          status: PlaceStatus.error,
          message: l.message,
        ),
        (r) => CreatePlaceState(
          status: PlaceStatus.success,
          entity: r,
        ),
      ),
    );
  }

  setPlaceStatus(PlaceStatus status) async {
    emit(CreatePlaceState(status: status));
  }

  searchResult(List<GeocodingModel> list) async {
    emit(const CreatePlaceState(status: PlaceStatus.initial));

    emit(CreatePlaceState(
      status: PlaceStatus.search,
      searchResult: list,
    ));
  }
}
