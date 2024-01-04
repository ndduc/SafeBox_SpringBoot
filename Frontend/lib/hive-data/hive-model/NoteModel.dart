import 'package:hive/hive.dart';
part 'NoteModel.g.dart';
@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String content;
  @HiveField(2)
  String createdDateTime;
  @HiveField(3)
  String modifiedDateTime;


  NoteModel({required this.id, required this.content, required this.createdDateTime, required this.modifiedDateTime});

  @override
  String toString() {
    return 'NoteModel('
        'id: $id, '
        'content: $content, '
        'createdDateTime: $createdDateTime, '
        'modifiedDateTime: $modifiedDateTime, '
        'id: $id)';
  }
}