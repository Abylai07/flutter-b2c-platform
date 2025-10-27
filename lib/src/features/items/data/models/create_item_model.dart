import '../../../domain/entity/items/create_item_entity.dart';
import '../user/user_info_model.dart';
import 'item_model.dart';

class CreateItemModel extends CreateItemEntity {
  const CreateItemModel({
    required super.id,
    required UserModel super.createdUser,
    required super.obtainmentTypes,
    required super.returnTypes,
    required super.places,
    required List<PeriodModel> super.periods,
    required super.title,
    required super.description,
    required super.bail,
    required super.status,
    required super.created,
    required super.subCategory,
    required super.condition,
  });

  factory CreateItemModel.fromJson(Map<String, dynamic> json) {
    return CreateItemModel(
      id: json['id'],
      createdUser: UserModel.fromJson(json['created_user']),
      obtainmentTypes: List<int>.from(json['obtainment_types']),
      returnTypes: List<int>.from(json['return_types']),
      places: List<int>.from(json['places']),
      periods: (json['periods'] as List)
          .map((period) => PeriodModel.fromJson(period))
          .toList(),
      title: json['title'],
      description: json['description'],
      bail: json['bail'],
      status: json['status'],
      created: DateTime.parse(json['created']),
      subCategory: json['sub_category'],
      condition: json['condition'],
    );
  }
}