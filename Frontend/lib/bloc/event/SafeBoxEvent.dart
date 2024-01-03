import 'package:safebox/hive-data/hive-model/SafeBoxModel.dart';
import 'package:safebox/model/dao/SafeBoxDao.dart';

abstract class SafeBoxEvent {}

class GetRecordsEvent extends SafeBoxEvent {
  final String searchText;
  final String searchOption;
  GetRecordsEvent(this.searchText, this.searchOption);
}

class SaveRecordEvent extends SafeBoxEvent {
  final SafeBoxDao data;
  SaveRecordEvent(this.data);
}

class DeleteRecordEvent extends SafeBoxEvent {
  final SafeBoxDao data;
  DeleteRecordEvent(this.data);
}

class UpdateSearchOptionEvent extends SafeBoxEvent {
  final String newOption;
  UpdateSearchOptionEvent(this.newOption);
}

class HideUnHidePasswordEvent extends SafeBoxEvent {
  bool hide = true;
  final int index;
  HideUnHidePasswordEvent(this.index, this.hide);
}

class HideUnHidePasswordEventSingleField extends SafeBoxEvent {
  bool hide = true;
  HideUnHidePasswordEventSingleField(this.hide);
}

class GetSpecificSafeBoxRecordHiveByIdEvent extends SafeBoxEvent {
  final String name;
  final String location;
  final String id;
  GetSpecificSafeBoxRecordHiveByIdEvent({required this.name, required this.location, required this.id});
}