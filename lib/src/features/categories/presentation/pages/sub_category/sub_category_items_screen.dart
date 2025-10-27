import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';

import '../../../../common/enums.dart';
import '../../../../common/utils/app_router/app_router.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../domain/entity/items/categories_entity.dart';
import '../../../../domain/entity/items/item_entity.dart';
import '../../../bloc/base_state.dart';
import '../../home/widgets/item_widget.dart';
import '../bloc/category_items_cubit.dart';

@RoutePage()
class CategoryItemsScreen extends StatelessWidget {
  const CategoryItemsScreen({super.key, required this.subCategory});
  final SubcategoryEntity subCategory;
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
          subCategory.name,
          style: AppTextStyle.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CategoryItemsCubit, BaseState>(
          builder: (context, state) {
            final cubit = context.read<CategoryItemsCubit>();
            if (state.status.isSuccess &&
                cubit.pagingController.itemList?.isEmpty == true) {
              return Center(
                child: Text(
                  S.of(context).empty,
                  style: AppTextStyle.titleMedium,
                ),
              );
            }
            return PagedGridView<int, ItemEntity>(
              pagingController: cubit.pagingController,
              showNewPageProgressIndicatorAsGridChild: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 16.0, // spacing between rows
                crossAxisSpacing: 16.0, // spacing between columns
                mainAxisExtent: 286,
              ),
              builderDelegate: PagedChildBuilderDelegate<ItemEntity>(
                itemBuilder: (context, item, index) => ItemWidget(
                  onTap: () {
                    context.router.push(ItemCardRoute(item: item));
                  },
                  item: item,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
