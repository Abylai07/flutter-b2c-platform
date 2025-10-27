import '../../../domain/entity/order/order_item_entity.dart';



class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.title,
    required super.status,
    required super.created,
    required super.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      status: json['status'] as String,
      created: DateTime.parse(json['created'] as String),
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'created': created.toIso8601String(),
      'price': price,
    };
  }
}
