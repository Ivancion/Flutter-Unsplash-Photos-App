// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewPhoto _$PreviewPhotoFromJson(Map<String, dynamic> json) => PreviewPhoto(
      id: json['id'] as String,
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreviewPhotoToJson(PreviewPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
    };
