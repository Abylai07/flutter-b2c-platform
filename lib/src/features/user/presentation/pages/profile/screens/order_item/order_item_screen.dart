import 'dart:convert';
import 'package:b2c_platform/src/common/constants.dart' as constants;

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:b2c_platform/src/common/enums.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/order_detail_entity.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/order_detail.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/order_item/payment/payment_alert.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/screens/order_item/payment/payment_modal_view.dart';

import '../../../../../common/app_styles/colors.dart';
import '../../../../../common/app_styles/text_styles.dart';
import '../../../../../common/utils/l10n/generated/l10n.dart';
import '../../../../../domain/entity/order/order_item_entity.dart';
import '../../../../../get_it_sl.dart';
import '../../../../bloc/base_state.dart';
import '../../../../widgets/buttons/main_button.dart';
import '../../../../widgets/custom_sliver_app_bar_back_image.dart';
import '../../../../widgets/main_functions.dart';
import '../../../home/item_card/bloc/period_bloc.dart';
import '../../bloc/loading_cubit.dart';
import '../../bloc/update_status/update_status_cubit.dart';
import '../widgets/status_container.dart';
import '../widgets/update_status_button.dart';

@RoutePage()
class OrderItemScreen extends StatelessWidget {
  const OrderItemScreen(
      {super.key, required this.item, required this.atClients});
  final OrderItemEntity item;
  final bool atClients;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderDetailCubit>(
          create: (_) => sl<OrderDetailCubit>()..fetchOrderDetail(item.id),
        ),
        BlocProvider<UpdateStatusCubit>(
          create: (_) => sl<UpdateStatusCubit>(),
        ),
        BlocProvider<PeriodBloc>(
          create: (_) => PeriodBloc(),
        ),
        BlocProvider(
          create: (_) => LoadingCubit(),
        ),
      ],
      child: OrderItemView(
        item: item,
        atClients: atClients,
      ),
    );
  }
}

class OrderItemView extends StatelessWidget {
  const OrderItemView({super.key, required this.item, required this.atClients});
  final OrderItemEntity item;
  final bool atClients;

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    String token = base64Encode(utf8.encode(constants.apiKey));
    var uuid = const Uuid();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Future<void> checkStatus(int paymentId, String orderId) async {
      final dataObject = {
        "payment_id": paymentId,
        "order_id": orderId,
      };

      final data = jsonToBase64(dataObject);
      final sign = createSign(data);

      final requestBody = {'data': data, 'sign': sign};

      try {
        final response = await dio.post(
          '${constants.payAPI}/payment/status',
          data: requestBody,
          options: Options(headers: headers),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> json = base64ToJson(response.data['data']);
          debugPrint('Success: $json');
          if (json['payment_status'] == 'withdraw') {
            successAlert(context);
          } else if (json['payment_status'] == 'error') {
            errorAlert(context, json['error_code']);
          } else {
            insufficientAlert(context, json['payment_status']);
          }
        } else {
          debugPrint('Error: ${response.statusCode} ${response.data}');
        }
      } on DioException catch (e) {
        debugPrint(
            'DioError: ${e.response?.realUri} ${e.response?.statusCode} ${e.response?.data}');
      }
    }

