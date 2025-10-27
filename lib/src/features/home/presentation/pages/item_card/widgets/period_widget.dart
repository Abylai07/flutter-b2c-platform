import 'package:flutter/material.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/items/item_entity.dart';

class PeriodContainer extends StatelessWidget {
  const PeriodContainer({
    super.key,
    required this.period,
    required this.selected,
  });

  final PeriodEntity period;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.mainBlue.withOpacity(0.5) : null,
        border: selected ? null : Border.all(color: AppColors.mainBlue),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            period.period,
            style: AppTextStyle.labelLarge.copyWith(
                color: selected ? AppColors.white : AppColors.mainBlue),
          ),
          Text(
            S.of(context)
                .price(period.price.toInt(), getPeriodByName(period.period)),
            style: AppTextStyle.displayLarge.copyWith(
                color: selected ? AppColors.white : AppColors.mainBlue),
          ),
        ],
      ),
    );
  }

  getPeriodByName(String name) {
    switch (name) {
      case 'На час':
        return 'ч';
      case 'На день':
        return 'д';
      case 'На неделю':
        return 'н';
      default:
        return '';
    }
  }
}