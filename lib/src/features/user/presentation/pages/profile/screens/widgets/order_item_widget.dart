import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/utils/constants.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/main_functions.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key, required this.onTap, required this.item});
  final Function()? onTap;
  final OrderItemEntity item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 4),
            child: Text(getRussianDate(item.created), style: AppTextStyle.displayLarge.copyWith(color: AppColors.gray),),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).orderNum(item.id), style: AppTextStyle.displayLarge.copyWith(color: AppColors.gray),),
                    Text(getNameByStatus(context, item.status) ?? '', style: AppTextStyle.displayLarge.copyWith(color: getColorByStatus(item.status)),),
                  ],
                ),
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: Text(item.title, style: AppTextStyle.bodyLarge,)),
                    Text('${item.price.toInt()} ₸', style: AppTextStyle.bodyLarge.copyWith(color: AppColors.black),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
