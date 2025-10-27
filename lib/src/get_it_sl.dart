import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:b2c_platform/src/features/items/data/datasources/item_remote_data_source.dart';
import 'package:b2c_platform/src/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:b2c_platform/src/features/items/domain/repositories/item_repository.dart';
import 'package:b2c_platform/src/features/orders/domain/repositories/order_repository.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/create_place_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_item_for_update_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_items_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_my_items_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_places_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/item_photo_usecase.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/book_item_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/logout_usecase.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:b2c_platform/src/platform/network_info.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/create_item_cubit.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/item_photo_cubit.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_condition_bloc/condition_cubit.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_obtainment_bloc/obtainment_cubit.dart';
import 'package:b2c_platform/src/features/items/presentation/pages/add_item/bloc/select_period_bloc/period_cubit.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_in/bloc/sign_in_cubit.dart';
import 'package:b2c_platform/src/features/auth/presentation/sign_up/bloc/sign_up_cubit.dart';
import 'package:b2c_platform/src/features/categories/presentation/pages/bloc/category_items_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/book_item_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/category_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/city_bloc/city_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/item_detail_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/bloc/items_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/bloc/create_place/create_place_cubit.dart';
import 'package:b2c_platform/src/features/home/presentation/pages/item_card/bloc/place_list/place_list_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/category_select/category_select_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/change_item_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/delete_me_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/item_update_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/my_item_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/my_orders/my_orders_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/order_detail.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/status_count/status_count_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/update_status/update_status_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_info_cubit.dart';
import 'package:b2c_platform/src/features/user/presentation/pages/profile/bloc/user_photo_cubit.dart';

import 'common/api.dart';
import 'core/check_error_type.dart';

// Auth feature
import 'package:b2c_platform/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:b2c_platform/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:b2c_platform/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_up_usecase.dart';

// User feature
import 'package:b2c_platform/src/features/user/data/datasources/user_remote_data_source.dart';
import 'package:b2c_platform/src/features/user/data/repositories/user_repository_impl.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/delete_me_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_city_usecase.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/user_photo_usecase.dart';

// Items feature
import 'package:b2c_platform/src/features/items/data/repositories/item_repository_impl.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/change_item_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/create_item_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_categories_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_condition_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_item_detail_usecase.dart';
import 'package:b2c_platform/src/features/items/domain/usecases/fetch_types_usecase.dart';

// Orders feature
import 'package:b2c_platform/src/features/orders/data/repositories/order_repository_impl.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/fetch_order_detail_usecase.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/order_item_usecase.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/status_count_usecase.dart';
import 'package:b2c_platform/src/features/orders/domain/usecases/update_status_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NetworkOperationHelper>(() => NetworkOperationHelper(sl()));

  //BLoCs
  sl.registerFactory(() => SignInCubit(sl(), sl()));
  sl.registerFactory(() => SignUpCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UserInfoCubit(sl()));
  sl.registerFactory(() => CityCubit(sl()));
  sl.registerFactory(() => DeleteMeCubit(sl()));
  sl.registerFactory(() => UserPhotoCubit(sl()));

  sl.registerFactory(() => ItemsCubit(sl()));
  sl.registerFactory(() => CategoryCubit(sl()));
  sl.registerFactory(() => ItemDetailCubit(sl()));
  sl.registerFactory(() => CategoryItemsCubit(sl()));
  sl.registerFactory(() => PlaceListCubit(sl()));
  sl.registerFactory(() => CreatePlaceCubit(sl()));
  sl.registerFactory(() => PeriodSelectCubit(sl()));
  sl.registerFactory(() => ConditionSelectCubit(sl()));
  sl.registerFactory(() => ObtainmentSelectCubit(sl()));
  sl.registerFactory(() => CreateItemCubit(sl()));
  sl.registerFactory(() => ItemPhotoCubit(sl()));
  sl.registerFactory(() => MyItemCubit(sl()));
  sl.registerFactory(() => ItemUpdateCubit(sl()));
  sl.registerFactory(() => ChangeItemCubit(sl(), sl()));
  sl.registerFactory(() => CategorySelectCubit(sl()));

  sl.registerFactory(() => BookItemCubit(sl()));
  sl.registerFactory(() => MyOrdersCubit(sl()));
  sl.registerFactory(() => StatusCountCubit(sl()));
  sl.registerFactory(() => UpdateStatusCubit(sl()));
  sl.registerFactory(() => OrderDetailCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => FetchUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOtpUseCase(sl()));
  sl.registerLazySingleton(() => SignVerifyUseCase(sl()));
  sl.registerLazySingleton(() => SignDataUseCase(sl()));
  sl.registerLazySingleton(() => SignPasswordUseCase(sl()));
  sl.registerLazySingleton(() => FetchCityUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMeUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => UserPhotoUseCase(sl()));

  sl.registerLazySingleton(() => FetchItemsUseCase(sl()));
  sl.registerLazySingleton(() => FetchCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => FetchItemDetailUseCase(sl()));
  sl.registerLazySingleton(() => FetchPlacesUseCase(sl()));
  sl.registerLazySingleton(() => CreatePlaceUseCase(sl()));
  sl.registerLazySingleton(() => FetchTypesUseCase(sl()));
  sl.registerLazySingleton(() => FetchConditionUseCase(sl()));
  sl.registerLazySingleton(() => CreateItemUseCase(sl()));
  sl.registerLazySingleton(() => ItemPhotoUseCase(sl()));
  sl.registerLazySingleton(() => FetchMyItemUseCase(sl()));
  sl.registerLazySingleton(() => FetchItemUpdateUseCase(sl()));
  sl.registerLazySingleton(() => ChangeItemUseCase(sl()));

  sl.registerLazySingleton(() => BookItemUseCase(sl()));
  sl.registerLazySingleton(() => OrderItemUseCase(sl()));
  sl.registerLazySingleton(() => StatusCountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStatusUseCase(sl()));
  sl.registerLazySingleton(() => FetchOrderDetailUseCase(sl()));

 // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ItemRemoteDataSource>(
        () => ItemRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
        () => OrderRemoteDataSourceImpl(sl()),
  );

 // Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ItemRepository>(
        () => ItemRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImpl(sl(), sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => API());
    sl.registerLazySingleton(() => InternetConnectionChecker());
}
