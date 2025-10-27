import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_detail_entity.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';

class ItemForUpdateEntity extends Equatable {
  final String title;
  final int subCategory;
  final String description;
  final bool bail;
  final int condition;
  final List<int> obtainmentTypes;
  final List<int> returnTypes;
  final List<PlaceEntity> places;
  final List<ImageInfoEntity> images;
  final List<PeriodEntity>  periods;

  const ItemForUpdateEntity({
    required this.title,
    required this.subCategory,
    required this.description,
    required this.bail,
    required this.condition,
    required this.obtainmentTypes,
    required this.returnTypes,
    required this.places,
    required this.images,
    required this.periods,
  });

  @override
  List<Object?> get props => [
    title,
    subCategory,
    description,
    bail,
    condition,
    obtainmentTypes,
    returnTypes,
    places,
    images,
    periods,
  ];
}

class ImageInfoEntity extends Equatable {
  final int id;
  final String image;
  final int item;

  const ImageInfoEntity({
    required this.id,
    required this.image,
    required this.item,
  });

  @override
  List<Object?> get props => [id, image, item];
}
