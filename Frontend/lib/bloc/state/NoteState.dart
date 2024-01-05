import 'package:safebox/model/dao/NoteDao.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}
class NoteLoading extends NoteState {}
class NoteError extends NoteState {
  final String errorMessage;
  NoteError({required this.errorMessage});
}


class SaveNoteLoaded extends NoteState {

}

class GetNoteLoaded extends NoteState {
  final NoteDao note;
  GetNoteLoaded({required this.note});
}

class GetNotesLoaded extends NoteState {
  final List<NoteDao> notes;
  GetNotesLoaded({required this.notes});
}

class DeleteNoteLoaded extends NoteState {
  DeleteNoteLoaded();
}

class NavToNoteLoaded extends NoteState {
  NavToNoteLoaded();
}