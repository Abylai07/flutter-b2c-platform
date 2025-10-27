import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../../common/app_styles/text_styles.dart';
import '../../../../domain/entity/items/categories_entity.dart';

class CategorySelectWidget extends StatelessWidget {
  const CategorySelectWidget({
    super.key,
    required this.category,
    this.onTap,
  });

  final CategoryEntity category;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.grayBlue,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: 36,
              width: 36,
              imageUrl: category.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            16.width,
            Expanded(
              child: Text(
                category.name,
                style: AppTextStyle.bodyLarge,
              ),
            ),
            8.width,
            const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.gray, size: 16,),
          ],
        ),
      ),
    );
  }
}