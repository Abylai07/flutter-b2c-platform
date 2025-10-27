import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.image,
    required List<SubcategoryModel> super.subcategories,
    required super.itemCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      subcategories: (json['subcategories'] as List)
          .map((subcategory) => SubcategoryModel.fromJson(subcategory))
          .toList(),
      itemCount: json['item_count'],
    );
  }

}

class SubcategoryModel extends SubcategoryEntity {
  const SubcategoryModel({
    required super.id,
    required super.name,
    required List<SubcategoryModel> super.subcategories,
    required super.itemCount,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'],
      name: json['name'],
      subcategories: (json['subcategories'] as List)
          .map((subcategory) => SubcategoryModel.fromJson(subcategory))
          .toList(),
      itemCount: json['item_count'],
    );
  }
}
