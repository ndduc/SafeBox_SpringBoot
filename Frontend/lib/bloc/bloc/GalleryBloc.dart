import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:safebox/bloc/event/GalleryEvent.dart';
import 'package:safebox/bloc/state/GalleryState.dart';
import 'package:safebox/model/api/GalleryImageResponse.dart';

import '../repository/GalleryImageRepos.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(): super(GalleryInitial()) {
    on<GetGalleryImagesEvent>(getGalleryImagesEvent);
  }

  AbstractGalleryImageRepos galleryImageRepos = GalleryImageRepos();

  Future<void> getGalleryImagesEvent(GetGalleryImagesEvent event, Emitter<GalleryState> emit) async {
    try {
      emit(GalleryLoading());
      var res = await galleryImageRepos.getGalleryImages();
      if (res.statusCode == 200) {
        GalleryImageResponse apiResponse = GalleryImageResponse.fromJson(jsonDecode(res.body));
        emit(GalleryImagesLoaded(data: apiResponse));
      }
      else {
        emit(GalleryError(errorMessage: "Error While Getting Records"));
      }
    } catch (e) {
      emit(GalleryError(errorMessage: e.toString()));
    }
  }
}