import 'package:dio/dio.dart';
import 'package:b2c_platform/src/common/api.dart';
import 'package:b2c_platform/src/common/constants.dart' as constants;
import 'package:b2c_platform/src/core/error/exception.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/city_entity.dart';
import 'package:b2c_platform/src/features/user/data/models/user_info_model.dart';
import 'package:b2c_platform/src/features/user/data/models/city_model.dart';

// Import FormParams
import 'package:b2c_platform/src/features/items/domain/usecases/item_photo_usecase.dart';

abstract class UserRemoteDataSource {
  Future<UserEntity> fetchUserInfo();

  Future<List<CityEntity>> fetchCityList();

  Future<Map<String, dynamic>> deleteMe();

  Future<Map<String, dynamic>> logout();

  Future<Map<String, dynamic>> updateUserImage(FormParams params);

  Future<Map<String, dynamic>> removeUserImage();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final API api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<UserEntity> fetchUserInfo() async {
    try {
      final response = await api.dio.get(
        '${constants.host}user/me/',
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<List<CityEntity>> fetchCityList() async {
    try {
      final response = await api.dio.get(
        '${constants.host}user/city-list/',
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => CityModel.fromJson(e))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> deleteMe() async {
    try {
      final response = await api.dio.delete(
        '${constants.host}user/delete-me/',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/logout/',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> removeUserImage() async {
    try {
      final response = await api.dio.delete(
        '${constants.host}user/remove-user-image/',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateUserImage(FormParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}user/update-user-image/',
        data: params.data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }
}
