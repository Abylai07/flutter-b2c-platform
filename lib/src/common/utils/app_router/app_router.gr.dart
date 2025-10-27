// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddInfoRoute.name: (routeData) {
      final args = routeData.argsAs<AddInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddInfoScreen(
          key: args.key,
          titleItem: args.titleItem,
          category: args.category,
          subCategory: args.subCategory,
        ),
      );
    },
    AddItemRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddItemScreen(),
      );
    },
    AddPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<AddPhotoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddPhotoScreen(
          key: args.key,
          createItem: args.createItem,
        ),
      );
    },
    AdvertisementRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdvertisementScreen(),
      );
    },
    AppSettingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppSettingScreen(),
      );
    },
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesScreen(),
      );
    },
    CategoryItemsRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryItemsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryItemsScreen(
          key: args.key,
          subCategory: args.subCategory,
        ),
      );
    },
    EditItemRoute.name: (routeData) {
      final args = routeData.argsAs<EditItemRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditItemScreen(
          key: args.key,
          item: args.item,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    IndexRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const IndexScreen(),
      );
    },
    ItemCardRoute.name: (routeData) {
      final args = routeData.argsAs<ItemCardRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ItemCardScreen(
          key: args.key,
          item: args.item,
        ),
      );
    },
    OrderItemRoute.name: (routeData) {
      final args = routeData.argsAs<OrderItemRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderItemScreen(
          key: args.key,
          item: args.item,
          atClients: args.myOrder,
        ),
      );
    },
    OrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrdersScreen(),
      );
    },
    PersonalDataRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PersonalDataScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    SelectSubCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<SelectSubCategoryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SelectSubCategoryScreen(
          key: args.key,
          category: args.category,
          titleItem: args.titleItem,
        ),
      );
    },
    SubCategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<SubCategoriesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SubCategoriesScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
  };
}

