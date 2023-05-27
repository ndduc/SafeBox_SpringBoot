import 'dart:convert';

import 'package:http/http.dart';

import '../../model/dao/SafeBoxDao.dart';

abstract class AbstractSafeBoxRepos {
  Future<Response> getSafeBoxRecord(String searchText, String option);
  Future<Response> saveSafeBoxRecord(SafeBoxDao data);
  Future<Response> deleteSafeBoxRecord(SafeBoxDao data);
}

class SafeBoxRepos implements AbstractSafeBoxRepos {
  final String apiUrl = "http://192.168.1.2:9021/api/safebox";
  final String apiKey = "Gg63DfuAqMh_Zo8TINm7lXKMdy2FRzIiCV8FjYYdJBM";

  @override
  Future<Response> getSafeBoxRecord(String searchText, String option) async {
    var header = {"spring-api-key" : apiKey};
    var url = "$apiUrl/search-location?l=$searchText&m=$option&s=desc";
    Response response = await get(
        Uri.parse(url),
        headers: header
    );
    return response;
  }

  @override
  Future<Response> saveSafeBoxRecord(SafeBoxDao data) async {
    var header = {
      "spring-api-key" : apiKey,
      "Content-Type" : "application/json"
    };
    var url = "$apiUrl/add-update-safebox";
    var body = jsonEncode(data.toJson());
    Response response = await post(Uri.parse(url), headers: header, body: body);
    return response;
  }

  @override
  Future<Response> deleteSafeBoxRecord(SafeBoxDao data) async {
    var header = {
      "spring-api-key" : apiKey,
      "Content-Type" : "application/json"
    };
    var url = "$apiUrl/delete-safebox";
    var body = jsonEncode(data.toJson());
    Response response = await post(Uri.parse(url), headers: header, body: body);
    return response;
  }
}