import 'package:raya_violation/models/driver.dart';
import 'package:raya_violation/models/truck.dart';

import 'base_entity.dart';

class Violation extends BaseEntity {
  Truck truck;
  Driver driver;
  String violationDesc;
  DateTime dateTime;

  Violation.init(int id,
      {required this.violationDesc,
      required this.truck,
      required this.driver,
      required this.dateTime})
      : super.init(id: id);

  factory Violation.fromJson(Map<String, dynamic> json) {
    return Violation.init(
      json['id'],
      violationDesc: json['violationDesc'],
      truck: Truck.fromJson(json),
      driver: Driver.fromJson(json),
      dateTime: DateTime.parse(json['date']),
    );
  }
}
