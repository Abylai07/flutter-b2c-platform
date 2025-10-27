import 'package:flutter/material.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/main_functions.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: getColor(status),
      ),
      child: Text(
        getName(context, status) ?? '',
        style: AppTextStyle.labelLarge.copyWith(color: AppColors.white),
      ),
    );
  }

  String? getName(BuildContext ctx, String key){
    final data = {
      'new' : S.of(ctx).newNew,
      'accepted' : S.of(ctx).accept,
      'in_progress' : S.of(ctx).inProgressStatus,
      'closed' : S.of(ctx).close,
    };
    return data[key];
  }


  Color? getColor(String key){
    final data = {
      'new' :  AppColors.green,
      'accepted' :  AppColors.orange2,
      'in_progress' :  AppColors.mainBlue,
      'closed' : AppColors.errorRedColor,
    };
    return data[key];
  }
}