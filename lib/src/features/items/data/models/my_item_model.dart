import 'package:b2c_platform/src/features/items/domain/entities/my_items_entity.dart';

import 'item_model.dart';

class MyItemModel extends MyItemEntity {
  const MyItemModel(
      {required super.id,
      required super.title,
      required super.totalGiven,
      required super.totalViewed,
      required super.images,
      required super.outsideImages,
      required super.periods,
      required super.status,
      required super.condition,
      required super.created});

  factory MyItemModel.fromJson(Map<String, dynamic> json) {
    return MyItemModel(
      id: json['id'],
      title: json['title'],
      totalGiven: json['total_given'],
      totalViewed: json['total_viewed'],
      images: convertFilePathsToUrls(List<String>.from(json['images'])),
      outsideImages: List<String>.from(json['outside_images']),
      periods: List<PeriodModel>.from(
          json['periods'].map((x) => PeriodModel.fromJson(x))),
      status: json['status'],
      condition: json['condition'],
      created: DateTime.parse(json['created']),
    );
  }

}
