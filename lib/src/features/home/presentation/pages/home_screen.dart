import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/common/utils/app_router/app_router.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/category_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/widgets/category_loading_shimmer.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/widgets/category_widget.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/widgets/item_widget.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/widgets/home_app_bar.dart';

import '../../../common/utils/l10n/generated/l10n.dart';
import '../../../domain/entity/items/item_entity.dart';
import 'bloc/items_cubit.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: S.of(context).main,
        onChanged: (value) {
          context.read<ItemsCubit>().searchItems(value ?? '');
        },
      ),
      body: BlocBuilder<ItemsCubit, BaseState>(
        builder: (context, state) {
          final cubit = context.read<ItemsCubit>();
          return RefreshIndicator(
            onRefresh: () => Future.sync(
                  () {
                //   context.read<CategoryCubit>().fetchCategories();
                context.read<ItemsCubit>().pagingController.refresh();
              },
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).categories,
                          style: AppTextStyle.titleMedium,
                        ),
                        BlocBuilder<CategoryCubit, BaseState>(
                          builder: (context, state) {
                            if (state.status.isSuccess) {
                              List<CategoryEntity> categories = state.entity;
                              return SizedBox(
                                height: 170,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 20),
                                    itemCount: categories.length,
                                    itemBuilder: (context, i) {
                                      return CategoryHomeWidget(
                                          category: categories[i], index: i);
                                    }),
                              );
                            } else if (state.status.isLoading) {
                              return const CategoryLoadingShimmer();
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Text(
                          S.of(context).recommendations,
                          style: AppTextStyle.titleMedium,
                        ),
                        12.height,
                      ],
                    ),
                  ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}


