import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/data/datasources/item_remote_data_source.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_for%20_update.dart';
import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';
import 'package:b2c_platform/src/features/items/domain/repositories/item_repository.dart';

import '../../core/check_error_type.dart';
import '../../core/error/failure.dart';
import '../../domain/entity/items/create_item_entity.dart';

class ItemRepositoryImpl extends ItemRepository {
  ItemRepositoryImpl(this.dataSource, this._networkOperationHelper);
  final ItemRemoteDataSource dataSource;
  final NetworkOperationHelper _networkOperationHelper;

  @override
  Future<Either<Failure, PaginationItemEntity>> fetchItems(params) async {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchItems(params));
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> fetchCategories(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchCategories());
  }

  @override
  Future<Either<Failure, ItemDetailEntity>> fetchItemDetail(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchItemDetail(params));
  }

  @override
  Future<Either<Failure, PlaceEntity>> createPlace(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.createPlace(params));
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> fetchPlaceList() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchPlaceList());
  }

  @override
  Future<Either<Failure, List<IdNameEntity>>> fetchConditionList() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchConditionList());
  }

  @override
  Future<Either<Failure, List<IdNameEntity>>> fetchPeriodType() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchPeriodTypes());
  }

  @override
  Future<Either<Failure, List<IdNameEntity>>> fetchReturnTypes() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchReturnTypes());
  }

  @override
  Future<Either<Failure, List<IdNameEntity>>> fetchObtainment() {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchObtainTypes());
  }

  @override
  Future<Either<Failure, CreateItemEntity>> createItem(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.createItem(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateItemPhoto(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.updateItemPhoto(params));
  }

  @override
  Future<Either<Failure, PaginationMyItemEntity>> fetchMyItems(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchMyItems(params));
  }

  @override
  Future<Either<Failure, ItemForUpdateEntity>> fetchItemForUpdate(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.fetchItemUpdate(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> changeItemStatus(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.changeItemStatus(params));
  }
  @override
  Future<Either<Failure, ItemForUpdateEntity>> changeItemData(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.changeItemData(params));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteItemPhoto(params) {
    return _networkOperationHelper
        .performNetworkOperation(() => dataSource.deleteItemPhoto(params));
  }
}
