import '../../model/api/SafeBoxResponse.dart';

abstract class SafeBoxState {}

class SafeBoxInitial extends SafeBoxState {}
class SafeBoxLoading extends SafeBoxState {}
class SafeBoxLoaded extends SafeBoxState {
  final SafeBoxResponse data;
  SafeBoxLoaded({required this.data});
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