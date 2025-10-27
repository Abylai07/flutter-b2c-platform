import 'package:dartz/dartz.dart';

import '../platform/network_info.dart';
import 'error/exception.dart';
import 'error/failure.dart';


class NetworkOperationHelper {
  final NetworkInfo networkInfo;

  NetworkOperationHelper(this.networkInfo);

  Future<Either<Failure, T>> performNetworkOperation<T>(
      Future<T> Function() operation) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await operation();
        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.messageError));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.messageError));
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
