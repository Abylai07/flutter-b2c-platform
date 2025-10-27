import 'package:equatable/equatable.dart';

import '../items/item_detail_entity.dart';
import '../items/item_entity.dart';
import '../user/user_entity.dart';

class OrderDetailEntity extends Equatable {
  final int id;
  final UserEntity createdUser;
  final NewItemEntity item;
  final PlaceEntity? shopPlace;
  final PlaceEntity? userPlace;
  final String obtainmentType;
  final PeriodEntity period;
  final String comments;
  final int periodAmount;
  final int price;
  final int otpCounter;
  final String status;
  final String created;

  const OrderDetailEntity({
    required this.id,
    required this.createdUser,
    required this.item,
    this.shopPlace,
    this.userPlace,
    required this.obtainmentType,
    required this.period,
    required this.comments,
    required this.periodAmount,
    required this.price,
    required this.otpCounter,
    required this.status,
    required this.created,
  });

  @override
  List<Object?> get props => [
    id,
    createdUser,
    item,
    shopPlace,
    userPlace,
    obtainmentType,
    period,
    comments,
    periodAmount,
    price,
    otpCounter,
    status,
    created,
  ];
}

class NewItemEntity extends Equatable {
  final UserEntity createdUser;
  final List<String> images;
  final List<String> outsideImages;
  final String title;

  const NewItemEntity({
    required this.createdUser,
    required this.images,
    required this.outsideImages,
    required this.title,
  });

  @override
  List<Object?> get props => [createdUser, images, outsideImages, title];
}