import 'package:safebox/model/api/ApiResponse.dart';
import 'package:safebox/model/dao/GalleryImageDao.dart';

class GalleryImageResponse extends ApiResponse {
  @override
  final List<GalleryImageDao> dataObject;
  @override
  final List<String> errors;

  GalleryImageResponse({
    required this.dataObject,
    required this.errors,
  }) : super(dataObject, errors);

  factory GalleryImageResponse.fromJson(Map<String, dynamic> json) {
    return GalleryImageResponse(
      dataObject: (json['dataObject'] as List<dynamic>)
          .map((item) => GalleryImageDao.fromJson(item))
          .toList(),
      errors: (json['errors'] as List<dynamic>).cast<String>(),
    );
  }
}