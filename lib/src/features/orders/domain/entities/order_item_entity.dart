import 'package:equatable/equatable.dart';


class PaginationOrderEntity extends Equatable{
  final bool isLast;
  final List<OrderItemEntity> itemEntity;

  const PaginationOrderEntity({
    required this.isLast,
    required this.itemEntity,
  });

  @override
  List<Object?> get props => [isLast, itemEntity];

}

class OrderItemEntity extends Equatable {
  final int id;
  final String title;
  final String status;
  final DateTime created;
  final double price;

  const OrderItemEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.created,
    required this.price,
  });

  @override
  List<Object?> get props => [id, title, status, created, price];
}
