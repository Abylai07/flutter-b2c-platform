import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../common/utils/parsers/date_parser.dart';

void sentOtpAlert(BuildContext context,
    {required TextEditingController controller, required bool error, Function()? onTap}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.white,
        contentPadding:
            EdgeInsets.only(top: 24.h, bottom: 12.h, left: 16, right: 16),
        actionsPadding: EdgeInsets.all(16.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).sentOtp,
              style: AppTextStyle.titleSmall,
              textAlign: TextAlign.center,
            ),
            12.height,
            PinCodeTextField(
              appContext: context,
              length: 6,
              animationType: AnimationType.fade,
              errorTextMargin: const EdgeInsets.only(top: 50),
              errorTextSpace: 20,
              controller: controller,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 50,
                fieldWidth: 40,
                activeColor: AppColors.main,
                selectedColor: AppColors.gray,
                inactiveColor: AppColors.gray,
              ),
              textStyle: AppTextStyle.headlineLarge
                  .copyWith(color: AppColors.main, fontWeight: FontWeight.w400),
              cursorColor: AppColors.main,
              animationDuration: const Duration(milliseconds: 300),
              keyboardType: TextInputType.number,
              inputFormatters: [AppUtils.codeMaskFormatter],
            ),
            if(error)
            Text(
              S.of(context).notRightCode,
              style: AppTextStyle.bodyLarge
                  .copyWith(color: AppColors.errorRedColor),
            ),
          ],
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
                onPressed: onTap,
                child: Text(
                  S.of(context).next,
                  style:
                      AppTextStyle.bodyLarge.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: Center(
                  child: Text(
                S.of(context).back,
                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.main),
              )),
            ),
          ),
        ],
      );
    },
  );
}
