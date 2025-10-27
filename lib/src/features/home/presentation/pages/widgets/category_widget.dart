import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';

import '../../../../common/app_styles/colors.dart';
import '../../../../common/app_styles/text_styles.dart';
import '../../../../domain/entity/items/categories_entity.dart';

class CategoryHomeWidget extends StatelessWidget {
  const CategoryHomeWidget({
    super.key,
    required this.category,
    required this.index,
  });

  final CategoryEntity category;
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [const Color(0xFFD8E5FF), const Color(0xFFFFE6D8),  const Color(0xFFF3F1BC),  const Color(0xFFD8F4DB)];
    final color = colors[index % colors.length];
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: (){
          context.router.push(SubCategoriesRoute(category: category));
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(
                child: CachedNetworkImage(
                  height: 64,
                  imageUrl: category.image,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            8.height,
            SizedBox(
                width: 90,
                child: Text(
                  category.name,
                  style: AppTextStyle.displayMedium.copyWith(
                      fontWeight: FontWeight.w500, color: AppColors.black),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.index,
  });

  final CategoryEntity category;
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [const Color(0xFFD8E5FF), const Color(0xFFFFE6D8),  const Color(0xFFF3F1BC),  const Color(0xFFD8F4DB)];
    final color = colors[index % colors.length];

    return InkWell(
      onTap: (){
        context.router.push(SubCategoriesRoute(category: category));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: CachedNetworkImage(
              height: 52,
              width: 52,
              imageUrl: category.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          16.width,
          Expanded(
            child: Text(
              category.name,
              style: AppTextStyle.bodyLarge.copyWith(color: AppColors.black),
            ),
          ),
          8.width,
          const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.gray,),
        ],
      ),
    );
  }
}