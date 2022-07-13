import 'package:unsplash_images/data/api_client/user_api_client.dart';
import 'package:unsplash_images/data/data_providers/token_data_provider.dart';
import 'package:unsplash_images/data/entity/photo.dart';
import 'package:unsplash_images/data/entity/user.dart';
import 'package:unsplash_images/data/entity/user_public_profile.dart';

class UserDataRepository {
  final _tokenDataProvider = TokenDataProvider();
  final _userApiClient = UserApiClient();

  Future<List<Photo>> getUserPhotos({
    required int page,
    required String username,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _userApiClient.getUserPhotos(
        page: page, username: username, token: token);
  }

  Future<List<Photo>> getUserLikedPhotos({
    required int page,
    required String username,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _userApiClient.getUserLikedPhotos(
        page: page, username: username, token: token);
  }

  Future<List<User>> searchUsers({
    required int page,
    required String query,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _userApiClient.searchUsers(page: page, query: query, token: token);
  }

  Future<UserPublicProfile> getCurrentUserProfile() async {
    final token = await _tokenDataProvider.getToken();
    return _userApiClient.getCurrentUserProfile(token: token);
  }

  Future<UserPublicProfile> getUserPublicProfileInfo({
    required String username,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _userApiClient.getUserPublicProfileInfo(
        username: username, token: token);
  }
}
