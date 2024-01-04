abstract class NoteState {}

class NoteInitial extends NoteState {}
class NoteLoading extends NoteState {}
class NoteError extends NoteState {
  final String errorMessage;
  NoteError({required this.errorMessage});
}