import '../../hive-data/hive-model/NoteModel.dart';

class NoteDao {
  String id = "";
  String content = "";
  String createdDateTime = "";
  String modifiedDateTime = "";

  NoteDao({required this.id, required this.content, required this.createdDateTime, required this.modifiedDateTime});

  NoteDao.newRecord({required this.content});

  factory NoteDao.fromHiveModel(NoteModel model) {
    return NoteDao(
        id: model.id,
        content: model.content,
        createdDateTime: model.createdDateTime,
        modifiedDateTime: model.modifiedDateTime,
    );
  }
}