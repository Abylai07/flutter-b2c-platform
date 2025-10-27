import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/order_item/payment/payment_status.dart';
import 'package:b2c_platform/src/presentation/widgets/buttons/main_button.dart';

import '../../../../../../common/app_styles/colors.dart';

successAlert(BuildContext context) {
  paymentAlertDialog(
    context: context,
    title: 'Поздравляем',
    description: 'Ваша оплата подтверждена',
    smile: '✌',
    buttonText: 'Назад',
  );
}

insufficientAlert(BuildContext context, String status) {
  paymentAlertDialog(
    context: context,
    title: 'Ошибка',
    description: 'Статус: ${PaymentStatus.getStatusDesc(status)}',
    buttonText: 'Попробовать снова',
  );
}

errorAlert(BuildContext context, String errorStatus) {
  paymentAlertDialog(
    context: context,
    title: 'Что-то пошло не так...',
    description: getErrorDescription(errorStatus),
    buttonText: 'Попробовать снова',
  );
}

void paymentAlertDialog({
  required BuildContext context,
  required String title,
  String? smile,
  String? description,
  required String buttonText,
}) {
  var alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    actionsPadding: EdgeInsets.all(16.w),
    contentPadding: EdgeInsets.all(16.w),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyle.titleLarge,
                ),
                const SizedBox(width: 6),
                smile != null
                    ? Text(
                        smile,
                        style: AppTextStyle.titleSmall,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 16),
            Text(
              description,
              style: AppTextStyle.titleSmall.copyWith(color: AppColors.black),
            ),
          ],
        ],
      ),
    ),
    actions: [
      CustomMainButton(
        text: buttonText,
        onTap: () {
          Navigator.pop(context);
        },
      )
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
