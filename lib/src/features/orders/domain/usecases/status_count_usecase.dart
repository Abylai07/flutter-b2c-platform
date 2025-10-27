import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/orders/domain/entities/status_count_entity.dart';
import 'package:b2c_platform/src/features/orders/domain/repositories/order_repository.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';


class StatusCountUseCase extends UseCase<StatusCountEntity?, PathParams> {
  StatusCountUseCase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, StatusCountEntity>> call(PathParams? params) async {
    return await repository.fetchStatusCount(params);
  }
}


