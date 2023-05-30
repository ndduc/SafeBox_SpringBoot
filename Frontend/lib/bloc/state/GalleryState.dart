import '../../model/api/GalleryImageResponse.dart';

abstract class GalleryState{}

class GalleryInitial extends GalleryState {}
class GalleryLoading extends GalleryState {}
class GalleryLoaded extends GalleryState {}
class GalleryError extends GalleryState {
  final String errorMessage;
  GalleryError({required this.errorMessage});
}



class GalleryImagesLoaded extends GalleryState {
  final GalleryImageResponse data;
  GalleryImagesLoaded({required this.data});
}
