import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/photo.dart';

part 'search_photo_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchPhotoResponse {
  List<Photo> results;

  SearchPhotoResponse({required this.results});

  factory SearchPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPhotoResponseToJson(this);
}
