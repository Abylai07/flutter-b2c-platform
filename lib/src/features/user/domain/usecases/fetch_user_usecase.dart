import 'package:dartz/dartz.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';


class FetchUserUseCase extends UseCase<UserEntity?, PathParams> {
  FetchUserUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(PathParams? params) async {
    return await repository.fetchUserInfo();
  }
}


class PathParams {
  const PathParams(this.path);

  final String path;
}
