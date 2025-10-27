import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/presentation/widgets/show_error_snackbar.dart';

import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../widgets/shimmer_widget.dart';
import '../../../home/widgets/condition_container.dart';
import '../../bloc/change_item_cubit.dart';
import '../../bloc/my_item_cubit.dart';

class MyItemWidget extends StatelessWidget {
  const MyItemWidget({super.key, required this.onTap, required this.item});
  final Function()? onTap;
  final MyItemEntity item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: 164,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        item.outsideImages.isNotEmpty || item.images.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: item.outsideImages.isEmpty
                                    ? item.images[0]
                                    : item.outsideImages[0],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        const ShimmerWidget(
                                  width: double.infinity,
                                  height: 164,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Container(
                                color: AppColors.lightGray,
                              ),
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConditionContainer(
                          condition: item.condition,
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await context.router
                                .push(EditItemRoute(item: item));
                            if (result == 'updatePage') {
                              context
                                  .read<MyItemCubit>()
                                  .pagingController
                                  .refresh();
                            }
                          },
                          child: Container(
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.mainBlue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        item.title,
                        maxLines: 1,
                        style: AppTextStyle.titleSmall
                            .copyWith(color: AppColors.textBlack),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: S.of(context).given,
                        style: AppTextStyle.displayLarge
                            .copyWith(color: AppColors.gray4),
                        children: [
                          TextSpan(
                            text: item.totalGiven.toString(),
                            style: AppTextStyle.displayLarge,
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: S.of(context).viewed,
                        style: AppTextStyle.displayLarge
                            .copyWith(color: AppColors.gray4),
                        children: [
                          TextSpan(
                            text: item.totalViewed.toString(),
                            style: AppTextStyle.displayLarge,
                          ),
                        ],
                      ),
                    ),
                    if (item.periods.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 6),
                        child: Text(
                          S.of(context).priceTg(item.periods[0].price.toInt(),
                              item.periods[0].period.split(' ').last),
                          style: AppTextStyle.bodyLarge
                              .copyWith(color: AppColors.textBlack),
                        ),
                      ),
                    BlocListener<ChangeItemCubit, BaseState>(
                      listener: (context, state) {
                        if (state.status.isSuccess) {
                          context
                              .read<MyItemCubit>()
                              .pagingController
                              .refresh();
                        } else if (state.status.isError) {
                          showErrorSnackBar(context,
                              '${S.of(context).somethingWrong}  ${state.message}');
                        }
                      },
                      child: StatusButton(
                        text: item.status == 'archived'
                            ? S.of(context).recover
                            : S.of(context).archive,
                        onTap: () {
                          if (item.status == 'archived') {
                            context
                                .read<ChangeItemCubit>()
                                .changeItemStatus('restore/${item.id}');
                          } else {
                            context
                                .read<ChangeItemCubit>()
                                .changeItemStatus('archive/${item.id}');
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final double height;
  final double radius;
  final bool fill;

  const StatusButton({
    super.key,
    required this.text,
    this.onTap,
    this.height = 28,
    this.radius = 12,
    this.fill = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
            color: fill ? AppColors.mainBlue : null,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: AppColors.mainBlue,
            )),
        child: Text(
          text,
          style: AppTextStyle.bodyLarge
              .copyWith(color: fill ? AppColors.white : AppColors.mainBlue),
        ),
      ),
    );
  }
}
