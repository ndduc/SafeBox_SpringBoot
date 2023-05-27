import 'dart:convert';

import 'package:http/http.dart';

import '../../model/dao/SafeBoxDao.dart';

abstract class AbstractSafeBoxRepos {
  Future<Response> getSafeBoxRecord(String searchText, String option);
  Future<void> saveSafeBoxRecord(SafeBoxDao data);
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
    print(response.body);
    return response;
  }

  Future<void> saveSafeBoxRecord(SafeBoxDao data) async {
    var header = {
      "spring-api-key" : apiKey,
      "Content-Type" : "application/json"
    };
    var url = "$apiUrl/add-update-safebox";
    var body = jsonEncode(data.toJson());
    try {
      var response = await post(Uri.parse(url), headers: header, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('POST request successful');
        print('Response body: ${response.body}');
      } else {
        print('POST request failed');
        print('Response status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}