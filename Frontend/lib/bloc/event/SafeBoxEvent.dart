abstract class SafeBoxEvent {}

class GetRecordsEvent extends SafeBoxEvent {
  final String searchText;
  final String searchOption;

  GetRecordsEvent(this.searchText, this.searchOption);
}

class UpdateSearchOptionEvent extends SafeBoxEvent {
  final String newOption;
  UpdateSearchOptionEvent(this.newOption);
}