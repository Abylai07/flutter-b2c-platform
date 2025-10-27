import 'package:flutter/material.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';


class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({
    super.key,
    required this.description,
    this.title,
    this.onTap,
  });
  final String? title;
  final String description;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(title != null)
                    Text(
                      title ?? '',
                      style: AppTextStyle.displayLarge.copyWith(color: AppColors.gray),
                    ),
                  Text(
                    description,
                    style: AppTextStyle.bodyLarge,
                  ),
                ],
              )),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            size: 16,
            color: AppColors.gray4,
          ),
        ],
      ),
    );
  }
}