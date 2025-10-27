import 'package:b2c_platform/src/features/items/data/models/item_detail_model.dart';
import 'package:b2c_platform/src/features/items/data/models/item_model.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_for%20_update.dart';

class ItemForUpdateModel extends ItemForUpdateEntity {
  const ItemForUpdateModel({
    required super.title,
    required super.subCategory,
    required super.description,
    required super.bail,
    required super.condition,
    required super.obtainmentTypes,
    required super.returnTypes,
    required List<PlaceModel> super.places,
    required super.images,
    required List<PeriodModel> super.periods,
  });


  static ItemForUpdateModel fromJson(Map<String, dynamic> json) {
    return ItemForUpdateModel(
      title: json['title'],
      subCategory: json['sub_category'],
      description: json['description'],
      bail: json['bail'],
      condition: json['condition'],
      obtainmentTypes: List<int>.from(json['obtainment_types']),
      returnTypes: List<int>.from(json['return_types']),
      places: List<PlaceModel>.from(json['places'].map((p) => PlaceModel.fromJson(p))),
      images: List<ImageInfo>.from(json['images'].map((i) => ImageInfo.fromJson(i))),
      periods: List<PeriodModel>.from(json['periods'].map((p) => PeriodModel.fromJson(p))),
    );
  }
}


class ImageInfo extends ImageInfoEntity {

  const ImageInfo({
    required super.id,
    required super.image,
    required super.item,
  });


  /// Converts an [ImageInfo] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'item': item,
    };
  }

  /// Creates an [ImageInfo] instance from a JSON map.
  static ImageInfo fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      id: json['id'] as int,
      image: json['image'] as String,
      item: json['item'] as int,
    );
  }
}
