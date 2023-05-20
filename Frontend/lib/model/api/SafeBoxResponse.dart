import 'package:safebox/model/api/ApiResponse.dart';
import 'package:safebox/model/dao/SafeBoxDao.dart';

class SafeBoxResponse extends ApiResponse {

  @override
  final List<SafeBoxDao> dataObject;
  @override
  final List<String> errors;

  SafeBoxResponse({
    required this.dataObject,
    required this.errors,
  }) : super(dataObject, errors);

  factory SafeBoxResponse.fromJson(Map<String, dynamic> json) {
    return SafeBoxResponse(
      dataObject: (json['dataObject'] as List<dynamic>)
          .map((item) => SafeBoxDao.fromJson(item))
          .toList(),
      errors: (json['errors'] as List<dynamic>).cast<String>(),
    );
  }
}