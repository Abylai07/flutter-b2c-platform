import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final List<SubcategoryEntity> subcategories;
  final int itemCount;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.subcategories,
    required this.itemCount,
  });

  @override
  List<Object?> get props => [id, name, image, subcategories, itemCount];
}

class SubcategoryEntity extends Equatable {
  final int id;
  final String name;
  final List<SubcategoryEntity> subcategories;
  final int itemCount;

  const SubcategoryEntity({
    required this.id,
    required this.name,
    required this.subcategories,
    required this.itemCount,
  });

  @override
  List<Object?> get props => [id, name, subcategories, itemCount];
}
