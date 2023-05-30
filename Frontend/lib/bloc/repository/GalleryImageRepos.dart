import 'package:http/http.dart';

abstract class AbstractGalleryImageRepos {
  Future<Response> getGalleryImages();
}

class GalleryImageRepos implements AbstractGalleryImageRepos {
  final String apiUrl = "http://192.168.1.2:9021/api/gallery";
  final String apiKey = const String.fromEnvironment('SPRING_API_KEY');

  @override
  Future<Response> getGalleryImages() async {
    var header = {"spring-api-key" : apiKey};
    var url = "$apiUrl/get-image-list";
    Response response = await get(
        Uri.parse(url),
        headers: header
    );
    return response;
  }
}