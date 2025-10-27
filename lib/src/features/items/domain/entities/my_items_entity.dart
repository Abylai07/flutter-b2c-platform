import 'package:equatable/equatable.dart';

import 'item_entity.dart';

class PaginationMyItemEntity extends Equatable{
  final bool isLast;
  final List<MyItemEntity> itemEntity;

  const PaginationMyItemEntity({
    required this.isLast,
    required this.itemEntity,
  });

  @override
  List<Object?> get props => [isLast, itemEntity];

}

class MyItemEntity extends Equatable {
  final int id;
  final String title;
  final int totalGiven;
  final int totalViewed;
  final List<String> images;
  final List<String> outsideImages;
  final List<PeriodEntity> periods;
  final String status;
  final String condition;
  final DateTime created;

  const MyItemEntity({
    required this.id,
    required this.title,
    required this.totalGiven,
    required this.totalViewed,
    required this.images,
    required this.outsideImages,
    required this.periods,
    required this.status,
    required this.condition,
    required this.created,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    totalGiven,
    totalViewed,
    images,
    outsideImages,
    periods,
    status,
    condition,
    created,
  ];
}

