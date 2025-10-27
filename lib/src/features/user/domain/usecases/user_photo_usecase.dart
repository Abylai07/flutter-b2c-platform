import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import '../item/item_photo_usecase.dart';


class UserPhotoUseCase {
  UserPhotoUseCase(this.repository);

  final UserRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> updateUserImage(FormParams? params) async {
    return await repository.updateUserImage(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> removeUserImage() async {
    return await repository.removeUserImage();
  }
}

