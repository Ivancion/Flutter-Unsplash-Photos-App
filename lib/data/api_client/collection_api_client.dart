import 'package:unsplash_images/data/api_client/network_client.dart';
import 'package:unsplash_images/data/entity/collection.dart';
import 'package:unsplash_images/data/entity/photo.dart';
import 'package:unsplash_images/data/entity/search_collection_response.dart';

class CollectionApiClient {
  final _networkClient = NetworkClient();

  Future<List<Collection>> searchCollections({
    required int page,
    required String query,
    required String? token,
  }) async {
    List<Collection> parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = SearchCollectionResponse.fromJson(jsonMap).results;
      return result;
    }

    final collections = _networkClient.get(
      path: '/search/collections',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
      urlParameters: <String, dynamic>{
        'query': query,
        'page': page,
        'per_page': 20,
      },
    );

    return collections;
  }

  Future<List<Collection>> getCollections({
    required int page,
    required int perPage,
    required String? token,
  }) async {
    List<Collection> parser(dynamic json) {
      final jsonList = json as List<dynamic>;
      final result = jsonList
          .map((e) => Collection.fromJson(e as Map<String, dynamic>))
          .toList();
      return result;
    }

    final collections = _networkClient.get(
      path: '/collections',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
      urlParameters: <String, dynamic>{
        'page': page,
        'per_page': perPage,
      },
    );
    return collections;
  }

  Future<List<Photo>> getCollectionById({
    required String id,
    required int page,
    required String? token,
  }) async {
    List<Photo> parser(dynamic json) {
      final jsonList = json as List<dynamic>;
      final result = jsonList
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList();
      return result;
    }

    final photos = _networkClient.get(
      path: '/collections/$id/photos',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
      urlParameters: <String, dynamic>{
        'page': page,
        'per_page': 20,
      },
    );

    return photos;
  }
}
