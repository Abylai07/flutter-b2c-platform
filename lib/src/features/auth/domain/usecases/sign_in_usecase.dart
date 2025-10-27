import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/auth/domain/entities/auth_entity.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import 'package:b2c_platform/src/features/user/domain/repositories/user_repository.dart';


class SignInUseCase extends UseCase<AuthEntity?, MapParams> {
  SignInUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, AuthEntity>> call(MapParams? params) async {
    return await repository.signIn(params);
  }
}

class MapParams extends Equatable{
  const MapParams(this.data);

  final Map<String, dynamic> data;
  @override
  List<Object> get props => [data];
}
