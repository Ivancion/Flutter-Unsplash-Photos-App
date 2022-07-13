// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchCollectionResponse _$SearchCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCollectionResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchCollectionResponseToJson(
        SearchCollectionResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };
