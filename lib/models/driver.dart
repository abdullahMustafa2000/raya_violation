import 'package:raya_violation/models/base_entity.dart';

class Driver extends BaseEntity {
  String name;

  Driver.init(int id, {required this.name}):super.init(id: id);

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver.init(json['id'], name: json['name']);
  }
}