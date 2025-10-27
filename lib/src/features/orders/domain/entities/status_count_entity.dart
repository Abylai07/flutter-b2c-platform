import 'package:equatable/equatable.dart';

class StatusCountEntity extends Equatable {
  final int newCount;
  final int acceptedCount;
  final int inProgressCount;
  final int closedCount;

  const StatusCountEntity({
    required this.newCount,
    required this.acceptedCount,
    required this.inProgressCount,
    required this.closedCount,
  });

  @override
  List<Object> get props => [newCount, acceptedCount, inProgressCount, closedCount];
}
