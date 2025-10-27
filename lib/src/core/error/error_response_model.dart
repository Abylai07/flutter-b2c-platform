class ErrorResponseModel {
  int? status;
  String? message;
  int? timestamp;
  String? path;
  String? details;
  String? error;

  ErrorResponseModel({
    this.status,
    this.message,
    this.timestamp,
    this.path,
    this.details,
    this.error,
  });

  factory ErrorResponseModel.fromJson(dynamic data, {int? statusCode}) {
    Map<String, dynamic> json = {};

    if (data is Map) json = data as Map<String, dynamic>;
    if (data is String) return ErrorResponseModel(message: data, status: statusCode);

    return ErrorResponseModel(
      status: json['statusCode'] as int?,
      message: json['message'] as String?,
      path: json['path'] as String?,
      error: json['error'] as String?,
      details: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = status;
    data['message'] = message;
    data['timestamp'] = timestamp;
    data['error'] = error;
    data['path'] = path;
    if (details != null) {
      data['details'] = details;
    }
    return data;
  }
}

