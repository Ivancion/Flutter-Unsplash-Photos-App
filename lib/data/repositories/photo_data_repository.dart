import 'package:unsplash_images/data/api_client/photo_api_client.dart';
import 'package:unsplash_images/data/data_providers/image_saver_data_provider.dart';
import 'package:unsplash_images/data/data_providers/token_data_provider.dart';
import 'package:unsplash_images/data/entity/photo.dart';

class PhotoDataRepository {
  final _photoApiClient = PhotoApiClient();
  final _tokenDataProvider = TokenDataProvider();
  final _imageSaverDataProvider = ImageSaverDataProvider();

  Future<List<Photo>> getPopularPhotos({
    required int page,
    required String orderBy,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _photoApiClient.getPopularPhotos(
        page: page, orderBy: orderBy, token: token);
  }

  Future<List<Photo>> searchPhotos({
    required int page,
    required String query,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _photoApiClient.searchPhotos(page: page, query: query, token: token);
  }

  Future<Photo> likeThePhoto({
    required String photoId,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _photoApiClient.likeThePhoto(photoId: photoId, token: token);
  }

  Future<Photo> unlikeThePhoto({
    required String photoId,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _photoApiClient.unlikeThePhoto(photoId: photoId, token: token);
  }

  Future<void> savePhoto(String url) async {
    return _imageSaverDataProvider.saveImage(url);
  }
}