    Future<void> createPayment() async {
      final serviceCharge = item.price * 0.10; // 10% service charge
      final totalAmount = item.price + serviceCharge;

      final dataObject = {
        "amount": totalAmount,
        "currency": "KZT",
        "order_id": uuid.v4(),
        "description": item.title,
        "payment_type": "pay",
        "payment_method": "ecom",
        "items": [
          {
            "merchant_id": constants.merchantId,
            "service_id": constants.serviceId,
            "merchant_name": "маркетплейс",
            "name": item.title,
            "quantity": 1,
            "amount_one_pcs": totalAmount,
            "amount_sum": totalAmount
          }
        ],
        "success_url": "http://example.com",
        "failure_url": "http://example.com",
        "callback_url": "http://example.com",
        "payment_lifetime": 3600,
        "create_recurrent_profile": false,
        "recurrent_profile_lifetime": 0,
        "lang": "ru",
      };

      final data = jsonToBase64(dataObject);
      final sign = createSign(data);

      final requestBody = {'data': data, 'sign': sign};

      try {
        final response = await dio.post(
          '${constants.payAPI}/payment/create',
          data: requestBody,
          options: Options(headers: headers),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> json = base64ToJson(response.data['data']);
          debugPrint('Success: $json');

          await showModalBottomSheet(
            isScrollControlled: true,
            enableDrag: false,
            context: context,
            constraints: BoxConstraints(
              maxHeight: 0.9.sh,
            ),
            builder: (context) {
              return BlocProvider(
                create: (context) => LoadingCubit(),
                child: PaymentModalView(
                  url: json['payment_page_url'],
                ),
              );
            },
          );

          checkStatus(json['payment_id'], json['order_id']);
        } else {
          debugPrint('Error: ${response.statusCode} ${response.data}');
        }
      } on DioException catch (e) {
        debugPrint(
            'DioError: ${e.response?.realUri} ${e.response?.statusCode} ${e.response?.data}');
      }
    }

    return BlocBuilder<OrderDetailCubit, BaseState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          OrderDetailEntity entity = state.entity;
          BlocProvider.of<PeriodBloc>(context)
              .add(SelectPeriodWithPrice(entity.period, 1));
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  isHideTitle: true,
                  tag: entity.id.toString(),
                  images: entity.item.outsideImages.isEmpty
                      ? entity.item.images
                      : entity.item.outsideImages,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).orderInfo,
                              style: AppTextStyle.titleSmall,
                            ),
                            StatusContainer(
                              status: entity.status,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).item,
                              style: AppTextStyle.labelLarge
                                  .copyWith(color: AppColors.gray),
                            ),
                            Expanded(
                              child: Text(
                                item.title,
                                style: AppTextStyle.labelLarge
                                    .copyWith(color: AppColors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).period,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.gray),
                          ),
                          Text(
                            ':  ${entity.periodAmount} ${getPeriodByName(entity.period.period)}',
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                      4.height,
                      Row(
                        children: [
                          Text(
                            S.of(context).totalAmount,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.gray),
                          ),
                          Text(
                            ':  ${entity.price} ₸',
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, top: 12),
                        child: Text(
                          S.of(context).rentInfo,
                          style: AppTextStyle.titleSmall,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).name,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.gray),
                          ),
                          Text(
                            ': ${entity.createdUser.firstName} ${entity.createdUser.lastName}',
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).phoneNumber,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.gray),
                          ),
                          Text(
                            ': +7${entity.createdUser.username}',
                            style: AppTextStyle.bodyLarge
                                .copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entity.obtainmentType,
                            style: AppTextStyle.labelLarge
                                .copyWith(color: AppColors.gray),
                          ),
                          Expanded(
                            child: Text(
                              ': ${entity.shopPlace?.address ?? entity.userPlace?.address ?? ''}',
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.gray),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
            bottomNavigationBar: entity.status != 'closed' &&
                    (atClients || (!atClients && entity.status == 'accepted'))
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 24),
                    child: SafeArea(
                      child: atClients
                          ? UpdateStatusButton(entity: entity)
                          : CustomMainButton(
                              text: S.of(context).pay,
                              isLoading: state.status.isLoading,
                              onTap: () {
                                createPayment();
                              },
                            ),
                    ),
                  )
                : const SizedBox(),
          );
        } else if (state.status.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const Scaffold(body: SizedBox());
        }
      },
    );
  }

  getPeriodByName(String name) {
    switch (name) {
      case 'На час':
        return 'ч';
      case 'На день':
        return 'д';
      case 'На неделю':
        return 'н';
      default:
        return '';
    }
  }
}
