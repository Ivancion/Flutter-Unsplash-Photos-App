import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/user.dart';

part 'search_user_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchUserResponse {
  List<User> results;

  SearchUserResponse({required this.results});

  factory SearchUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserResponseToJson(this);
}
