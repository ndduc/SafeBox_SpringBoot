import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:safebox/hive-data/hive-model/SafeBoxModel.dart';
import 'package:safebox/ui/safebox/SafeBox.dart';
import 'package:uuid/uuid.dart';

import '../../model/dao/SafeBoxDao.dart';

abstract class AbstractSafeBoxRepos {
  Future<Response> getSafeBoxRecord(String searchText, String option);
  Future<Response> saveSafeBoxRecord(SafeBoxDao data);
  Future<Response> deleteSafeBoxRecord(SafeBoxDao data);
  List<SafeBoxDao> getSafeBoxRecordHive(String searchText, String option);
  SafeBoxDao getSpecificSafeBoxRecordHiveById(String name, String location, String id);
}

class SafeBoxRepos implements AbstractSafeBoxRepos {
  final String apiUrl = "http://54.241.148.142:9021/api/safebox";
  final String apiKey = const String.fromEnvironment('SPRING_API_KEY');

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

  SafeBoxDao getSpecificSafeBoxRecordHiveById(String name, String location, String id) {
    String rk = "$name-$location-$id";
    print(rk);
    SafeBoxModel? result =  Hive.box<SafeBoxModel>('safebox').get(rk);
    print(result.toString());

    return SafeBoxDao.fromHiveModel(result!);
  }

  List<SafeBoxDao> getSafeBoxRecordHive(String searchText, String option) {
    Iterable<SafeBoxModel> result;
    if (option.toUpperCase() == 'LOCATION') {
      result =  Hive.box<SafeBoxModel>('safebox').values.where((x) => x.location?.toLowerCase() == searchText.toLowerCase());
    } else if (option.toUpperCase() == 'USER') {
      result =  Hive.box<SafeBoxModel>('safebox').values.where((x) => x.userName.toLowerCase() == searchText.toLowerCase());
    } else {
      result =  Hive.box<SafeBoxModel>('safebox').values;
    }

    List<SafeBoxModel> lstResult = result.toList();
    return convertSafeBoxModelsToDaos(lstResult);
  }

  List<SafeBoxDao> convertSafeBoxModelsToDaos(List<SafeBoxModel> models) {
    List<SafeBoxDao> daos = [];

    for (var model in models) {
      print(model.toString());
      SafeBoxDao dao = SafeBoxDao(
        hashKey: model.hashKey,
        rangeKey: model.rangeKey,
        createdDatetime: model.createdDateTime,
        id: model.id ,
        location: model.location ?? "",
        modifiedDatetime: model.modifiedDateTime,
        name: model.name ?? "",
        password: model.password,
        userName: model.userName,
        website: model.website ?? "",
        note: model.note ?? ""
      );

      daos.add(dao);
    }

    return daos;
  }

  @override
  Future<Response> saveSafeBoxRecord(SafeBoxDao data) async {
    await saveNewSafeBoxRecordForHive(data);
    var header = {
      "spring-api-key" : apiKey,
      "Content-Type" : "application/json"
    };
    var url = "$apiUrl/add-update-safebox";
    var body = jsonEncode(data.toJson());
    Response response = await post(Uri.parse(url), headers: header, body: body);
    return response;
  }

  saveNewSafeBoxRecordForHive(SafeBoxDao data) async {
    var uuid = Uuid();
    String uniqueId = uuid.v4();
    String hk = "SAFEBOX-ENTITY";
    String rk = "${data.name}-${data.location}-$uniqueId";
    String gsi1Hk = "LOCATION";
    String gsi1Rk = data.location;
    String gsi2Hk = "NAME";
    String gsi2Rk = data.name;

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy hh:mm:ss a');
    final dateTime = formatter.format(now);

    SafeBoxModel safe = SafeBoxModel(
        userName: data.userName,
        password: data.password,
        createdDateTime: dateTime,
        modifiedDateTime: dateTime,
        hashKey: hk,
        rangeKey: rk,
        gsiHk1: gsi1Hk,
        gsiHk2: gsi2Hk ,
        gsiRk1: gsi1Rk,
        gsiRk2: gsi2Rk,
        id: uniqueId);

    safe.location = data.location;
    safe.name = data.name;
    safe.website = data.website;
    safe.note = data.note;
    await Hive.box<SafeBoxModel>('safebox').put(rk, safe);
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