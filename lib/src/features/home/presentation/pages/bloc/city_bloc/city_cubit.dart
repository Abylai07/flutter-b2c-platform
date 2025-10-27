import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_city_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/utils/shared_preference.dart';
import '../../../../../domain/entity/user/city_entity.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.fetchCityUseCase) : super(const CityState());

  final FetchCityUseCase fetchCityUseCase;

  void fetchCityList() async {
    emit(const CityState(status: CubitStatus.loading));

    final failureOrAuth = await fetchCityUseCase(null);

    emit(
      failureOrAuth.fold(
        (l) => CityState(
          status: CubitStatus.error,
          message: l.message,
        ),
        (r) {
          int? cityId = SharedPrefs().getCityId();
          CityEntity? city;

          if (cityId != null) {
            city = r.firstWhere((element) => element.id == cityId);
          }

          return CityState(
            status: CubitStatus.success,
            entity: r,
            selectCity: city,
          );
        },
      ),
    );
  }

  selectCity(CityEntity? city) {
    emit(state.copyWith(selectCity: city));
  }
}
