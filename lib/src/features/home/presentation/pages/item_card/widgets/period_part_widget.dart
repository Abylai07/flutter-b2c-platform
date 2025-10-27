import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/widgets/period_widget.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/items/item_entity.dart';
import '../bloc/period_bloc.dart';

class PeriodPartView extends StatelessWidget {
  const PeriodPartView({super.key, required this.periods});
  final List<PeriodEntity> periods;
  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = [];

    fillDropDown(String status) {
      switch (status) {
        case 'На час':
          dropdownItems = List.generate(23, (index) => '${index + 1} ч');
          break;
        case 'На день':
          dropdownItems = List.generate(6, (index) => '${index + 1} д');
          break;
        case 'На неделю':
          dropdownItems = List.generate(4, (index) => '${index + 1} н');
          break;
        default:
          dropdownItems = ['1'];
      }
    }
    return BlocBuilder<PeriodBloc, PeriodState>(
      builder: (context, state) {
        if (state is PeriodWithPrice) {
          fillDropDown(state.selectedPeriod.period);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, bottom: 6),
                child: Text(
                  S.of(context).period,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              SizedBox(
                height: 66,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: periods.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<PeriodBloc>(
                              context)
                              .add(
                              SelectPeriodWithPrice(
                                  periods[i],
                                  1));
                        },
                        child: PeriodContainer(
                          selected: state.selectedPeriod
                              .period ==
                              periods[i].period,
                          period: periods[i],
                        ),
                      );
                    }),
              ),
              8.height,
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown<String>(
                      closedHeaderPadding: const EdgeInsets.all(12),
                      items: dropdownItems,
                      decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(color: AppColors.mainBlue,),
                        closedBorderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                      initialItem: dropdownItems[0],
                      onChanged: (value) {
                        List list = value.split(' ');
                        BlocProvider.of<PeriodBloc>(
                            context)
                            .add(SelectPeriodWithPrice(
                            state.selectedPeriod,
                            int.parse(list.first)));
                      },
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.mainBlue),
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          '₸ ${state.selectedPeriod.price.toInt() * state.count}',
                          style: AppTextStyle.titleSmall,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
