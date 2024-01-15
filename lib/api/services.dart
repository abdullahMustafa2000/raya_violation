import 'dart:convert';
import 'package:raya_violation/models/base_entity.dart';
import 'package:raya_violation/models/driver.dart';
import 'package:raya_violation/models/enums/entity_type.dart';
import 'package:raya_violation/models/truck.dart';
import 'package:raya_violation/models/violation.dart';
import 'base_response.dart';
import 'package:http/http.dart' as http;

class Services {
  static String baseUrl = "";

  Future<BaseResponse<BaseEntity>> baseEntityRequest(
      String url, EntityType type, {Map<String, String>? headers}) async {
    return await http
        .get(Uri.http('$baseUrl$url'), headers: headers)
        .then((response) {
      return BaseResponse(
          data: _getEntity(jsonDecode(response.body), type),
          statusCode: response.statusCode);
    });
  }

  Future<BaseResponse<List<BaseEntity>>> baseListRequest(
      String url, EntityType type, {Map<String, String>? headers}) async {
    return await http
        .get(Uri.http('$baseUrl$url'), headers: headers)
        .then((response) {
      List<BaseEntity> list = [];
      var body = jsonDecode(response.body);
      for (var item in body) {
        list.add(_getEntity(item, type));
      }
      return BaseResponse(data: list, statusCode: response.statusCode);
    });
  }

  Future<BaseResponse<List<BaseEntity>>> getDrivers(String token) {
    return baseListRequest('', EntityType.driver);
  }

  Future<BaseResponse<List<BaseEntity>>> getTrucks(String token) {
    return baseListRequest('', EntityType.driver);
  }

  Future<BaseResponse<List<BaseEntity>>> getViolations(String token) {
    return baseListRequest('', EntityType.driver);
  }

  BaseEntity _getEntity(Map<String, dynamic> json, EntityType type) {
    switch (type) {
      case EntityType.truck:
        return Truck.fromJson(json);
      case EntityType.driver:
        return Driver.fromJson(json);
      case EntityType.violation:
        return Violation.fromJson(json);
    }
  }
}
