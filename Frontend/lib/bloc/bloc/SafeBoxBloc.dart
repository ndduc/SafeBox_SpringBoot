import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:safebox/bloc/event/SafeBoxEvent.dart';
import 'package:safebox/bloc/state/SafeBoxState.dart';
import 'package:http/http.dart';

import '../../model/api/ApiResponse.dart';
import '../../model/api/SafeBoxResponse.dart';

class SafeBoxBloc extends Bloc<SafeBoxEvent, SafeBoxState> {
  final String apiUrl = "http://192.168.1.2:8080/api/safebox";
  final String apiKey = "Gg63DfuAqMh_Zo8TINm7lXKMdy2FRzIiCV8FjYYdJBM";
  SafeBoxBloc() : super(SafeBoxInitial()) {
    on<GetRecordsEvent>(getSafeBoxRecordEvent);
    on<UpdateSearchOptionEvent>(updateSearchOptionEvent);
  }

  Future<void> getSafeBoxRecordEvent(GetRecordsEvent event, Emitter<SafeBoxState> emit) async {
    try {
      emit(SafeBoxLoading());
      var res = await getSafeBoxRecord(event.location);
      if (res.statusCode == 200) {
        SafeBoxResponse apiResponse = SafeBoxResponse.fromJson(jsonDecode(res.body));
        emit(SafeBoxLoaded(data: apiResponse));
      } else {
        emit(SafeBoxErrorState(errorMessage: "Error While Getting Records"));
      }
    } catch (e) {
      emit(SafeBoxErrorState(errorMessage: "Error While Getting Records"));
    }
  }

  void updateSearchOptionEvent(UpdateSearchOptionEvent event, Emitter<SafeBoxState> emit) {
    emit(SafeBoxSearchOptionUpdateState(event.newOption));
  }


  Future<Response> getSafeBoxRecord(String location) async {
    var header = {"spring-api-key" : apiKey};
    var url = "$apiUrl/search-location?l=$location&m=location&s=desc";
    Response response = await get(
        Uri.parse(url),
        headers: header
    );
    print(response.body);
    return response;
  }
}