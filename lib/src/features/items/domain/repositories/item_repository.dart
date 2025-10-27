import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';

import '../../core/error/failure.dart';
import '../entity/items/create_item_entity.dart';
import '../entity/items/item_detail_entity.dart';
import '../entity/items/item_for _update.dart';
import '../entity/items/my_items_entity.dart';

abstract class ItemRepository {

  Future<Either<Failure, PaginationItemEntity>> fetchItems(params);

  Future<Either<Failure, ItemDetailEntity>> fetchItemDetail(params);

  Future<Either<Failure, List<CategoryEntity>>> fetchCategories(params);

  Future<Either<Failure, List<PlaceEntity>>> fetchPlaceList();

  Future<Either<Failure, List<IdNameEntity>>> fetchConditionList();

  Future<Either<Failure, List<IdNameEntity>>> fetchReturnTypes();

  Future<Either<Failure, List<IdNameEntity>>> fetchPeriodType();

  Future<Either<Failure, List<IdNameEntity>>> fetchObtainment();

  Future<Either<Failure, PlaceEntity>> createPlace(params);

  Future<Either<Failure, CreateItemEntity>> createItem(params);

  Future<Either<Failure, Map<String, dynamic>>> updateItemPhoto(params);

  Future<Either<Failure, Map<String, dynamic>>> deleteItemPhoto(params);

  Future<Either<Failure, PaginationMyItemEntity>> fetchMyItems(params);

  Future<Either<Failure, ItemForUpdateEntity>> fetchItemForUpdate(params);

  Future<Either<Failure, Map<String, dynamic>>> changeItemStatus(params);

  Future<Either<Failure, ItemForUpdateEntity>> changeItemData(params);
}