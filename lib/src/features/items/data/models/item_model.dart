import 'package:b2c_platform/src/common/constants.dart' as constants;

import '../../../domain/entity/items/item_entity.dart';
import '../user/user_info_model.dart';
class PaginationItemModel extends PaginationItemEntity{
  const PaginationItemModel({required super.isLast, required super.itemEntity});

}

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.title,
    required super.description,
    required UserModel super.createdUser,
    required super.subCategory,
    required super.images,
    required super.outsideImages,
    required List<PeriodModel> super.periods,
    required super.condition,
    required super.created,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdUser: UserModel.fromJson(json['created_user']),
      subCategory: json['sub_category'],
      images: convertFilePathsToUrls(List<String>.from(json['images'])),
      outsideImages: List<String>.from(json['outside_images']),
      periods: (json['periods'] as List).map((e) => PeriodModel.fromJson(e)).toList(),
      condition: json['condition'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_user': (createdUser as UserModel).toJson(),
      'sub_category': subCategory,
      'images': images,
      'outside_images': outsideImages,
      'periods': periods.map((e) => (e as PeriodModel).toJson()).toList(),
      'condition': condition,
      'created': created,
    };
  }
}

List<String> convertFilePathsToUrls(List<String> filePaths) {
  return filePaths.map((filePath) {
    return filePath.replaceFirst('/', constants.host);
  }).toList();
}

class PeriodModel extends PeriodEntity {
  const PeriodModel({
    required super.id,
    required super.period,
    required super.price,
    required super.holidayPrice,
    super.itemId,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) {
    return PeriodModel(
      id: json['id'],
      period: json['period'].toString(),
      price: json['price'].toDouble(),
      holidayPrice: json['holiday_price'].toDouble(),
      itemId: json['item'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'period': period,
      'price': price,
      'holiday_price': holidayPrice,
      'item': itemId,
    };
  }
}
