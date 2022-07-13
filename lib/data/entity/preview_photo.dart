import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/urls.dart';

part 'preview_photo.g.dart';

@JsonSerializable()
class PreviewPhoto {
  String id;
  Urls urls;
  PreviewPhoto({
    required this.id,
    required this.urls,
  });

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) =>
      _$PreviewPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewPhotoToJson(this);
}
