import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/geocoding/geocoding.dart';
import '../../../../../common/utils/geocoding/geocoding_model.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../common/utils/shared_preference.dart';
import '../../../../widgets/containers/border_container.dart';
import '../../../../widgets/containers/dot_container.dart';
import '../../../../widgets/expandable_theme.dart';
import '../../../../widgets/text_fields/custom_text_field.dart';
import '../bloc/create_place/create_place_cubit.dart';
import '../bloc/create_place/create_place_state.dart';
import '../bloc/place_list/place_list_cubit.dart';
import '../bloc/place_list/place_list_state.dart';
import 'create_place_alert.dart';

class SelectAddAddress extends StatelessWidget {
  const SelectAddAddress({super.key, this.multiSelect = false});
  final bool multiSelect;

  @override
  Widget build(BuildContext context) {
    ExpandableController addressController = ExpandableController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<PlaceListCubit, PlaceListState>(
          builder: (context, state) {
            if (state.status.isSuccess) {
              return BorderContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpandablePanel(
                  controller: addressController,
                  theme: buildExpandableThemeData(),
                  header: Text(
                    multiSelect
                        ? (state.multiSelect?.length ?? 0) < 1
                            ? S.of(context).addressItem
                            : S.of(context).selected(state.multiSelect?.length ?? 0)
                        : state.selectPlace?.address ?? '',
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  collapsed: const SizedBox(),
                  expanded: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.entity?.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<PlaceListCubit>()
                                .selectPlace(state.entity?[i], multiSelect);
                            multiSelect ? null : addressController.toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.entity?[i].address ?? '',
                                    style: AppTextStyle.labelLarge,
                                  ),
                                ),
                                PointContainer(
                                  value: multiSelect
                                      ? (state.multiSelect?.any((element) =>
                                              element.id ==
                                              state.entity?[i].id) ??
                                          false)
                                      : (state.entity?[i].id ==
                                          state.selectPlace?.id),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              );
            } else if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        12.height,
        BlocConsumer<CreatePlaceCubit, CreatePlaceState>(
          listener: (BuildContext context, CreatePlaceState<dynamic> state) {
            if (state.status == PlaceStatus.success) {
              context.read<PlaceListCubit>().fetchPlaceList();
              context
                  .read<CreatePlaceCubit>()
                  .setPlaceStatus(PlaceStatus.initial);
            }
          },
          builder: (context, state) {
            if (state.status.isInitial) {
              return InkWell(
                  onTap: () {
                    context
                        .read<CreatePlaceCubit>()
                        .setPlaceStatus(PlaceStatus.search);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle_outline,
                        color: AppColors.mainBlue,
                      ),
                      8.width,
                      Text(
                        S.of(context).addAddress,
                        style: AppTextStyle.titleSmall,
                      ),
                    ],
                  ));
            } else if (state.status.isSearch) {
              List<GeocodingModel> places = state.searchResult ?? [];

              return Column(
                children: [
                  SearchTextFieldWidget(
                    isNotFilled: false,
                    hintText: S.of(context).search,
                    onChanged: (value) async {
                      if (value != null) {
                        await Geocoding().autocomplete(value).then((result) {
                          if (result.isEmpty) return;
                          context.read<CreatePlaceCubit>().searchResult(result);
                        });
                      }
                    },
                  ),
                  12.height,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: places.isNotEmpty
                          ? EdgeInsets.zero
                          : const EdgeInsets.all(12),
                      itemCount: places.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            createPlaceAlert(context, places[i], () async {
                              int? id = SharedPrefs().getCityId();
                              await Geocoding()
                                  .fetchCoordinates(places[i].placeId)
                                  .then((result) {
                                context.read<CreatePlaceCubit>().createPlace({
                                  "address": places[i].description,
                                  "lat": result.first,
                                  "lon": result.last,
                                  "city": id,
                                  "save_to_profile": true,
                                });
                              });
                            });
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.mainBlue,
                              ),
                              8.width,
                              Expanded(
                                child: Text(
                                  places[i].description,
                                  style: AppTextStyle.labelLarge,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          12.height,
                    ),
                  ),
                ],
              );
            } else if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
