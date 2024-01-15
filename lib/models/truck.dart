import 'base_entity.dart';

class Truck extends BaseEntity {
  String plateNumber;

  Truck.init(int id, {required this.plateNumber}):super.init(id: id);

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck.init(json['id'], plateNumber: json['plateNumber']);
  }
}