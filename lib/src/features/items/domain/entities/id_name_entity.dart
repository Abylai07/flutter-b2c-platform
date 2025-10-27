import 'package:equatable/equatable.dart';

class IdNameEntity extends Equatable{
  final int id;
  final String name;
  final String? nameSingle;

  const IdNameEntity({required this.id, required this.name, this.nameSingle});

  @override
  List<Object?> get props => [id, name, nameSingle];
}