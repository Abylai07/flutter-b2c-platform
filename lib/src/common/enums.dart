import 'package:flutter/cupertino.dart';

/// Cubit statuses initial success error loading
enum CubitStatus { initial, success, error, loading}

extension CubitStatusX on CubitStatus {
  bool get isInitial => this == CubitStatus.initial;
  bool get isSuccess => this == CubitStatus.success;
  bool get isError => this == CubitStatus.error;
  bool get isLoading => this == CubitStatus.loading;
}


extension SizedBoxExtension on int {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}

extension BorderRadiusExtension on int {
  BorderRadius get r => BorderRadius.circular(toDouble());
}