import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/profile_image.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String id;
  String username;
  String? name;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'profile_image')
  ProfileImage profileImage;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.firstName,
    this.lastName,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
