import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:http/http.dart';

import '../../model/api/ApiResponse.dart';
import '../../model/api/SafeBoxResponse.dart';
import '../../ui/safebox/SafeBox.dart';
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
    on<DeleteSafeBoxRecordHiveErrorEvent>(deleteSafeBoxRecordHiveErrorEvent);
    on<SaveNewSafeBoxRecordForHiveEvent>(saveNewSafeBoxRecordForHiveEvent);
    on<NavToSafeBoxEvent>(navToSafeBoxEvent);
  }

  AbstractSafeBoxRepos safeBoxRepos = SafeBoxRepos();

  void navToSafeBoxEvent(NavToSafeBoxEvent event, Emitter<SafeBoxState> emit) {
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => const SafeBox()),
    );
  }

  void saveNewSafeBoxRecordForHiveEvent(SaveNewSafeBoxRecordForHiveEvent event, Emitter<SafeBoxState> emit) {
    try {
      emit(SafeBoxLoading());
      safeBoxRepos.saveNewSafeBoxRecordForHive(event.data);
      emit(SaveNewSafeBoxRecordForHiveLoaded());
    } catch(e) {
      emit(SaveNewSafeBoxRecordForHiveError(errorMessage: e.toString()));
    }
  }

  void deleteSafeBoxRecordHiveErrorEvent(DeleteSafeBoxRecordHiveErrorEvent event, Emitter<SafeBoxState> emit) {
    try {
      emit(SafeBoxLoading());
      safeBoxRepos.deleteSafeBoxRecordHive(event.name, event.location, event.id);
      emit(SafeBoxDeleteSafeBoxRecordHiveLoaded(deleteIndex: event.deletedIndex));
    }catch(e) {
      emit(SafeBoxDeleteSafeBoxRecordHiveError(errorMessage: e.toString()));
    }
  }

  void getSpecificSafeBoxRecordHiveByIdEvent(GetSpecificSafeBoxRecordHiveByIdEvent event, Emitter<SafeBoxState> emit) {
    try {
      emit(SafeBoxLoading());
      var result = safeBoxRepos.getSpecificSafeBoxRecordHiveById(event.name, event.location, event.id);
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