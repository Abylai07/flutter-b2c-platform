import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/bloc/create_place/create_place_state.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/widgets/select_add_address_widget.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/items/item_detail_entity.dart';
import '../../../../widgets/containers/border_container.dart';
import '../../../../widgets/containers/dot_container.dart';
import '../../../../widgets/expandable_theme.dart';
import '../bloc/obtainment_bloc.dart';
import '../bloc/place_list/place_list_cubit.dart';
import '../bloc/place_list/place_list_state.dart';

class ObtainmentPartView extends StatelessWidget {
  const ObtainmentPartView({
    super.key,
    required this.obtainmentTypes,
    required this.places,
  });

  final List<ObtainmentTypeEntity> obtainmentTypes;
  final List<PlaceEntity> places;

  @override
  Widget build(BuildContext context) {
    ExpandableController expandableController = ExpandableController();
    ExpandableController addressController = ExpandableController();

    return BlocBuilder<ObtainmentTypeBloc, ObtainmentTypeState>(
      builder: (context, state) {
        if (state is ObtainmentTypeChanged) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderContainer(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppColors.mainBlue,
                child: ExpandablePanel(
                  controller: expandableController,
                  theme: buildExpandableThemeData(),
                  header: Text(
                    state.obtainmentType.name,
                    style: AppTextStyle.bodyLarge,
                  ),
                  collapsed: const SizedBox(),
                  expanded: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: obtainmentTypes.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<ObtainmentTypeBloc>()
                                .add(ChangeObtainmentType(obtainmentTypes[i]));
                            expandableController.toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              obtainmentTypes[i].name,
                              style: AppTextStyle.labelLarge.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              if (state.obtainmentType.id == 2) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    S.of(context).address,
                    style: AppTextStyle.titleSmall,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SelectAddAddress(),
              ] else if (state.obtainmentType.id == 1 && places.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    S.of(context).address,
                    style: AppTextStyle.titleSmall,
                    textAlign: TextAlign.start,
                  ),
                ),
                BlocBuilder<PlaceListCubit, PlaceListState>(
                  builder: (context, state) {
                    return BorderContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ExpandablePanel(
                        controller: addressController,
                        theme: buildExpandableThemeData(),
                        header: Text(
                          state.shopAddress?.address ?? S.of(context).addressItem,
                          style: AppTextStyle.bodyLarge.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: places.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<PlaceListCubit>()
                                      .selectShop(places[i]);
                                  addressController.toggle();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          places[i].address ?? '',
                                          style: AppTextStyle.labelLarge,
                                        ),
                                      ),
                                      PointContainer(
                                        value: places[i].id ==
                                            state.shopAddress?.id,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                ),
              ]
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
