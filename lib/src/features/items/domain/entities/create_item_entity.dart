import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/item_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';

class CreateItemEntity extends Equatable{
  final int id;
  final UserEntity createdUser;
  final List<int> obtainmentTypes;
  final List<int> returnTypes;
  final List<int> places;
  final List<PeriodEntity> periods;
  final String title;
  final String description;
  final bool bail;
  final String status;
  final DateTime created;
  final int subCategory;
  final int condition;

  const CreateItemEntity({
    required this.id,
    required this.createdUser,
    required this.obtainmentTypes,
    required this.returnTypes,
    required this.places,
    required this.periods,
    required this.title,
    required this.description,
    required this.bail,
    required this.status,
    required this.created,
    required this.subCategory,
    required this.condition,
  });

  @override
  List<Object?> get props => [
    id,
    createdUser,
    obtainmentTypes,
    returnTypes,
    places,
    periods,
    title,
    description,
    bail,
    status,
    created,
    subCategory,
    condition,
  ];
}
