import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:b2c_platform/src/common/app_styles/assets.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_item_entity.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/my_orders/my_orders_state.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/status_count/status_count_state.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/widgets/my_item_widget.dart';
import 'package:b2c_platform/src/presentation/widgets/buttons/main_button.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/app_router/app_router.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../get_it_sl.dart';
import '../../bloc/my_orders/my_orders_cubit.dart';
import '../../bloc/status_count/status_count_cubit.dart';
import '../widgets/order_item_widget.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyOrdersCubit>(
          create: (_) => sl<MyOrdersCubit>(),
        ),
        BlocProvider<StatusCountCubit>(
          create: (_) => sl<StatusCountCubit>()..fetchStatusCount(false),
        ),
      ],
      child: const OrdersView(),
    );
  }
}

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).orders,
          style: AppTextStyle.headlineSmall,
        ),
      ),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
        builder: (context, state) {
          final cubit = context.read<MyOrdersCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatusButton(
                        text: S.of(context).myOrders,
                        onTap: () {
                          if (cubit.atClients) {
                            cubit.setOrderStatus(false);
                          }
                        },
                        height: 40,
                        fill: !cubit.atClients,
                        radius: 16,
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: StatusButton(
                        text: S.of(context).orderAt,
                        onTap: () {
                          if (!cubit.atClients) {
                            cubit.setOrderStatus(true);
                          }
                        },
                        height: 40,
                        fill: cubit.atClients,
                        radius: 16,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<StatusCountCubit, StatusCountState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InkWell(
                        onTap: () async {
                          final result = await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            constraints: BoxConstraints(
                              maxHeight: 0.4.sh,
                            ),
                            builder: (ctx) {
                              return BlocProvider(
                                create: (_) => sl<StatusCountCubit>()
                                  ..fetchStatusCount(cubit.atClients, status: state.selectStatus),
                                child: buildFilterModal(context),
                              );
                            },
                          );
                          if (result != null) {
                            context.read<StatusCountCubit>().selectStatus(result);
                            cubit.setStatusItems(result);
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.selectStatus != null
                                  ? getName(context, state.selectStatus!) ?? ''
                                  : S.of(context).all,
                              style: AppTextStyle.titleSmall,
                            ),
                            8.width,
                            SvgPicture.asset(AppAssets.dropDown),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: PagedListView<int, OrderItemEntity>(
                    pagingController: cubit.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<OrderItemEntity>(
                      noItemsFoundIndicatorBuilder: (context) {
                        return Center(
                          child: Text(
                            S.of(context).empty,
                            style: AppTextStyle.titleMedium,
                          ),
                        );
                      },
                      itemBuilder: (context, item, index) => OrderItemWidget(
                        onTap: () async {
                          context.router.push(OrderItemRoute(
                              item: item, atClients: cubit.atClients));
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

  Widget buildFilterModal(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                16.width,
                Expanded(
                  child: Text(
                    S.of(context).filter,
                    style: AppTextStyle.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(10.0),
                  icon: SvgPicture.asset(AppAssets.cancel),
                ),
              ],
            ),
            BlocBuilder<StatusCountCubit, StatusCountState>(
              builder: (context, state) {
                if (state.status.isSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildStatusCount(context, 'all', state),
                        buildStatusCount(context, 'new', state),
                        buildStatusCount(context, 'accepted', state),
                        buildStatusCount(context, 'in_progress', state),
                        buildStatusCount(context, 'closed', state),
                        12.height,
                        SafeArea(
                          child: CustomMainButton(
                              text: S.of(context).select,
                              onTap: () {
                                String? status = context.read<StatusCountCubit>().state.selectStatus;
                                Navigator.pop(context, status);
                              }),
                        ),
                      ],
                    ),
                  );
                } else if (state.status.isSuccess) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding buildStatusCount(
      BuildContext context, String status, StatusCountState? state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          context.read<StatusCountCubit>().selectStatus(status);
        },
        child: Text(
          getNameByStatus(context, status, state),
          style: AppTextStyle.bodyLarge.copyWith(
              color: (state?.selectStatus == status) ||
                      (state?.selectStatus == null && status == 'all')
                  ? AppColors.mainBlue
                  : AppColors.gray),
        ),
      ),
    );
  }

  String? getName(BuildContext ctx, String key){
    final data = {
      'all' : S.of(ctx).all,
      'new' : S.of(ctx).newStatus,
      'accepted' : S.of(ctx).acceptedStatus,
      'in_progress' : S.of(ctx).inProgressStatus,
      'closed' : S.of(ctx).closedStatus,
    };
    return data[key];
  }

  getNameByStatus(
      BuildContext context, String status, StatusCountState? state) {
    switch (status) {
      case 'new':
        return S.of(context).newCount(state?.entity?.newCount ?? 0);
      case 'accepted':
        return S.of(context).accepted(state?.entity?.acceptedCount ?? 0);
      case 'in_progress':
        return S.of(context).inProgress(state?.entity?.inProgressCount ?? 0);
      case 'closed':
        return S.of(context).closed(state?.entity?.closedCount ?? 0);
      default:
        return S.of(context).allCount(state?.count ?? 0);
    }
  }
}
