// lib/data/models/user_model.dart
import '../../../domain/entity/user/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
     super.firstName,
     super.lastName,
     super.email,
     super.isStoreVerified,
     super.dateOfBirth,
     super.organizationType,
     super.companyName,
     super.iin,
     super.bik,
     super.iban,
    super.city,
    super.place,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'] ?? '',
      isStoreVerified: json['is_store_verified'],
      dateOfBirth: json['date_of_birth'],
      organizationType: json['organization_type'] ?? '',
      companyName: json['company_name'] ?? '',
      iin: json['iin'] ?? '',
      bik: json['bik'] ?? '',
      iban: json['iban'] ?? '',
      city: json['city'],
      place: json['place'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'is_store_verified': isStoreVerified,
      'date_of_birth': dateOfBirth,
      'organization_type': organizationType,
      'company_name': companyName,
      'iin': iin,
      'bik': bik,
      'iban': iban,
      'city': city,
      'place': place,
    };
  }
}
