import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/create_item_cubit.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_condition_bloc/condition_state.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_obtainment_bloc/obtainment_cubit.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_obtainment_bloc/obtainment_state.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_period_bloc/period_cubit.dart';
import 'package:b2c_platform/src/presentation/widgets/buttons/main_button.dart';
import 'package:b2c_platform/src/presentation/widgets/containers/border_container.dart';
import 'package:b2c_platform/src/presentation/widgets/containers/dot_container.dart';
import 'package:b2c_platform/src/presentation/widgets/text_fields/custom_text_field.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/items/categories_entity.dart';
import '../../../../domain/entity/items/id_name_entity.dart';
import '../../../../get_it_sl.dart';
import '../../../widgets/expandable_theme.dart';
import '../../../widgets/show_error_snackbar.dart';
import '../../home/item_card/bloc/create_place/create_place_cubit.dart';
import '../../home/item_card/bloc/place_list/place_list_cubit.dart';
import '../../home/item_card/widgets/select_add_address_widget.dart';
import '../bloc/select_condition_bloc/condition_cubit.dart';
import '../widget/add_period_part.dart';
import '../widget/category_select_widget.dart';

@RoutePage()
class AddInfoScreen extends StatelessWidget {
  const AddInfoScreen(
      {super.key,
      required this.titleItem,
      required this.category,
      required this.subCategory});

  final String titleItem;
  final CategoryEntity category;
  final SubcategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeriodSelectCubit>(
          create: (_) => sl<PeriodSelectCubit>()..fetchPeriodTypes(),
        ),
        BlocProvider<ConditionSelectCubit>(
          create: (_) => sl<ConditionSelectCubit>()..fetchConditions(),
        ),
        BlocProvider<PlaceListCubit>(
          create: (_) => sl<PlaceListCubit>()..fetchPlaceList(),
        ),
        BlocProvider<CreatePlaceCubit>(
          create: (_) => sl<CreatePlaceCubit>(),
        ),
        BlocProvider<CreateItemCubit>(
          create: (_) => sl<CreateItemCubit>(),
        ),
        BlocProvider<ObtainmentSelectCubit>(
          create: (_) => sl<ObtainmentSelectCubit>()..fetchObtainment(),
        ),
      ],
      child: AddInfoView(
        titleItem: titleItem,
        category: category,
        subCategory: subCategory,
      ),
    );
  }
}

class AddInfoView extends StatelessWidget {
  const AddInfoView(
      {super.key,
      required this.titleItem,
      required this.category,
      required this.subCategory});

  final String titleItem;
  final CategoryEntity category;
  final SubcategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    ExpandableController conditionController = ExpandableController();
    TextEditingController descController = TextEditingController();

