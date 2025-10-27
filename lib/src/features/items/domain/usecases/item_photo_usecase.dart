import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/user/domain/usecases/fetch_user_usecase.dart';

import 'package:b2c_platform/src/core/error/failure.dart';
import '../../repository/abstract_item_service_profile.dart';


class ItemPhotoUseCase {
  ItemPhotoUseCase(this.repository);

  final ItemRepository repository;

  Future<Either<Failure, Map<String, dynamic>>> updateItemPhoto(FormParams? params) async {
    return await repository.updateItemPhoto(params);
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteItemPhoto(PathParams? params) async {
    return await repository.deleteItemPhoto(params);
  }
}

class FormParams extends Equatable{
  const FormParams(this.data);

  final FormData data;
  @override
  List<Object> get props => [data];
}