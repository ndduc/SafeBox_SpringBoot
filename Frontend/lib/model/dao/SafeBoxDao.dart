class SafeBoxDao {
  late String hashKey;
  late String rangeKey;
  late String createdDatetime;
  late String id;
  late String location;
  late String modifiedDatetime;
  late String name;
  late String password;
  late String userName;
  late String website;

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
      required this.website});

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
      website: json['website']
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
      'website': website
    };
  }

}