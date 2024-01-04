import 'package:bloc/bloc.dart';
import 'package:safebox/bloc/event/NoteEvent.dart';
import 'package:safebox/bloc/state/NoteState.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc(): super(NoteInitial()) {

  }
}