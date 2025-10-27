import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';

import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/items/categories_entity.dart';
import '../bloc/category_items_cubit.dart';

@RoutePage()
class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.mainBlue,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          category.name,
          style: AppTextStyle.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  S.of(context).subCategories,
                  style: AppTextStyle.titleSmall,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: category.subcategories.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      context
                          .read<CategoryItemsCubit>()
                          .fetchPage(1, category.subcategories[i].id);
                      context.router.push(CategoryItemsRoute(
                          subCategory: category.subcategories[i]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              category.subcategories[i].name,
                              style: AppTextStyle.labelLarge,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: AppColors.gray,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    12.height,
              ),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
}
