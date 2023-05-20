abstract class SafeBoxEvent {}

class GetRecordsEvent extends SafeBoxEvent {
  final String location;
  GetRecordsEvent(this.location);
}

class UpdateSearchOptionEvent extends SafeBoxEvent {
  final String newOption;
  UpdateSearchOptionEvent(this.newOption);
}