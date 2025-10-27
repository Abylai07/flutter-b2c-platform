import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/items/id_name_entity.dart';
import '../../../../domain/entity/order/select_period.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/main_functions.dart';
import '../../../widgets/show_error_snackbar.dart';
import '../../../widgets/text_fields/period_text_field.dart';
import '../bloc/select_period_bloc/period_cubit.dart';
import '../bloc/select_period_bloc/period_state.dart';

class AddPeriodPart extends StatelessWidget {
  const AddPeriodPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeriodSelectCubit, PeriodSelectState>(
      builder: (context, state) {
        if (state.status.isSuccess || state.status.isEdit) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, top: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        S.of(context).rentCost,
                        style: AppTextStyle.titleSmall,
                      ),
                    ),
                    if ((state.selectedPeriods?.length ?? 0) > 1)
                      InkWell(
                        onTap: () {
                          if (state.status.isEdit) {
                            context.read<PeriodSelectCubit>().setSuccessState();
                          } else {
                            context.read<PeriodSelectCubit>().setEditState();
                          }
                        },
                        child: Text(
                          state.status.isEdit
                              ? S.of(context).cancel
                              : S.of(context).edit,
                          style: AppTextStyle.displayLarge
                              .copyWith(color: AppColors.errorRedColor),
                        ),
                      )
                  ],
                ),
              ),
              Text(
                S.of(context).costAutomatic,
                style: AppTextStyle.displayMedium.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.gray),
              ),
              12.height,
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.selectedPeriods?.length,
                  itemBuilder: (context, i) {
                    SelectPeriod? currentPeriod = state.selectedPeriods?[i];
                    return Padding(
                      key: ValueKey(state.selectedPeriods?[i].period.id),
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: PeriodTextField(
                                initialValue:
                                    (state.selectedPeriods?.length ?? 0) > i
                                        ? currentPeriod?.price
                                        : '',
                                onChanged: (value) {
                                  context
                                      .read<PeriodSelectCubit>()
                                      .updateTextValue(
                                          i, removeNonNumeric(value));
                                }),
                          ),
                          12.width,
                          Expanded(
                            child: CustomDropdown<IdNameEntity>(
                                items: state.entity,
                                decoration: CustomDropdownDecoration(
                                  hintStyle: AppTextStyle.labelLarge
                                      .copyWith(color: AppColors.gray2),
                                  closedBorder: Border.all(
                                    color: AppColors.mainBlue,
                                  ),
                                  closedBorderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                ),
                                closedHeaderPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                initialItem: currentPeriod?.period,
                                onChanged: (value) {
                                  context
                                      .read<PeriodSelectCubit>()
                                      .selectPeriods(i, value);
                                },
                                listItemBuilder: (context, item, show, func) {
                                  return Text(item.nameSingle ?? '',
                                      style: AppTextStyle.labelLarge);
                                },
                                headerBuilder: (context, item) {
                                  return Text(item.nameSingle ?? '',
                                      style: AppTextStyle.bodyLarge);
                                }),
                          ),
                          if (state.status.isEdit)
                            Checkbox(
                                splashRadius: 42,
                                checkColor: AppColors.mainBlue,
                                activeColor: AppColors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(
                                      width: 1.0, color: AppColors.mainBlue),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                value: state.selectRemove == null
                                    ? false
                                    : state.selectRemove
                                        ?.contains(currentPeriod?.period.id),
                                onChanged: (val) {
                                  context
                                      .read<PeriodSelectCubit>()
                                      .selectRemove(currentPeriod!.period.id);
                                }),
                        ],
                      ),
                    );
                  }),
              12.height,
              state.status.isEdit
                  ? TextButton(
                      onPressed: () {
                        context.read<PeriodSelectCubit>().removeSelected();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete_forever_outlined,
                            color: AppColors.errorRedColor,
                          ),
                          8.width,
                          Text(
                            S.of(context).removeSelect,
                            style: AppTextStyle.titleSmall
                                .copyWith(color: AppColors.errorRedColor),
                          )
                        ],
                      ),
                    )
                  : CustomBlueButton(
                      isActive: (state.selectedPeriods?.length ?? 0) <
                          (state.entity?.length ?? 0),
                      text: S.of(context).addPeriod,
                      onTap: () {
                        if (context
                            .read<PeriodSelectCubit>()
                            .validateTextFields()) {
                          IdNameEntity newPeriod = state.entity!.firstWhere(
                            (element) =>
                                state.selectedPeriods?.every(
                                    (periods) => periods.period != element) ??
                                false,
                          );
                          if (newPeriod.name.isNotEmpty) {
                            context.read<PeriodSelectCubit>().addPeriod(
                              [
                                ...?state.selectedPeriods,
                                SelectPeriod(period: newPeriod)
                              ],
                            );
                          }
                        } else {
                          showErrorSnackBar(context, S.of(context).fillCost);
                        }
                      },
                    ),
            ],
          );
        } else if (state.status.isLoading) {
          return const Center(
            child: SizedBox(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
