import 'package:raya_violation/models/base_entity.dart';

class BaseResponse<T> {
  T? data;
  int? statusCode;
  String? errorMessage;

  BaseResponse({this.data, this.statusCode, this.errorMessage});
}
