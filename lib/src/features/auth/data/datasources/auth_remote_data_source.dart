import 'package:dio/dio.dart';
import 'package:b2c_platform/src/common/api.dart';
import 'package:b2c_platform/src/common/constants.dart' as constants;
import 'package:b2c_platform/src/core/error/exception.dart';
import 'package:b2c_platform/src/features/auth/domain/entities/auth_entity.dart';
import 'package:b2c_platform/src/features/user/domain/entities/user_entity.dart';
import 'package:b2c_platform/src/features/auth/data/models/auth_model.dart';
import 'package:b2c_platform/src/features/user/data/models/user_info_model.dart';

// Import MapParams from where it's defined
import 'package:b2c_platform/src/features/auth/domain/usecases/sign_in_usecase.dart';

abstract class AuthRemoteDataSource {
  Future<AuthEntity> signIn(MapParams params);

  Future<Map<String, dynamic>> signUpOtp(MapParams params);

  Future<AuthEntity> signUpCode(MapParams params);

  Future<UserEntity> signUpData(MapParams params);

  Future<Map<String, dynamic>> signUpPassword(MapParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final API api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<AuthEntity> signIn(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/api/token/',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> signUpOtp(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/otp/',
        data: params.data,
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
  Future<AuthEntity> signUpCode(MapParams params) async {
    try {
      final response = await api.dio.post(
        '${constants.host}user/verify/',
        data: params.data,
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      return api.handleDioException(e);
    }
  }

  @override
  Future<UserEntity> signUpData(MapParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}user/register/',
        data: params.data,
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
  Future<Map<String, dynamic>> signUpPassword(MapParams params) async {
    try {
      final response = await api.dio.put(
        '${constants.host}user/set-password/',
        data: params.data,
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
}