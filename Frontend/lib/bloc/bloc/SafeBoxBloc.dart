import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:http/http.dart';

import '../../model/api/ApiResponse.dart';
import '../../model/api/SafeBoxResponse.dart';
import '../repository/SafeBoxRepos.dart';

class SafeBoxBloc extends Bloc<SafeBoxEvent, SafeBoxState> {
  SafeBoxBloc() : super(SafeBoxInitial()) {
    on<GetRecordsEvent>(getSafeBoxRecordEvent);
    on<UpdateSearchOptionEvent>(updateSearchOptionEvent);
    on<SaveRecordEvent>(saveSafeBoxRecordEvent);
    on<DeleteRecordEvent>(deleteSafeBoxRecordEvent);
    on<HideUnHidePasswordEvent>(hideUnHidePasswordEvent);
  }

  AbstractSafeBoxRepos safeBoxRepos = SafeBoxRepos();

  Future<void> getSafeBoxRecordEvent(GetRecordsEvent event, Emitter<SafeBoxState> emit) async {
    try {
      emit(SafeBoxLoading());
      var res = await safeBoxRepos.getSafeBoxRecord(event.searchText, event.searchOption);
      if (res.statusCode == 200) {
        SafeBoxResponse apiResponse = SafeBoxResponse.fromJson(jsonDecode(res.body));
        emit(SafeBoxLoaded(data: apiResponse));
      }
      else {
        emit(SafeBoxErrorState(errorMessage: "Error While Getting Records"));
      }
    } catch (e) {
      emit(SafeBoxErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> saveSafeBoxRecordEvent(SaveRecordEvent event, Emitter<SafeBoxState> emit) async {
    try {
      emit(SafeBoxLoading());
      var result = await safeBoxRepos.saveSafeBoxRecord(event.data);
      if (result.statusCode == 200 || result.statusCode == 201) {
        emit(SafeBoxPostLoaded(status: 'OK'));
      }
      else {
        emit(SafeBoxErrorState(errorMessage: "Error While Saving Records"));
      }
    } catch (e) {
      emit(SafeBoxErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteSafeBoxRecordEvent(DeleteRecordEvent event, Emitter<SafeBoxState> emit) async {
    try {
      emit(SafeBoxLoading());
      var result = await safeBoxRepos.deleteSafeBoxRecord(event.data);
      if (result.statusCode == 200 || result.statusCode == 201) {
        emit(SafeBoxPostLoaded(status: 'OK'));
      }
      else {
        emit(SafeBoxErrorState(errorMessage: "Error While Deleting Records"));
      }
    } catch (e) {
      emit(SafeBoxErrorState(errorMessage: e.toString()));
    }
  }

  void updateSearchOptionEvent(UpdateSearchOptionEvent event, Emitter<SafeBoxState> emit) {
    emit(SafeBoxSearchOptionUpdateState(event.newOption));
  }

  void hideUnHidePasswordEvent(HideUnHidePasswordEvent event, Emitter<SafeBoxState> emit) {
    emit(SafeBoxHideUnHidePasswordState(event.index, event.hide));
  }


}