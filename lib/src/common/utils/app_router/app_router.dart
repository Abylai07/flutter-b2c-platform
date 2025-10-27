import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/home_screen.dart';

import '../../../domain/entity/items/categories_entity.dart';
import '../../../domain/entity/items/create_item_entity.dart';
import '../../../domain/entity/items/item_entity.dart';
import '../../../domain/entity/order/order_item_entity.dart';
import '../../../presentation/view/add_item/add_item_screen.dart';
import '../../../presentation/view/add_item/screens/add_info_screen.dart';
import '../../../presentation/view/add_item/screens/add_photo_screen.dart';
import '../../../presentation/view/add_item/screens/select_sub_category.dart';
import '../../../presentation/view/categories/categories_screen.dart';
import '../../../presentation/view/categories/sub_category/sub_categories_screen.dart';
import '../../../presentation/view/categories/sub_category/sub_category_items_screen.dart';
import '../../../presentation/view/home/item_card/item_card_screen.dart';
import '../../../presentation/view/index_screen.dart';
import '../../../presentation/view/profile/profile_screen.dart';
import '../../../presentation/view/profile/screens/app_settings_screen.dart';
import '../../../presentation/view/profile/screens/edit_item/edit_item_screen.dart';
import '../../../presentation/view/profile/screens/history_order/advertisement_screen.dart';
import '../../../presentation/view/profile/screens/order_item/order_item_screen.dart';
import '../../../presentation/view/profile/screens/history_order/orders_screen.dart';
import '../../../presentation/view/profile/screens/personal_data_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: IndexRoute.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: CategoriesRoute.page),
          AutoRoute(page: AddItemRoute.page),
          AutoRoute(page: ProfileRoute.page),
        ]),
        AutoRoute(page: ItemCardRoute.page),
        AutoRoute(page: SubCategoriesRoute.page),
        AutoRoute(page: CategoryItemsRoute.page),
        AutoRoute(page: SelectSubCategoryRoute.page),
        AutoRoute(page: AddInfoRoute.page),
        AutoRoute(page: AddPhotoRoute.page),
        AutoRoute(page: PersonalDataRoute.page),
        AutoRoute(page: OrdersRoute.page),
        AutoRoute(page: AdvertisementRoute.page),
        AutoRoute(page: AppSettingRoute.page),
        AutoRoute(page: EditItemRoute.page),
        AutoRoute(page: OrderItemRoute.page),
      ];
}
