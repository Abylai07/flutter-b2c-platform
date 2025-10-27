import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';

void successBookAlert(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        contentPadding: EdgeInsets.only(top: 24.h, bottom: 12.h, left: 16, right: 16),
        actionsPadding: EdgeInsets.all(16.w),
        content: Text(
          S.of(context).bookSuccess,
          style: AppTextStyle.titleSmall,
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onPressed: () {
                  Navigator.pop(context);
                  context.router.push(const IndexRoute(children: [ProfileRoute()]));
                  context.router.push(const OrdersRoute());
                },
                child: Text(
                  S.of(context).orderHistory,
                  style:
                      AppTextStyle.bodyLarge.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: Center(child: Text(S.of(context).back, style: AppTextStyle.bodyLarge.copyWith(color: AppColors.main),)),
            ),
          ),
        ],
      );
    },
  );
}
