import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/enums.dart';

import '../../../common/app_styles/text_styles.dart';
import '../../../common/utils/app_router/app_router.dart';
import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../domain/entity/items/categories_entity.dart';
import '../../../domain/entity/items/item_entity.dart';
import '../../bloc/base_state.dart';
import '../../widgets/my_app_bar.dart';
import '../home/bloc/category_cubit.dart';
import '../home/bloc/items_cubit.dart';
import '../home/widgets/category_widget.dart';
import '../home/widgets/item_widget.dart';

@RoutePage()
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).categories,
        controller: searchController,
        onChanged: (value) {
          context.read<ItemsCubit>().searchItems(value ?? '');
        },
      ),
      body: BlocBuilder<ItemsCubit, BaseState>(
        builder: (context, state) {
          final cubit = context.read<ItemsCubit>();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                if (searchController.text.isEmpty) ...[
                  SliverToBoxAdapter(
                    child: BlocBuilder<CategoryCubit, BaseState>(
                      builder: (context, state) {
                        if (state.status.isSuccess) {
                          List<CategoryEntity> categories = state.entity;
                          categories.removeWhere((element) => element.itemCount < 1);
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (context, i) {
                                return CategoryWidget(
                                    category: categories[i], index: i);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  height: 32,
                                  color: AppColors.divider,
                                );
                              },
                            ),
                          );
                        } else if (state.status.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ] else ...[
                  PagedSliverGrid<int, ItemEntity>(
                    pagingController: cubit.pagingController,
                    showNewPageProgressIndicatorAsGridChild: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 16.0, // spacing between rows
                      crossAxisSpacing: 16.0, // spacing between columns
                      mainAxisExtent: 286,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<ItemEntity>(
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Text(
                            S.of(context).empty,
                            style: AppTextStyle.titleMedium,
                          ),
                        );
                      },
                      itemBuilder: (context, item, index) => ItemWidget(
                        onTap: () {
                          context.router.push(ItemCardRoute(item: item));
                        },
                        item: item,
                      ),
                    ),
                  )
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
