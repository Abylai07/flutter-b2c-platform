import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/widgets/my_item_widget.dart';

import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/app_router/app_router.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../get_it_sl.dart';
import '../../bloc/change_item_cubit.dart';
import '../../bloc/my_item_cubit.dart';

@RoutePage()
class AdvertisementScreen extends StatelessWidget {
  const AdvertisementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyItemCubit>(
          create: (_) => sl<MyItemCubit>(),
        ),
        BlocProvider<ChangeItemCubit>(
          create: (_) => sl<ChangeItemCubit>(),
        ),
      ],
      child: const AdvertisementView(),
    );
  }
}

class AdvertisementView extends StatelessWidget {
  const AdvertisementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).advertisement,
          style: AppTextStyle.headlineSmall,
        ),
      ),
      body: BlocBuilder<MyItemCubit, BaseState>(
        builder: (context, state) {
          final cubit = context.read<MyItemCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatusButton(
                        text: S.of(context).active,
                        onTap: () {
                          if (cubit.currentStatus != 'new') {
                            cubit.setStatusItems('new');
                          }
                        },
                        height: 40,
                        fill: cubit.currentStatus == 'new' ? true : false,
                        radius: 16,
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: StatusButton(
                        text: S.of(context).inactive,
                        onTap: () {
                          if (cubit.currentStatus != 'archived') {
                            cubit.setStatusItems('archived');
                          }
                        },
                        height: 40,
                        fill: cubit.currentStatus == 'archived' ? true : false,
                        radius: 16,
                      ),
                    ),
                  ],
                ),
                12.height,
                Expanded(
                  child: PagedListView<int, MyItemEntity>(
                    pagingController: cubit.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<MyItemEntity>(
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Text(
                            S.of(context).empty,
                            style: AppTextStyle.titleMedium,
                          ),
                        );
                      },
                      itemBuilder: (context, item, index) => MyItemWidget(
                        onTap: () async {
                          context.router
                              .push(ItemCardRoute(item: getItemEntity(item)));
                        },
                        item: item,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ItemEntity getItemEntity(MyItemEntity item) {
    return ItemEntity(
      id: item.id,
      title: item.title,
      images: item.images,
      outsideImages: item.outsideImages,
      periods: item.periods,
      condition: item.condition,
      created: item.created.toIso8601String(),
    );
  }
}
