// lib/domain/entities/user_entity.dart

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isStoreVerified;
  final String? dateOfBirth;
  final String? organizationType;
  final String? companyName;
  final String? iin;
  final String? bik;
  final String? iban;
  final int? city;
  final int? place;

  const UserEntity({
    required this.id,
    required this.username,
     this.firstName,
     this.lastName,
     this.email,
     this.isStoreVerified,
     this.dateOfBirth,
     this.organizationType,
     this.companyName,
     this.iin,
     this.bik,
     this.iban,
    this.city,
    this.place,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    email,
    isStoreVerified,
    dateOfBirth,
    organizationType,
    companyName,
    iin,
    bik,
    iban,
    city,
    place,
  ];
}
