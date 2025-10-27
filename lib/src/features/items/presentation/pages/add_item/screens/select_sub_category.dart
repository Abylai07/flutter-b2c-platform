import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';

import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/items/categories_entity.dart';
import '../widget/category_select_widget.dart';

@RoutePage()
class SelectSubCategoryScreen extends StatelessWidget {
  const SelectSubCategoryScreen(
      {super.key, required this.category, required this.titleItem});
  final CategoryEntity category;
  final String titleItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: AppColors.mainBlue,
          onPressed: () {
            context.router.maybePop();
          },
        ),
        title: Text(
          S.of(context).addItem,
          style: AppTextStyle.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategorySelectWidget(category: category),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 8),
                child: Text(
                  S.of(context).selectCategory,
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
                      context.router.push(AddInfoRoute(
                          titleItem: titleItem,
                          category: category,
                          subCategory: category.subcategories[i]));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.subcategories[i].name,
                          style: AppTextStyle.labelLarge,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.gray,
                          size: 18,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    18.height,
              )
            ],
          ),
        ),
      ),
    );
  }
}
