import '../../hive-data/hive-model/NoteModel.dart';

class NoteDao {
  String id = "";
  late String content;
  late String createdDateTime;
  late String modifiedDateTime;

  NoteDao({required this.id, required this.content, required this.createdDateTime, required this.modifiedDateTime});

  factory NoteDao.fromHiveModel(NoteModel model) {
    return NoteDao(
        id: model.id,
        content: model.content,
        createdDateTime: model.createdDateTime,
        modifiedDateTime: model.modifiedDateTime,
    );
  }
}