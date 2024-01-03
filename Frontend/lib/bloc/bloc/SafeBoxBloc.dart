import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:http/http.dart';

import '../../model/api/ApiResponse.dart';
import '../../model/api/SafeBoxResponse.dart';
import '../event/SafeBoxEvent.dart';
import '../repository/SafeBoxRepos.dart';

class SafeBoxBloc extends Bloc<SafeBoxEvent, SafeBoxState> {
  SafeBoxBloc() : super(SafeBoxInitial()) {
    on<GetRecordsEvent>(getSafeBoxRecordEvent);
    on<UpdateSearchOptionEvent>(updateSearchOptionEvent);
    on<SaveRecordEvent>(saveSafeBoxRecordEvent);
    on<DeleteRecordEvent>(deleteSafeBoxRecordEvent);
    on<HideUnHidePasswordEvent>(hideUnHidePasswordEvent);
    on<HideUnHidePasswordEventSingleField>(hideUnHidePasswordEventPassword);
    on<GetSpecificSafeBoxRecordHiveByIdEvent>(getSpecificSafeBoxRecordHiveByIdEvent);
  }

  AbstractSafeBoxRepos safeBoxRepos = SafeBoxRepos();

  void getSpecificSafeBoxRecordHiveByIdEvent(GetSpecificSafeBoxRecordHiveByIdEvent event, Emitter<SafeBoxState> emit) {
    try {
      emit(SafeBoxLoading());
      print('printed 1');

      var result = safeBoxRepos.getSpecificSafeBoxRecordHiveById(event.name, event.location, event.id);
      print('printed 2');
      emit(SafeBoxGetSpecificSafeBoxRecordHiveByIdLoaded(result));
    } catch(e) {
      emit(SafeBoxGetSpecificSafeBoxRecordHiveByIdError(errorMessage: e.toString()));
    }
  }

  Future<void> getSafeBoxRecordEvent(GetRecordsEvent event, Emitter<SafeBoxState> emit) async {
    try {
      emit(SafeBoxLoading());
     // var res = await safeBoxRepos.getSafeBoxRecord(event.searchText, event.searchOption);
      var resHive = await safeBoxRepos.getSafeBoxRecordHive(event.searchText, event.searchOption);

      print("test");
      print(resHive);
      SafeBoxResponse apiResponse = SafeBoxResponse.fromHive(resHive);

      emit(SafeBoxLoaded(data: apiResponse));
      // if (res.statusCode == 200) {
      //   SafeBoxResponse apiResponse = SafeBoxResponse.fromJson(jsonDecode(res.body));
      //
      //   emit(SafeBoxLoaded(data: apiResponse));
      // }
      // else {
      //   emit(SafeBoxErrorState(errorMessage: "Error While Getting Records"));
      // }
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

  void hideUnHidePasswordEventPassword(HideUnHidePasswordEventSingleField event, Emitter<SafeBoxState> emit) {
    emit(SafeBoxHideUnHidePasswordStateSingleField(event.hide));
  }

}