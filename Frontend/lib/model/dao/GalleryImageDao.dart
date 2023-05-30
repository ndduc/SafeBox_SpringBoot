class GalleryImageDao {
  final String key;
  final String fileName;
  final String contentType;
  final String extension;
  final String imageSource;

  GalleryImageDao(
      {
        required this.key,
        required this.fileName,
        required this.contentType,
        required this.extension,
        required this.imageSource
      }
    );

  factory GalleryImageDao.fromJson(Map<String, dynamic> json) {
    return GalleryImageDao(
        key: json['key'],
        fileName: json['fileName'],
        contentType: json['contentType'],
        extension: json['extension'],
        imageSource: json['imageSource']
    );
  }
}