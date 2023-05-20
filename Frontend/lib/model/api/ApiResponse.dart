import '../dao/SafeBoxDao.dart';

class ApiResponse<T> {
  late List<T> dataObject;
  late List<String> errors;

  ApiResponse(this.dataObject, this.errors);
}