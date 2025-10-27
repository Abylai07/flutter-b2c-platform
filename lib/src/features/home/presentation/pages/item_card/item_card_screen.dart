import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:b2c_platform/src/common/app_styles/colors.dart';
import 'package:b2c_platform/src/common/app_styles/text_styles.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';
import 'package:b2c_platform/src/presentation/bloc/base_state.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/book_item_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/item_detail_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/bloc/create_place/create_place_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/bloc/obtainment_bloc.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/widgets/obtainment_part_view.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/widgets/period_part_widget.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/widgets/success_book_alert.dart';
import 'package:b2c_platform/src/presentation/widgets/show_error_snackbar.dart';
import 'package:b2c_platform/src/presentation/widgets/snack_bar.dart';

import '../../../../common/enums.dart';
import '../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../common/utils/shared_preference.dart';
import '../../../../get_it_sl.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/custom_sliver_app_bar_back_image.dart';
import '../../authorization/sign_in/sign_in_screen.dart';
import '../widgets/condition_container.dart';
import 'bloc/period_bloc.dart';
import 'bloc/place_list/place_list_cubit.dart';

@RoutePage()
class ItemCardScreen extends StatelessWidget {
  const ItemCardScreen({super.key, required this.item});
  final ItemEntity item;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemDetailCubit>(
          create: (_) => sl<ItemDetailCubit>()..fetchItemDetail(item.id),
        ),
        BlocProvider<BookItemCubit>(
          create: (_) => sl<BookItemCubit>(),
        ),
        BlocProvider<PlaceListCubit>(
          create: (_) => sl<PlaceListCubit>()..fetchPlaceList(),
        ),
        BlocProvider<CreatePlaceCubit>(
          create: (_) => sl<CreatePlaceCubit>(),
        ),
        BlocProvider<PeriodBloc>(
          create: (_) => PeriodBloc(),
        ),
        BlocProvider(
          create: (_) => ObtainmentTypeBloc(),
        ),
      ],
      child: ItemCardView(
        item: item,
      ),
    );
  }
}

class ItemCardView extends StatelessWidget {
  const ItemCardView({super.key, required this.item});
  final ItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            isHideTitle: true,
            tag: item.id.toString(),
            images:
                item.outsideImages.isEmpty ? item.images : item.outsideImages,
            title: item.title,
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 20,
              right: 16,
              left: 16,
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConditionContainer(
                  isBigger: true,
                  condition: item.condition,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, top: 12),
                  child: Text(
                    item.title,
                    style: AppTextStyle.titleSmall,
                  ),
                ),
                BlocBuilder<ItemDetailCubit, BaseState>(
                  builder: (context, state) {
                    if (state.status.isSuccess) {
                      ItemDetailEntity entity = state.entity;
                      if (entity.periods.isNotEmpty) {
                        BlocProvider.of<PeriodBloc>(context)
                            .add(SelectPeriodWithPrice(entity.periods[0], 1));
                      }
                      if (entity.obtainmentTypes.isNotEmpty) {
                        context.read<ObtainmentTypeBloc>().add(
                            ChangeObtainmentType(entity.obtainmentTypes[0]));
                      }
                      if (entity.places.isNotEmpty) {
                        context.read<PlaceListCubit>().selectShop(entity.places[0]);
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  entity.subCategory.name ?? '',
                                  style: AppTextStyle.bodyLarge,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  entity.subCategory.category ?? '',
                                  style: AppTextStyle.bodyLarge
                                      .copyWith(color: AppColors.main),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 4),
                            child: Text(
                              S.of(context).landlordInfo,
                              style: AppTextStyle.titleSmall,
                            ),
                          ),
                          Text(
                            '${entity.createdUser.firstName} ${entity.createdUser.lastName}',
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.gray),
                          ),
                          PeriodPartView(
                            periods: entity.periods,
                          ),
                          ObtainmentPartView(
                              obtainmentTypes: entity.obtainmentTypes,
                            places: entity.places,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 4),
                            child: Text(
                              S.of(context).description,
                              style: AppTextStyle.titleSmall,
                            ),
                          ),
                          Text(
                            entity.description.isEmpty
                                ? S.of(context).empty
                                :  entity.description,
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.gray),
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
                ),
              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BlocConsumer<BookItemCubit, BaseState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              successBookAlert(context);
            } else if (state.status.isError) {
              AppSnackBarWidget(
                description: S.of(context).somethingWrong,
                color: AppColors.errorRedColor,
              ).show(context);
            }
          },
          builder: (context, state) {
            var periodState = context.watch<PeriodBloc>().state;
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 24),
              child: CustomMainButton(
                text: S.of(context).book,
                isActive: periodState is PeriodWithPrice,
                isLoading: state.status.isLoading,
                onTap: () {
                  final obtainmentState =
                      context.read<ObtainmentTypeBloc>().state;
                  final address =
                      context.read<PlaceListCubit>().state.selectPlace;
                  final shop =
                      context.read<PlaceListCubit>().state.shopAddress;

                  if(SharedPrefs().getAccessToken() == null ){
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      constraints: BoxConstraints(
                        maxHeight: 0.9.sh,
                      ),
                      builder: (context) {
                        return const SignInScreen();
                      },
                    );
                  } else if (periodState is PeriodWithPrice &&
                      obtainmentState is ObtainmentTypeChanged) {
                    context.read<BookItemCubit>().bookItem({
                      "item": item.id,
                      "period_amount": periodState.count,
                      "period": periodState.selectedPeriod.id,
                      "price": periodState.selectedPeriod.price.toInt() *
                          periodState.count,
                      "status": "new",
                      "shop_place": shop?.id,
                      "user_place": address?.id,
                      "obtainment_type": obtainmentState.obtainmentType.id,
                      "comments": ""
                    });
                  } else {
                    showErrorSnackBar(context, S.of(context).somethingWrong);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  String getPeriodKey(String period) {
    switch (period) {
      case 'На день':
        return 'day';
      case 'На чась':
        return 'hour';
      case 'На неделю':
        return 'week';
      default:
        throw ArgumentError('Invalid period: $period');
    }
  }
}
