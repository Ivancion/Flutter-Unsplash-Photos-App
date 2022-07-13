import 'package:unsplash_images/data/api_client/network_client.dart';
import 'package:unsplash_images/data/entity/photo.dart';
import 'package:unsplash_images/data/entity/search_user_response.dart';
import 'package:unsplash_images/data/entity/user.dart';
import 'package:unsplash_images/data/entity/user_public_profile.dart';

class UserApiClient {
  final _networkClient = NetworkClient();

  Future<List<Photo>> getUserPhotos({
    required int page,
    required String username,
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
      path: '/users/$username/photos',
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

  Future<List<Photo>> getUserLikedPhotos({
    required int page,
    required String username,
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
      path: '/users/$username/likes',
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

  Future<List<User>> searchUsers({
    required int page,
    required String query,
    required String? token,
  }) async {
    List<User> parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = SearchUserResponse.fromJson(jsonMap).results;
      return result;
    }

    final users = _networkClient.get(
      path: '/search/users',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
      urlParameters: <String, dynamic>{
        'query': query,
        'page': page,
        'per_page': 20,
      },
    );

    return users;
  }

  Future<UserPublicProfile> getCurrentUserProfile({
    required String? token,
  }) async {
    UserPublicProfile parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = UserPublicProfile.fromJson(jsonMap);
      return result;
    }

    final user = _networkClient.get(
      path: '/me',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
    );
    return user;
  }

  Future<UserPublicProfile> getUserPublicProfileInfo({
    required String username,
    required String? token,
  }) async {
    UserPublicProfile parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = UserPublicProfile.fromJson(jsonMap);
      return result;
    }

    final profileInfo = _networkClient.get(
      path: '/users/$username',
      host: 'api.unsplash.com',
      parser: parser,
      token: token,
    );
    return profileInfo;
  }
}
