import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_for%20_update.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/change_item_usecase.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/edit_item/widgets/edit_photo_part.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/edit_item/widgets/select_category_part.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/items/id_name_entity.dart';
import '../../../../../get_it_sl.dart';
import '../../../../bloc/base_state.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/containers/border_container.dart';
import '../../../../widgets/containers/dot_container.dart';
import '../../../../widgets/expandable_theme.dart';
import '../../../../widgets/show_error_snackbar.dart';
import '../../../../widgets/text_fields/custom_text_field.dart';
import '../../../add_item/bloc/item_photo_cubit.dart';
import '../../../add_item/bloc/photo_bloc/photo_bloc.dart';
import '../../../add_item/bloc/select_condition_bloc/condition_cubit.dart';
import '../../../add_item/bloc/select_condition_bloc/condition_state.dart';
import '../../../add_item/bloc/select_obtainment_bloc/obtainment_cubit.dart';
import '../../../add_item/bloc/select_obtainment_bloc/obtainment_state.dart';
import '../../../add_item/bloc/select_period_bloc/period_cubit.dart';
import '../../../add_item/widget/add_period_part.dart';
import '../../../home/item_card/bloc/create_place/create_place_cubit.dart';
import '../../../home/item_card/bloc/place_list/place_list_cubit.dart';
import '../../../home/item_card/widgets/select_add_address_widget.dart';
import '../../bloc/category_select/category_select_cubit.dart';
import '../../bloc/category_select/category_select_state.dart';
import '../../bloc/change_item_cubit.dart';
import '../../bloc/item_update_cubit.dart';

@RoutePage()
class EditItemScreen extends StatelessWidget {
  const EditItemScreen({super.key, required this.item});

  final MyItemEntity item;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PeriodSelectCubit>(
            create: (_) => sl<PeriodSelectCubit>(),
          ),
          BlocProvider<ConditionSelectCubit>(
            create: (_) => sl<ConditionSelectCubit>(),
          ),
          BlocProvider<PlaceListCubit>(
            create: (_) => sl<PlaceListCubit>(),
          ),
          BlocProvider<CreatePlaceCubit>(
            create: (_) => sl<CreatePlaceCubit>(),
          ),
          BlocProvider<ItemUpdateCubit>(
            create: (_) => sl<ItemUpdateCubit>()..fetchItemUpdate(item.id),
          ),
          BlocProvider<ObtainmentSelectCubit>(
            create: (_) => sl<ObtainmentSelectCubit>()..fetchObtainment(),
          ),
          BlocProvider<CategorySelectCubit>(
            create: (_) => sl<CategorySelectCubit>(),
          ),
          BlocProvider<ChangeItemCubit>(
            create: (_) => sl<ChangeItemCubit>(),
          ),
          BlocProvider<ItemPhotoCubit>(
            create: (_) => sl<ItemPhotoCubit>(),
          ),
          BlocProvider(
            create: (_) => PhotoBloc(),
          ),
        ],
        child: EditItemView(
          item: item,
        ));
  }
}

class EditItemView extends StatelessWidget {
  const EditItemView({super.key, required this.item});

  final MyItemEntity item;

