import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import '../../entity/items/item_for _update.dart';
import '../../repository/abstract_item_service_profile.dart';


class ChangeItemUseCase{
  ChangeItemUseCase(this.repository);

  final ItemRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> changeItemStatus(PathParams? params) async {
    return await repository.changeItemStatus(params);
  }

  Future<Either<Failure, ItemForUpdateEntity>> changeItemData(PathMapParams? params) async {
    return await repository.changeItemData(params);
  }
}


class PathMapParams extends Equatable{
  const PathMapParams({required this.data, required this.path});

  final Map<String, dynamic> data;
  final String path;
  @override
  List<Object> get props => [data, path];
}