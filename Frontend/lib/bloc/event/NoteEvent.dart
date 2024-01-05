import 'package:flutter/cupertino.dart';
import 'package:safebox/model/dao/NoteDao.dart';

abstract class NoteEvent {}


class SaveNoteEvent extends NoteEvent {
  final NoteDao note;
  SaveNoteEvent(this.note);
}

class GetNoteEvent extends NoteEvent {
  final String id;
  GetNoteEvent(this.id);
}

class GetNotesEvent extends NoteEvent {
  GetNotesEvent();
}

class DeleteNoteEvent extends NoteEvent {
  final String id;
  DeleteNoteEvent(this.id);
}


class NavToNoteEvent extends NoteEvent {
  final BuildContext context;
  NavToNoteEvent(this.context);
}