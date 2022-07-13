// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPhotoResponse _$SearchPhotoResponseFromJson(Map<String, dynamic> json) =>
    SearchPhotoResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchPhotoResponseToJson(
        SearchPhotoResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };
