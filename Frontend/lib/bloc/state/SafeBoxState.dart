import '../../model/api/SafeBoxResponse.dart';

abstract class SafeBoxState {}

class SafeBoxInitial extends SafeBoxState {}
class SafeBoxLoading extends SafeBoxState {}
class SafeBoxLoaded extends SafeBoxState {
  final SafeBoxResponse data;
  SafeBoxLoaded({required this.data});
}
class SafeBoxPostLoaded extends SafeBoxState {
  final String status;
  SafeBoxPostLoaded({required this.status});
}
class SafeBoxErrorState extends SafeBoxState {
  final String errorMessage;
  SafeBoxErrorState({required this.errorMessage});
}


// Dropdown for Search Option State
class SafeBoxSearchOptionUpdateState extends SafeBoxState {
  final String selectedOption;
  SafeBoxSearchOptionUpdateState(this.selectedOption);
}

// hide for pasword State
class SafeBoxHideUnHidePasswordState extends SafeBoxState {
  bool hide = true;
  final int index;
  SafeBoxHideUnHidePasswordState(this.index, this.hide);
}