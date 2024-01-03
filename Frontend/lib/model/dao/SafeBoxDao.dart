import '../../hive-data/hive-model/SafeBoxModel.dart';

class SafeBoxDao {
  String hashKey = "";
  String rangeKey = "";
  String createdDatetime = "";
  String id = "";
  late String location;
  String modifiedDatetime = "";
  late String name;
  late String password;
  late String userName;
  late String website;
  late String note;

  SafeBoxDao({
      required this.hashKey,
      required this.rangeKey,
      required this.createdDatetime,
      required this.id,
      required this.location,
      required this.modifiedDatetime,
      required this.name,
      required this.password,
      required this.userName,
      required this.website,
      required this.note});

  SafeBoxDao.newRecord({
    required this.location,
    required this.name,
    required this.password,
    required this.userName,
    required this.website,
    required this.note});

  factory SafeBoxDao.fromJson(Map<String, dynamic> json) {
    return SafeBoxDao(
      hashKey: json['hashKey'],
      rangeKey: json['rangeKey'],
      createdDatetime: json['createdDatetime'],
      id: json['id'],
      location: json['location'],
      modifiedDatetime:json['modifiedDatetime'],
      name: json['name'],
      password: json['password'],
      userName: json['userName'],
      website: json['website'],
      note: json['note']
    );
  }

  factory SafeBoxDao.fromHiveModel(SafeBoxModel model) {
    return SafeBoxDao(
        hashKey: model.hashKey,
        rangeKey: model.rangeKey,
        createdDatetime: model.createdDateTime,
        id: model.id,
        location: model.location!,
        modifiedDatetime: model.modifiedDateTime,
        name: model.name!,
        password: model.password,
        userName: model.userName,
        website: model.website!,
        note: model.note ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hashKey': hashKey,
      'rangeKey': rangeKey,
      'createdDatetime': createdDatetime,
      'id': id,
      'location': location,
      'modifiedDatetime': modifiedDatetime,
      'name': name,
      'password': password,
      'userName': userName,
      'website': website,
      'note': note
    };
  }

}