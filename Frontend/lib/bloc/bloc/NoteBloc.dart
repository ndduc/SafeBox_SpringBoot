import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safebox/bloc/event/NoteEvent.dart';
import 'package:safebox/bloc/repository/NoteRepos.dart';
import 'package:safebox/bloc/state/NoteState.dart';
import 'package:safebox/model/dao/NoteDao.dart';
import 'package:safebox/ui/note/Note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc(): super(NoteInitial()) {
    on<SaveNoteEvent>(saveNoteEvent);
    on<GetNotesEvent>(getNotesEvent);
    on<GetNoteEvent>(getNoteEvent);
    on<DeleteNoteEvent>(deleteNoteEvent);
    on<NavToNoteEvent>(navToNoteEvent);
  }
  
  AbstractNoteRepos noteRepos = NoteRepos();

  void navToNoteEvent(NavToNoteEvent event, Emitter<NoteState> emitter) {
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => const Note()),
    );
  }

  void deleteNoteEvent(DeleteNoteEvent event, Emitter<NoteState> emitter) {
    try {
      emit(NoteLoading());
      noteRepos.deleteNoteForHive(event.id);
      emit(DeleteNoteLoaded());
    } catch (e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }

  void saveNoteEvent(SaveNoteEvent event, Emitter<NoteState> emitter) {
    try {
      emit(NoteLoading());
      noteRepos.saveNoteForHive(event.note);
      emit(SaveNoteLoaded());
    } catch (e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }

  void getNotesEvent(GetNotesEvent event, Emitter<NoteState> emitter) {
    try {
      emit(NoteLoading());
      List<NoteDao> daos = noteRepos.getNotesForHive();
      emit(GetNotesLoaded(notes: daos));
    } catch(e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }

  void getNoteEvent(GetNoteEvent event, Emitter<NoteState> emitter) {
    try {
      emit(NoteLoading());
      NoteDao dao = noteRepos.getNoteForHive(event.id);
      emit(GetNoteLoaded(note: dao));
    } catch(e) {
      emit(NoteError(errorMessage: e.toString()));
    }
  }
}