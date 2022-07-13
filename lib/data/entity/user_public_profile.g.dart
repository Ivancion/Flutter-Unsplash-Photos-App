// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_public_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPublicProfile _$UserPublicProfileFromJson(Map<String, dynamic> json) =>
    UserPublicProfile(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImage:
          ProfileImage.fromJson(json['profile_image'] as Map<String, dynamic>),
      bio: json['bio'] as String?,
      totalLikes: json['total_likes'] as int,
      totalPhotos: json['total_photos'] as int,
    );

Map<String, dynamic> _$UserPublicProfileToJson(UserPublicProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'profile_image': instance.profileImage.toJson(),
      'bio': instance.bio,
      'total_likes': instance.totalLikes,
      'total_photos': instance.totalPhotos,
    };
