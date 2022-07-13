import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_images/data/entity/profile_image.dart';

part 'user_public_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPublicProfile {
  String id;
  String username;
  String name;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'profile_image')
  ProfileImage profileImage;
  String? bio;
  @JsonKey(name: 'total_likes')
  int totalLikes;
  @JsonKey(name: 'total_photos')
  int totalPhotos;

  UserPublicProfile({
    required this.id,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.bio,
    required this.totalLikes,
    required this.totalPhotos,
  });

  factory UserPublicProfile.fromJson(Map<String, dynamic> json) =>
      _$UserPublicProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserPublicProfileToJson(this);
}
