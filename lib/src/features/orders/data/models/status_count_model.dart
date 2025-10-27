import '../../../domain/entity/order/status_count_entity.dart';

class StatusCountModel extends StatusCountEntity {
  const StatusCountModel({
    required super.newCount,
    required super.acceptedCount,
    required super.inProgressCount,
    required super.closedCount,
  });

  factory StatusCountModel.fromJson(Map<String, dynamic> json) {
    return StatusCountModel(
      newCount: json['new'],
      acceptedCount: json['accepted'],
      inProgressCount: json['in_progress'],
      closedCount: json['closed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'new': newCount,
      'accepted': acceptedCount,
      'in_progress': inProgressCount,
      'closed': closedCount,
    };
  }
}
