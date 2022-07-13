// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      totalPhotos: json['total_photos'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      previewPhotos: (json['preview_photos'] as List<dynamic>)
          .map((e) => PreviewPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'total_photos': instance.totalPhotos,
      'user': instance.user.toJson(),
      'preview_photos': instance.previewPhotos.map((e) => e.toJson()).toList(),
    };
