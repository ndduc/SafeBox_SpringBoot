import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:safebox/hive-data/hive-model/NoteModel.dart';
import 'package:safebox/model/dao/NoteDao.dart';
import 'package:uuid/uuid.dart';

abstract class AbstractNoteRepos {
  void saveNoteForHive(NoteDao data);
  void deleteNoteForHive(String id);
  List<NoteDao> getNotesForHive();
  NoteDao getNoteForHive(String id);
}

class NoteRepos implements AbstractNoteRepos {

  @override
  void deleteNoteForHive(String id) {
    Hive.box<NoteModel>('note').delete(id);
  }

  @override
  void saveNoteForHive(NoteDao data) {
    var uuid = const Uuid();
    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy hh:mm:ss a');
    final dateTime = formatter.format(now);
    String uniqueId;
    if (data.id == null || (data.id != null && data.id.isEmpty)) {
      uniqueId = uuid.v4();
      data.modifiedDateTime = dateTime;
      data.createdDateTime = dateTime;
    } else {
      uniqueId = data.id;
      data.modifiedDateTime = dateTime;
    }

    NoteModel model = NoteModel(id: uniqueId,
        content: data.content,
        createdDateTime: data.createdDateTime,
        modifiedDateTime: data.modifiedDateTime
    );
    Hive.box<NoteModel>('note').put(uniqueId, model);
  }

  @override
  NoteDao getNoteForHive(String id) {
    NoteModel? result = Hive.box<NoteModel>("note").get(id);
    return NoteDao.fromHiveModel(result!);
  }

  @override
  List<NoteDao> getNotesForHive() {
    Iterable<NoteModel> result = Hive.box<NoteModel>("note").values;
    return convertNoteModelToDao(result.toList());
  }

  List<NoteDao> convertNoteModelToDao(List<NoteModel> models) {
    List<NoteDao> daos = [];
    for (var model in models) {
      NoteDao dao = NoteDao(id: model.id, content: model.content,
          createdDateTime: model.createdDateTime, modifiedDateTime: model.modifiedDateTime);
      daos.add(dao);
    }
    return daos;
  }
}