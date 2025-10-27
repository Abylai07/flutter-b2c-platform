class ServerException implements Exception {
  ServerException({this.status, this.messageError});
  final String? messageError;
  final int? status;
}

class CacheException implements Exception {
  CacheException({this.messageError, this.status});

  final String? messageError;
  final int? status;
}
