import 'package:flutter/material.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';

class ConditionContainer extends StatelessWidget {
  const ConditionContainer({super.key, required this.condition, this.isBigger = false});
  final String condition;
  final bool isBigger;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: isBigger ? 10 : 6 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isBigger ? 16 : 12),
        color: getColorByStatus(condition),
      ),
      child: Text(
        condition,
        style: isBigger ? AppTextStyle.labelLarge.copyWith(color: AppColors.white) : AppTextStyle.displaySmall.copyWith(color: AppColors.white),
      ),
    );
  }


  getColorByStatus(String status){
    switch(status){
      case 'Новое':
        return AppColors.green2;
      case 'Идеальное':
        return AppColors.green2;
      case 'Хорошее':
        return AppColors.orange2;
      case 'Удовлетворительное':
        return AppColors.red2;
      default:
        return AppColors.blue;
    }
  }
}
