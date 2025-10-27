import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/app_styles/colors.dart';
import '../../../../../../common/app_styles/text_styles.dart';
import '../../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../../domain/entity/items/categories_entity.dart';
import '../../../../../widgets/containers/border_container.dart';
import '../../../../../widgets/expandable_theme.dart';
import '../../../bloc/category_select/category_select_cubit.dart';
import '../../../bloc/category_select/category_select_state.dart';


class SelectCategoryPart extends StatelessWidget {
  const SelectCategoryPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ExpandableController categoryController = ExpandableController();
    ExpandableController subCategoryController = ExpandableController();

    return BlocBuilder<CategorySelectCubit, CategorySelectState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          List<SubcategoryEntity> subcategories = state.selectCategory?.subcategories ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BorderContainer(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: ExpandablePanel(
                  controller: categoryController,
                  theme: buildExpandableThemeData(),
                  header: Text(
                    state.selectCategory?.name ?? '',
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  collapsed: const SizedBox(),
                  expanded: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.entity?.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<CategorySelectCubit>()
                                .selectCategory(state.entity![i]);
                            categoryController.toggle();
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 12.0),
                            child: Text(
                              state.entity?[i].name ?? '',
                              style:
                              AppTextStyle.labelLarge.copyWith(
                                color: state.selectCategory?.id ==
                                    state.entity?[i].id
                                    ? AppColors.black
                                    : AppColors.gray2,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 16),
                child: Text(
                  S.of(context).subCategories,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              BorderContainer(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: ExpandablePanel(
                  controller: subCategoryController,
                  theme: buildExpandableThemeData(),
                  header: Text(
                    state.selectSubCategory?.name ?? '',
                    style: AppTextStyle.bodyLarge.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  collapsed: const SizedBox(),
                  expanded: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subcategories.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<CategorySelectCubit>()
                                .selectSubCategory(subcategories[i]);
                            subCategoryController.toggle();
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 12.0),
                            child: Text(
                              subcategories[i].name ?? '',
                              style:
                              AppTextStyle.labelLarge.copyWith(
                                color: state.selectSubCategory?.id ==
                                    subcategories[i].id
                                    ? AppColors.black
                                    : AppColors.gray2,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        } else if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}