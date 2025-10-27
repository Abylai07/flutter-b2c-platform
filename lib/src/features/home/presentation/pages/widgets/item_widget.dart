import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/items/item_entity.dart';
import '../../../widgets/shimmer_widget.dart';
import 'condition_container.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.onTap, required this.item});
  final Function()? onTap;
  final ItemEntity item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 164,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: item.outsideImages.isNotEmpty || item.images.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: item.outsideImages.isEmpty ? item.images[0] : item.outsideImages[0],
                              fit: BoxFit.fitWidth,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => const ShimmerWidget(width: double.infinity, height: 164,),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const SizedBox(),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: ConditionContainer(
                        condition: item.condition,
                      ),
                    ),
                  ],
                ),
              ),
              4.height,
              Text(
                item.title,
                maxLines: 1,
                style:
                    AppTextStyle.bodyLarge.copyWith(color: AppColors.textBlack),
              ),
              Text(
                item.createdUser?.firstName ?? '',
                style:
                    AppTextStyle.displaySmall.copyWith(color: AppColors.gray),
              ),
              if (item.periods.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                  child: Text(
                    S.of(context).priceTg(item.periods[0].price.toInt(),
                        item.periods[0].period.split(' ').last),
                    style: AppTextStyle.bodyLarge
                        .copyWith(color: AppColors.textBlack),
                  ),
                ),
              BookButton(text: S.of(context).rent),
            ],
          ),
        ),
      ),
    );
  }
}

class BookButton extends StatelessWidget {
  final String text;
  final bool? isLoading;

  const BookButton({
    super.key,
    required this.text,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.mainBlue,
          )),
      child: Text(
        text,
        style: AppTextStyle.labelMedium,
      ),
    );
  }
}
