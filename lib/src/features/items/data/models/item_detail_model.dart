import '../../../domain/entity/items/item_detail_entity.dart';
import '../user/user_info_model.dart';
import 'item_model.dart';


class ItemDetailModel extends ItemDetailEntity {
  const ItemDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required UserModel super.createdUser,
    required SubcategoryModel super.subCategory,
    required super.images,
    required super.outsideImages,
    required List<PeriodModel> super.periods,
    required super.condition,
    required super.created,
    required super.bail,
    required super.status,
    required List<PlaceModel> super.places,
    required List<ObtainmentTypeModel> super.obtainmentTypes,
    required super.returnTypes,
  });

  factory ItemDetailModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdUser: UserModel.fromJson(json['created_user']),
      subCategory: SubcategoryModel.fromJson(json['sub_category']),
      images: convertFilePathsToUrls(List<String>.from(json['images'])),
      outsideImages: List<String>.from(json['outside_images']),
      periods: (json['periods'] as List).map((e) => PeriodModel.fromJson(e)).toList(),
      condition: json['condition'],
      created: json['created'],
      bail: json['bail'],
      status: json['status'],
      places: (json['places'] as List).map((e) => PlaceModel.fromJson(e)).toList(),
      obtainmentTypes: (json['obtainment_types'] as List).map((e) => ObtainmentTypeModel.fromJson(e)).toList(),
      returnTypes: json['return_types'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_user': (createdUser as UserModel).toJson(),
      'sub_category': subCategory,
      'images': images,
      'outside_images': outsideImages,
      'periods': periods.map((e) => (e as PeriodModel).toJson()).toList(),
      'condition': condition,
      'created': created,
    };
  }
}

class SubcategoryModel extends SubCategoryEntity {
  const SubcategoryModel({
    required super.id,
    super.name,
    super.category,
    SubcategoryModel? super.subcategories,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      subcategories: json['subcategories'] != null ? SubcategoryModel.fromJson(json['subcategories']) : null,
    );
  }
}

class ObtainmentTypeModel extends ObtainmentTypeEntity {
  const ObtainmentTypeModel({
    required super.id,
    required super.name,
  });

  factory ObtainmentTypeModel.fromJson(Map<String, dynamic> json) {
    return ObtainmentTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class ReturnTypeModel extends ReturnTypeEntity {
  const ReturnTypeModel({
    required super.name,
  });

  factory ReturnTypeModel.fromJson(Map<String, dynamic> json) {
    return ReturnTypeModel(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.city,
    required super.address,
    required super.lat,
    required super.lon,
    required super.userId,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      city: json['city'].toString(),
      address: json['address'],
      lat: json['lat'],
      lon: json['lon'],
      userId: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'address': address,
      'lat': lat,
      'lon': lon,
      'user': userId,
    };
  }
}

