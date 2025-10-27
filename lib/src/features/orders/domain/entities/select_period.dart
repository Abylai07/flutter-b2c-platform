import 'package:equatable/equatable.dart';
import 'package:b2c_platform/src/features/items/domain/entities/id_name_entity.dart';

class SelectPeriod extends Equatable{
  IdNameEntity period;
  String? price;

  SelectPeriod({required this.period, this.price});

  @override
  List<Object?> get props => [period, price];
}