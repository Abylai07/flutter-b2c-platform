import 'package:equatable/equatable.dart';

import '../user/user_entity.dart';


class PaginationItemEntity extends Equatable{
  final bool isLast;
  final List<ItemEntity> itemEntity;

  const PaginationItemEntity({
    required this.isLast,
    required this.itemEntity,
  });

  @override
  List<Object?> get props => [isLast, itemEntity];

}


class ItemEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final UserEntity? createdUser;
  final String? subCategory;
  final List<String> images;
  final List<String> outsideImages;
  final List<PeriodEntity> periods;
  final String condition;
  final String created;

  const ItemEntity({
    required this.id,
    required this.title,
    required this.images,
    required this.outsideImages,
    required this.periods,
    required this.condition,
    required this.created,
    this.description,
    this.createdUser,
    this.subCategory,
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
    created,
  ];
}


class PeriodEntity extends Equatable {
  final int id;
  final String period;
  final double price;
  final double holidayPrice;
  final int? itemId;

  const PeriodEntity({
    required this.id,
    required this.period,
    required this.price,
    required this.holidayPrice,
    this.itemId,
  });

  @override
  List<Object?> get props => [id, period, price, holidayPrice, itemId];
}
