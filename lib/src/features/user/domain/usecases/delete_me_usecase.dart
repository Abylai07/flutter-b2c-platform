import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';


class DeleteMeUseCase extends UseCase<Map<String, dynamic>?, MapParams> {
  DeleteMeUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(MapParams? params) async {
    return await repository.deleteMe();
  }
}

