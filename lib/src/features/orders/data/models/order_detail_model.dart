import 'package:b2c_platform/src/features/items/data/models/item_detail_model.dart';
import 'package:b2c_platform/src/features/user/data/models/user_info_model.dart';

import '../../../domain/entity/items/item_entity.dart';
import '../../../domain/entity/order/order_detail_entity.dart';
import '../../../domain/entity/user/user_entity.dart';
import '../items/item_model.dart';

class OrderDetailModel extends OrderDetailEntity {
  const OrderDetailModel({
    required super.id,
    required super.createdUser,
    required NewItemModel super.item,
    super.shopPlace,
    super.userPlace,
    required super.obtainmentType,
    required super.period,
    required super.comments,
    required super.periodAmount,
    required super.price,
    required super.otpCounter,
    required super.status,
    required super.created,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'],
      createdUser: UserModel.fromJson(json['created_user']),
      item: NewItemModel.fromJson(json['item']),
      shopPlace: json['shop_place'] != null ? PlaceModel.fromJson(json['shop_place']) : null,
      userPlace: json['user_place'] != null ? PlaceModel.fromJson(json['user_place']) : null,
      obtainmentType: json['obtainment_type'],
      period: PeriodModel.fromJson(json['period']),
      comments: json['comments'],
      periodAmount: json['period_amount'],
      price: json['price'],
      otpCounter: json['otp_counter'],
      status: json['status'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_place': shopPlace,
      'user_place': userPlace,
      'obtainment_type': obtainmentType,
      'comments': comments,
      'period_amount': periodAmount,
      'price': price,
      'otp_counter': otpCounter,
      'status': status,
      'created': created,
    };
  }
}

class NewItemModel extends NewItemEntity {
  const NewItemModel({
    required super.createdUser,
    required super.images,
    required super.outsideImages,
    required super.title,
  });

  factory NewItemModel.fromJson(Map<String, dynamic> json) {
    return NewItemModel(
      createdUser: UserModel.fromJson(json['created_user']),
      images:  convertFilePathsToUrls(List<String>.from(json['images'])),
      outsideImages: List<String>.from(json['outside_images']),
      title: json['title'],
    );
  }

}

