import 'package:unsplash_images/data/api_client/network_client.dart';
import 'package:unsplash_images/data/entity/photo.dart';
import 'package:unsplash_images/data/entity/search_photo_response.dart';

class PhotoApiClient {
  final _networkClient = NetworkClient();

  Future<List<Photo>> getPopularPhotos({
    required int page,
    required String orderBy,
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
      path: '/photos',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
      urlParameters: <String, dynamic>{
        'page': page,
        'per_page': 20,
        'order_by': orderBy,
      },
    );
    return photos;
  }

  Future<List<Photo>> searchPhotos({
    required int page,
    required String query,
    required String? token,
  }) async {
    List<Photo> parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = SearchPhotoResponse.fromJson(jsonMap).results;
      return result;
    }

    final photos = _networkClient.get(
      path: '/search/photos',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
      urlParameters: <String, dynamic>{
        'query': query,
        'page': page,
        'per_page': 20,
      },
    );

    return photos;
  }

  Future<Photo> likeThePhoto(
      {required String photoId, required String? token}) async {
    Photo parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = Photo.fromJson(jsonMap['photo']);
      return result;
    }

    final photo = _networkClient.post(
        path: '/photos/$photoId/like',
        host: 'api.unsplash.com',
        parser: parser,
        token: token);

    return photo;
  }

  Future<Photo> unlikeThePhoto(
      {required String photoId, required String? token}) async {
    Photo parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = Photo.fromJson(jsonMap['photo']);
      return result;
    }

    final photo = _networkClient.delete(
        path: '/photos/$photoId/like',
        host: 'api.unsplash.com',
        parser: parser,
        token: token);

    return photo;
  }
}
