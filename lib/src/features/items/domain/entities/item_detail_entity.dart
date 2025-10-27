import 'package:equatable/equatable.dart';

import '../user/user_entity.dart';
import 'item_entity.dart';

class ItemDetailEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final UserEntity createdUser;
  final SubCategoryEntity subCategory;
  final List<String> images;
  final List<String> outsideImages;
  final List<PeriodEntity> periods;
  final List<PlaceEntity> places;
  final List<ObtainmentTypeEntity> obtainmentTypes;
  final List<dynamic> returnTypes;
  final String condition;
  final bool bail;
  final String status;
  final String created;

  const ItemDetailEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdUser,
    required this.subCategory,
    required this.images,
    required this.outsideImages,
    required this.periods,
    required this.condition,
    required this.bail,
    required this.status,
    required this.created,
    required this.places,
    required this.obtainmentTypes,
    required this.returnTypes,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    createdUser,
    subCategory,
    images,
    outsideImages,
    periods,
    condition,
    bail,
    status,
    created,
    places,
    obtainmentTypes,
    returnTypes,
  ];
}


class SubCategoryEntity extends Equatable {
  final int id;
  final String? name;
  final String? category;
  final SubCategoryEntity? subcategories;

  const SubCategoryEntity({
    required this.id,
    this.name,
    this.category,
    this.subcategories,
  });

  @override
  List<Object?> get props => [id, name, category, subcategories, ];
}

class ObtainmentTypeEntity extends Equatable {
  final int id;
  final String name;

  const ObtainmentTypeEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class ReturnTypeEntity extends Equatable {
  final String name;

  const ReturnTypeEntity({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}

class PlaceEntity extends Equatable {
  final int id;
  final String city;
  final String address;
  final String lat;
  final String lon;
  final int userId;

  const PlaceEntity({
    required this.id,
    required this.city,
    required this.address,
    required this.lat,
    required this.lon,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, city, address, lat, lon, userId];
}




