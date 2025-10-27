import 'package:dio/dio.dart';
import 'package:b2c_platform/src/features/items/data/models/categories_model.dart';
import 'package:b2c_platform/src/features/items/data/models/id_name_model.dart';
import 'package:b2c_platform/src/features/items/data/models/my_item_model.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_for%20_update.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import '../../common/api.dart';
import '../../common/constants.dart' as constants;
import '../../core/error/exception.dart';
import '../../domain/entity/items/create_item_entity.dart';
import '../../domain/usecase/item/change_item_usecase.dart';
import '../../domain/usecase/item/fetch_items_usecase.dart';
import '../../domain/usecase/item/fetch_my_items_usecase.dart';
import '../../domain/usecase/item/item_photo_usecase.dart';
import '../../domain/usecase/user/fetch_user_usecase.dart';
import '../models/items/create_item_model.dart';
import '../models/items/item_detail_model.dart';
import '../models/items/item_for _update.dart';
import '../models/items/item_model.dart';

abstract class ItemRemoteDataSource {
  Future<PaginationItemEntity> fetchItems(ItemsParams params);

  Future<ItemDetailEntity> fetchItemDetail(PathParams params);

  Future<List<CategoryEntity>> fetchCategories();

  Future<List<PlaceEntity>> fetchPlaceList();

  Future<PlaceEntity> createPlace(MapParams params);

  Future<List<IdNameEntity>> fetchConditionList();

  Future<List<IdNameEntity>> fetchPeriodTypes();

  Future<List<IdNameEntity>> fetchReturnTypes();

  Future<List<IdNameEntity>> fetchObtainTypes();

  Future<CreateItemEntity> createItem(MapParams params);

  Future<Map<String, dynamic>> updateItemPhoto(FormParams params);

  Future<Map<String, dynamic>> deleteItemPhoto(PathParams params);

  Future<PaginationMyItemEntity> fetchMyItems(PaginationParams params);

  Future<ItemForUpdateEntity> fetchItemUpdate(PathParams params);

  Future<ItemForUpdateEntity> changeItemData(PathMapParams params);

  Future<Map<String, dynamic>> changeItemStatus(PathParams params);

//  Future<AuthEntity> signIn(MapParams params);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final API api;

  ItemRemoteDataSourceImpl(this.api);

  @override
  Future<PaginationItemEntity> fetchItems(ItemsParams params) async {
    try {
      final response = await api.dio.get(
        params.query.isNotEmpty
            ? '${constants.host}items/?page=${params.page}&search=${params.query}'
            : params.categoryId != null
                ? '${constants.host}items/?sub_category_id=${params.categoryId}&page=${params.page}'
                : '${constants.host}items/?page=${params.page}',
      );

      if (response.statusCode == 200) {
        List<ItemEntity> itemEntity = (response.data['results'] as List)
            .map((e) => ItemModel.fromJson(e))
            .toList();
        return PaginationItemModel(
            isLast: response.data['next'] == null, itemEntity: itemEntity);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<CategoryEntity>> fetchCategories() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/item-category-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<ItemDetailEntity> fetchItemDetail(PathParams params) async {
    try {
      final response =
          await api.dio.get('${constants.host}items/${params.path}/');

      if (response.statusCode == 200) {
        return ItemDetailModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<PlaceEntity> createPlace(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}items/place-create/',
        data: params.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PlaceModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<PlaceEntity>> fetchPlaceList() async {
    try {
      final response = await api.dio.get('${constants.host}items/place-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => PlaceModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<IdNameEntity>> fetchConditionList() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/condition-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IdNameModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<IdNameEntity>> fetchPeriodTypes() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/period-type-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IdNameModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<IdNameEntity>> fetchReturnTypes() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/return-type-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IdNameModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<IdNameEntity>> fetchObtainTypes() async {
    try {
      final response =
          await api.dio.get('${constants.host}items/obtainment-type-list/');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => IdNameModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<CreateItemEntity> createItem(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}items/create/',
        data: params.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateItemModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateItemPhoto(FormParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}items/update-item-images/',
        data: params.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<PaginationMyItemEntity> fetchMyItems(PaginationParams params) async {
    try {
      final response = await api.dio.get(params.status.isEmpty
          ? params.page <= 1
              ? '${constants.host}items/my/'
              : '${constants.host}items/my/?page=${params.page}'
          : params.page <= 1
              ? '${constants.host}items/my/?status=${params.status}'
              : '${constants.host}items/my/?page=${params.page}&status=${params.status}');

      if (response.statusCode == 200) {
        List<MyItemEntity> itemEntity = (response.data['results'] as List)
            .map((e) => MyItemModel.fromJson(e))
            .toList();
        return PaginationMyItemEntity(
            isLast: response.data['next'] == null, itemEntity: itemEntity);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<ItemForUpdateEntity> fetchItemUpdate(PathParams params) async {
    try {
      final response = await api.dio.get(
        '${constants.host}items/for-update/${params.path}/',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ItemForUpdateModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> changeItemStatus(PathParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}items/${params.path}/',
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<ItemForUpdateEntity> changeItemData(PathMapParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}items/for-update/${params.path}/',
        data: params.data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ItemForUpdateModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteItemPhoto(PathParams params) async {
    try {
      final response = await api.dio.delete(
        '${constants.host}items/remove-image/${params.path}/',
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return {};
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