    createItem() {
      final state = context.read<PeriodSelectCubit>().state;
      if (state.selectedPeriods?.every((element) => element.price != null) ??
          false) {
        final condition = context.read<ConditionSelectCubit>().state;
        final address = context.read<PlaceListCubit>().getSelectPlaces();
        final obtainment = context.read<ObtainmentSelectCubit>().getSelectedObtainment();
        final returns = context.read<ObtainmentSelectCubit>().getSelectedReturns();

        List<Map<String, dynamic>> periods = [];
        for (final item in state.selectedPeriods ?? []) {
          periods.add({
            'period': item.period.id,
            'price': int.parse(item.price),
          });
        }

        context.read<CreateItemCubit>().createItem({
          'title': titleItem,
          'sub_category': subCategory.id,
          'description': descController.text,
          'bail': false,
          'condition': condition.selectCondition?.id,
          'periods': periods,
          'obtainment_types': obtainment,
          'places': address,
          'return_types': returns,
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).fillCost),
            backgroundColor: AppColors.errorRedColor,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.mainBlue,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          S.of(context).addItem,
          style: AppTextStyle.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).itemName,
                style: AppTextStyle.titleSmall,
              ),
              BorderContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 24.0, top: 12),
                child: Text(
                  titleItem,
                  style:
                      AppTextStyle.labelLarge.copyWith(color: AppColors.black),
                ),
              ),
              Text(
                S.of(context).selectCategory,
                style: AppTextStyle.titleSmall,
              ),
              12.height,
              CategorySelectWidget(category: category),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 8),
                child: Text(
                  S.of(context).subCategories,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      subCategory.name,
                      style: AppTextStyle.labelLarge
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: AppColors.gray,
                    size: 16,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 24),
                child: Text(
                  S.of(context).conditionItem,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              BlocBuilder<ConditionSelectCubit, ConditionSelectState>(
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    return BorderContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ExpandablePanel(
                        controller: conditionController,
                        theme: buildExpandableThemeData(),
                        header: Text(
                          state.selectCondition?.name ?? '',
                          style: AppTextStyle.bodyLarge.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        collapsed: const SizedBox(),
                        expanded: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: state.entity?.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<ConditionSelectCubit>()
                                      .selectCondition(state.entity?[i]);
                                  conditionController.toggle();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    state.entity?[i].name ?? '',
                                    style: AppTextStyle.labelLarge.copyWith(
                                      color: state.selectCondition?.id ==
                                              state.entity?[i].id
                                          ? AppColors.black
                                          : AppColors.gray2,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  } else if (state.status.isLoading) {
                    return const Center(
                      child: SizedBox(),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const AddPeriodPart(),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, top: 24),
                child: Text(
                  S.of(context).descriptionItem,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              CustomTextFieldWidget(
                minLines: 5,
                maxLines: 5,
                controller: descController,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, top: 16),
                child: Text(
                  S.of(context).address,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              const SelectAddAddress(
                multiSelect: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  S.of(context).obtainAndReturn,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              BlocBuilder<ObtainmentSelectCubit, ObtainmentSelectState>(
                builder: (context, state) {
                  if (state.status.isSuccess) {
                    return Row(
                      children: [
                        Expanded(
                          child: CustomDropdown<IdNameEntity>(
                              excludeSelected: false,
                              hideSelectedFieldWhenExpanded: true,
                              decoration: CustomDropdownDecoration(
                                hintStyle: AppTextStyle.labelLarge
                                    .copyWith(color: AppColors.gray2),
                                closedBorder: Border.all(color: AppColors.mainBlue,),
                                closedBorderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                              closedHeaderPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              items: state.obtainmentList,
                              hintText: S.of(context).howObtain,
                              onChanged: (value) {
                                context
                                    .read<ObtainmentSelectCubit>()
                                    .selectObtain(value);
                              },
                              listItemBuilder: (context, item, show, func) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(item.name,
                                          style: AppTextStyle.labelLarge),
                                    ),
                                    PointContainer(
                                        value: state.selectedObtains
                                                ?.contains(item) ??
                                            false)
                                  ],
                                );
                              },
                              headerBuilder: (context, item) {
                                return Text(item.name,
                                    style: AppTextStyle.bodyLarge);
                              }),
                        ),
                        12.width,
                        Expanded(
                          child: CustomDropdown<IdNameEntity>(
                              excludeSelected: false,
                              hideSelectedFieldWhenExpanded: true,
                              decoration: CustomDropdownDecoration(
                                hintStyle: AppTextStyle.labelLarge
                                    .copyWith(color: AppColors.gray2),
                                closedBorder: Border.all(color: AppColors.mainBlue,),
                                closedBorderRadius: const BorderRadius.all(Radius.circular(16)),
                              ),
                              closedHeaderPadding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              items: state.returnList,
                              hintText: S.of(context).howReturn,
                              onChanged: (value) {
                                context
                                    .read<ObtainmentSelectCubit>()
                                    .selectReturn(value);
                              },
                              listItemBuilder: (context, item, show, func) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(item.name,
                                          style: AppTextStyle.labelLarge),
                                    ),
                                    PointContainer(
                                        value: state.selectedReturns
                                                ?.contains(item) ??
                                            false)
                                  ],
                                );
                              },
                              headerBuilder: (context, item) {
                                return Text(item.name,
                                    style: AppTextStyle.bodyLarge);
                              }),
                        ),
                      ],
                    );
                  } else if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              24.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<CreateItemCubit, BaseState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.router.push(AddPhotoRoute(createItem: state.entity));
          } else if (state.status.isError) {
            showErrorSnackBar(context, S.of(context).fillAll);
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: CustomMainButton(
              isLoading: state.status.isLoading,
              text: S.of(context).next,
              onTap: createItem,
            ),
          ));
        },
      ),
    );
  }
}
