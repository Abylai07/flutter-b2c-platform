import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';


class IdNameModel extends IdNameEntity {
  const IdNameModel({required super.id, required super.name, super.nameSingle});

  factory IdNameModel.fromJson(Map<String, dynamic> json) {
    return IdNameModel(
      id: json['id'],
      name: json['name'],
      nameSingle: json['name_single'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_single': nameSingle,
    };
  }
}
