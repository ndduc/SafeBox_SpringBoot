import 'package:bloc/bloc.dart';
import 'package:safebox/bloc/event/GalleryEvent.dart';
import 'package:safebox/bloc/state/GalleryState.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(): super(GalleryInitial()) {}
}