import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/collection.dart';

part 'search_collection_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchCollectionResponse {
  List<Collection> results;

  SearchCollectionResponse({required this.results});

  factory SearchCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCollectionResponseToJson(this);
}
