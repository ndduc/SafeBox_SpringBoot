import 'package:hive/hive.dart';
part 'SafeBoxModel.g.dart';
@HiveType(typeId: 0)
class SafeBoxModel extends HiveObject {

  // Key for dynamoDB migration
  @HiveField(0)
  String hashKey;
  @HiveField(1)
  String rangeKey;
  @HiveField(2)
  String gsiHk1;
  @HiveField(3)
  String gsiHk2;
  @HiveField(4)
  String gsiRk1;
  @HiveField(5)
  String gsiRk2;


  @HiveField(6)
  String? location;
  @HiveField(7)
  String? name;
  @HiveField(8)
  String password;
  @HiveField(9)
  String userName;
  @HiveField(10)
  String? website;

  @HiveField(11)
  String createdDateTime;
  @HiveField(12)
  String modifiedDateTime;

  @HiveField(13)
  String id;  // auto generate

  @HiveField(14)
  String? note;



  SafeBoxModel({
    required this.userName, required this.password, required this.createdDateTime,
    required this.modifiedDateTime, required this.hashKey,
    required this.rangeKey, required this.gsiHk1, required
    this.gsiHk2, required this.gsiRk1, required this.gsiRk2, required this.id});

  @override
  String toString() {
    return 'SafeBoxModel('
        'hashKey: $hashKey, '
        'rangeKey: $rangeKey, '
        'gsiHk1: $gsiHk1, '
        'gsiHk2: $gsiHk2, '
        'gsiRk1: $gsiRk1, '
        'gsiRk2: $gsiRk2, '
        'location: $location, '
        'name: $name, '
        'password: $password, '
        'userName: $userName, '
        'website: $website, '
        'createdDateTime: $createdDateTime, '
        'modifiedDateTime: $modifiedDateTime, '
        'id: $id)';
  }
}