import 'package:dartz/dartz.dart';
import 'package:b2c_platform/src/features/items/domain/entities/categories_entity.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import 'package:b2c_platform/src/core/usecases/usecase.dart';
import '../../repository/abstract_item_service_profile.dart';


class FetchCategoriesUseCase extends UseCase<List<CategoryEntity>?, PathParams> {
  FetchCategoriesUseCase(this.repository);

  final ItemRepository repository;

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(PathParams? params) async {
    return await repository.fetchCategories(params);
  }
}