  @override
  Widget build(BuildContext context) {
    ExpandableController conditionController = ExpandableController();
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();

    changeItemData() {
      final state = context.read<PeriodSelectCubit>().state;
      if (state.selectedPeriods?.every((element) => element.price != null) ??
          false) {
        final subcategory =
            context.read<CategorySelectCubit>().state.selectSubCategory;
        final condition = context.read<ConditionSelectCubit>().state;
        final address = context.read<PlaceListCubit>().getSelectPlaces();
        final obtainment =
            context.read<ObtainmentSelectCubit>().getSelectedObtainment();
        final returns =
            context.read<ObtainmentSelectCubit>().getSelectedReturns();

        List<Map<String, dynamic>> periods = [];
        for (final item in state.selectedPeriods ?? []) {
          periods.add({
            'period': item.period.id,
            'price': int.parse(item.price),
          });
        }
        final photo = context.read<PhotoBloc>().state;
        context.read<ChangeItemCubit>().changeItemData(
              PathMapParams(
                data: {
                  'title': titleController.text,
                  'sub_category': subcategory?.id,
                  'description': descController.text,
                  'bail': false,
                  'condition': condition.selectCondition?.id,
                  'periods': periods,
                  'obtainment_types': obtainment,
                  'places': address,
                  'return_types': returns,
                },
                path: item.id.toString(),
              ),
              photo,
            );
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
        centerTitle: false,
        title: Text(
          S.of(context).changeItem,
          style: AppTextStyle.headlineSmall,
        ),
      ),
      body: BlocConsumer<ItemUpdateCubit, BaseState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            ItemForUpdateEntity myItem = state.entity;

            context.read<PhotoBloc>().add(
                AddUrlPhotos(myItem.images));
            context
                .read<CategorySelectCubit>()
                .fetchCategories(myItem.subCategory);
            context
                .read<ConditionSelectCubit>()
                .fetchConditions(id: myItem.condition);
            context
                .read<PlaceListCubit>()
                .fetchPlaceList(places: myItem.places);
            context.read<PeriodSelectCubit>().fetchPeriodTypes(myItem: myItem);
          }
        },
        builder: (context, state) {
          if (state.status.isSuccess) {
            ItemForUpdateEntity myItem = state.entity;
            titleController.text = myItem.title;
            descController.text = myItem.description;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).itemName,
                      style: AppTextStyle.titleSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 16),
                      child: CustomTextFieldWidget(
                        controller: titleController,
                      ),
                    ),
                    EditPhotoPart(
                      item: item,
                    ),
                    Text(
                      S.of(context).selectCategory,
                      style: AppTextStyle.titleSmall,
                    ),
                    8.height,
                    const SelectCategoryPart(),
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
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
                                        child: Text(
                                          state.entity?[i].name ?? '',
                                          style:
                                              AppTextStyle.labelLarge.copyWith(
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
                    BlocConsumer<ObtainmentSelectCubit, ObtainmentSelectState>(
                      listener: (context, state) {
                        if (state.status.isSuccess &&
                            state.selectedReturns == null) {
                          context
                              .read<ObtainmentSelectCubit>()
                              .selectObtainAndReturn(myItem);
                        }
                      },
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
                                      closedBorder: Border.all(
                                        color: AppColors.mainBlue,
                                      ),
                                      closedBorderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(16)),
                                    ),
                                    closedHeaderPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                    items: state.obtainmentList,
                                    initialItem: state.obtainmentList?.first,
                                    hintText: S.of(context).howObtain,
                                    onChanged: (value) {
                                      context
                                          .read<ObtainmentSelectCubit>()
                                          .selectObtain(value);
                                    },
                                    listItemBuilder:
                                        (context, item, show, func) {
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
                                      return Text(
                                          (state.selectedObtains?.length ?? 0) >
                                                  0
                                              ? S.of(context).selected(state
                                                      .selectedObtains
                                                      ?.length ??
                                                  '')
                                              : S.of(context).howObtain,
                                          style: AppTextStyle.bodyLarge);
                                    }),
                              ),
                              12.width,
                              Expanded(
                                child: CustomDropdown<IdNameEntity>(
                                    excludeSelected: false,
                                    hideSelectedFieldWhenExpanded: true,
                                    initialItem: state.returnList?.first,
                                    decoration: CustomDropdownDecoration(
                                      hintStyle: AppTextStyle.labelLarge
                                          .copyWith(color: AppColors.gray2),
                                      closedBorder: Border.all(
                                        color: AppColors.mainBlue,
                                      ),
                                      closedBorderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(16)),
                                    ),
                                    closedHeaderPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                    items: state.returnList,
                                    hintText: S.of(context).howReturn,
                                    onChanged: (value) {
                                      context
                                          .read<ObtainmentSelectCubit>()
                                          .selectReturn(value);
                                    },
                                    listItemBuilder:
                                        (context, item, show, func) {
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
                                      return Text(
                                          (state.selectedReturns?.length ?? 0) >
                                                  0
                                              ? S.of(context).selected(state
                                                      .selectedReturns
                                                      ?.length ??
                                                  '')
                                              : S.of(context).howReturn,
                                          style: AppTextStyle.bodyLarge);
                                    }),
                              ),
                            ],
                          );
                        } else if (state.status.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    24.height,
                  ],
                ),
              ),
            );
          } else if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: BlocConsumer<ChangeItemCubit, BaseState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.router.maybePop('updatePage');
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
              isActive:
                  context.watch<CategorySelectCubit>().state.status.isSuccess,
              text: S.of(context).save,
              onTap: changeItemData,
            ),
          ));
        },
      ),
    );
  }
}