/// generated route for
/// [AddInfoScreen]
class AddInfoRoute extends PageRouteInfo<AddInfoRouteArgs> {
  AddInfoRoute({
    Key? key,
    required String titleItem,
    required CategoryEntity category,
    required SubcategoryEntity subCategory,
    List<PageRouteInfo>? children,
  }) : super(
          AddInfoRoute.name,
          args: AddInfoRouteArgs(
            key: key,
            titleItem: titleItem,
            category: category,
            subCategory: subCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'AddInfoRoute';

  static const PageInfo<AddInfoRouteArgs> page =
      PageInfo<AddInfoRouteArgs>(name);
}

class AddInfoRouteArgs {
  const AddInfoRouteArgs({
    this.key,
    required this.titleItem,
    required this.category,
    required this.subCategory,
  });

  final Key? key;

  final String titleItem;

  final CategoryEntity category;

  final SubcategoryEntity subCategory;

  @override
  String toString() {
    return 'AddInfoRouteArgs{key: $key, titleItem: $titleItem, category: $category, subCategory: $subCategory}';
  }
}

/// generated route for
/// [AddItemScreen]
class AddItemRoute extends PageRouteInfo<void> {
  const AddItemRoute({List<PageRouteInfo>? children})
      : super(
          AddItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddItemRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddPhotoScreen]
class AddPhotoRoute extends PageRouteInfo<AddPhotoRouteArgs> {
  AddPhotoRoute({
    Key? key,
    required CreateItemEntity createItem,
    List<PageRouteInfo>? children,
  }) : super(
          AddPhotoRoute.name,
          args: AddPhotoRouteArgs(
            key: key,
            createItem: createItem,
          ),
          initialChildren: children,
        );

  static const String name = 'AddPhotoRoute';

  static const PageInfo<AddPhotoRouteArgs> page =
      PageInfo<AddPhotoRouteArgs>(name);
}

class AddPhotoRouteArgs {
  const AddPhotoRouteArgs({
    this.key,
    required this.createItem,
  });

  final Key? key;

  final CreateItemEntity createItem;

  @override
  String toString() {
    return 'AddPhotoRouteArgs{key: $key, createItem: $createItem}';
  }
}

/// generated route for
/// [AdvertisementScreen]
class AdvertisementRoute extends PageRouteInfo<void> {
  const AdvertisementRoute({List<PageRouteInfo>? children})
      : super(
          AdvertisementRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdvertisementRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppSettingScreen]
class AppSettingRoute extends PageRouteInfo<void> {
  const AppSettingRoute({List<PageRouteInfo>? children})
      : super(
          AppSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppSettingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoriesScreen]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryItemsScreen]
class CategoryItemsRoute extends PageRouteInfo<CategoryItemsRouteArgs> {
  CategoryItemsRoute({
    Key? key,
    required SubcategoryEntity subCategory,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryItemsRoute.name,
          args: CategoryItemsRouteArgs(
            key: key,
            subCategory: subCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryItemsRoute';

  static const PageInfo<CategoryItemsRouteArgs> page =
      PageInfo<CategoryItemsRouteArgs>(name);
}

class CategoryItemsRouteArgs {
  const CategoryItemsRouteArgs({
    this.key,
    required this.subCategory,
  });

  final Key? key;

  final SubcategoryEntity subCategory;

  @override
  String toString() {
    return 'CategoryItemsRouteArgs{key: $key, subCategory: $subCategory}';
  }
}

/// generated route for
/// [EditItemScreen]
class EditItemRoute extends PageRouteInfo<EditItemRouteArgs> {
  EditItemRoute({
    Key? key,
    required MyItemEntity item,
    List<PageRouteInfo>? children,
  }) : super(
          EditItemRoute.name,
          args: EditItemRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'EditItemRoute';

  static const PageInfo<EditItemRouteArgs> page =
      PageInfo<EditItemRouteArgs>(name);
}

class EditItemRouteArgs {
  const EditItemRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final MyItemEntity item;

  @override
  String toString() {
    return 'EditItemRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IndexScreen]
class IndexRoute extends PageRouteInfo<void> {
  const IndexRoute({List<PageRouteInfo>? children})
      : super(
          IndexRoute.name,
          initialChildren: children,
        );

  static const String name = 'IndexRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ItemCardScreen]
class ItemCardRoute extends PageRouteInfo<ItemCardRouteArgs> {
  ItemCardRoute({
    Key? key,
    required ItemEntity item,
    List<PageRouteInfo>? children,
  }) : super(
          ItemCardRoute.name,
          args: ItemCardRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemCardRoute';

  static const PageInfo<ItemCardRouteArgs> page =
      PageInfo<ItemCardRouteArgs>(name);
}

class ItemCardRouteArgs {
  const ItemCardRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final ItemEntity item;

  @override
  String toString() {
    return 'ItemCardRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [OrderItemScreen]
class OrderItemRoute extends PageRouteInfo<OrderItemRouteArgs> {
  OrderItemRoute({
    Key? key,
    required OrderItemEntity item,
    required bool atClients,
    List<PageRouteInfo>? children,
  }) : super(
          OrderItemRoute.name,
          args: OrderItemRouteArgs(
            key: key,
            item: item,
            myOrder: atClients,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderItemRoute';

  static const PageInfo<OrderItemRouteArgs> page =
      PageInfo<OrderItemRouteArgs>(name);
}

class OrderItemRouteArgs {
  const OrderItemRouteArgs({
    this.key,
    required this.item,
    required this.myOrder,
  });

  final Key? key;

  final OrderItemEntity item;

  final bool myOrder;

  @override
  String toString() {
    return 'OrderItemRouteArgs{key: $key, item: $item, myOrder: $myOrder}';
  }
}

/// generated route for
/// [OrdersScreen]
class OrdersRoute extends PageRouteInfo<void> {
  const OrdersRoute({List<PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PersonalDataScreen]
class PersonalDataRoute extends PageRouteInfo<void> {
  const PersonalDataRoute({List<PageRouteInfo>? children})
      : super(
          PersonalDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'PersonalDataRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SelectSubCategoryScreen]
class SelectSubCategoryRoute extends PageRouteInfo<SelectSubCategoryRouteArgs> {
  SelectSubCategoryRoute({
    Key? key,
    required CategoryEntity category,
    required String titleItem,
    List<PageRouteInfo>? children,
  }) : super(
          SelectSubCategoryRoute.name,
          args: SelectSubCategoryRouteArgs(
            key: key,
            category: category,
            titleItem: titleItem,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectSubCategoryRoute';

  static const PageInfo<SelectSubCategoryRouteArgs> page =
      PageInfo<SelectSubCategoryRouteArgs>(name);
}

class SelectSubCategoryRouteArgs {
  const SelectSubCategoryRouteArgs({
    this.key,
    required this.category,
    required this.titleItem,
  });

  final Key? key;

  final CategoryEntity category;

  final String titleItem;

  @override
  String toString() {
    return 'SelectSubCategoryRouteArgs{key: $key, category: $category, titleItem: $titleItem}';
  }
}

/// generated route for
/// [SubCategoriesScreen]
class SubCategoriesRoute extends PageRouteInfo<SubCategoriesRouteArgs> {
  SubCategoriesRoute({
    Key? key,
    required CategoryEntity category,
    List<PageRouteInfo>? children,
  }) : super(
          SubCategoriesRoute.name,
          args: SubCategoriesRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'SubCategoriesRoute';

  static const PageInfo<SubCategoriesRouteArgs> page =
      PageInfo<SubCategoriesRouteArgs>(name);
}

class SubCategoriesRouteArgs {
  const SubCategoriesRouteArgs({
    this.key,
    required this.category,
  });

  final Key? key;

  final CategoryEntity category;

  @override
  String toString() {
    return 'SubCategoriesRouteArgs{key: $key, category: $category}';
  }
}
