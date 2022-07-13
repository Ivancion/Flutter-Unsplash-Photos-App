import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/preview_photo.dart';
import 'package:unsplash_images/data/entity/user.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  String id;
  String title;
  String? description;
  @JsonKey(name: 'total_photos')
  int totalPhotos;
  User user;
  @JsonKey(name: 'preview_photos')
  List<PreviewPhoto> previewPhotos;

  Collection({
    required this.id,
    required this.title,
    this.description,
    required this.totalPhotos,
    required this.user,
    required this.previewPhotos,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
