import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/orders/domain/repositories/order_repository.dart';
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../item/change_item_usecase.dart';


class UpdateStatusUseCase extends UseCase<Map<String, dynamic>?, PathMapParams> {
  UpdateStatusUseCase(this.repository);

  final OrderRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(PathMapParams? params) async {
    return await repository.updateStatus(params);
  }
}



