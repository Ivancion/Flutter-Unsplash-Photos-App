import 'package:unsplash_images/data/api_client/collection_api_client.dart';
import 'package:unsplash_images/data/data_providers/token_data_provider.dart';
import 'package:unsplash_images/data/entity/collection.dart';
import 'package:unsplash_images/data/entity/photo.dart';

class CollectionDataRepository {
  final _tokenDataProvider = TokenDataProvider();
  final _collectionApiClient = CollectionApiClient();

  Future<List<Collection>> searchCollections({
    required int page,
    required String query,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _collectionApiClient.searchCollections(
        page: page, query: query, token: token);
  }

  Future<List<Collection>> getCollections({
    required int page,
    required int perPage,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _collectionApiClient.getCollections(
        page: page, perPage: perPage, token: token);
  }

  Future<List<Photo>> getCollectionById({
    required String id,
    required int page,
  }) async {
    final token = await _tokenDataProvider.getToken();
    return _collectionApiClient.getCollectionById(
        id: id, page: page, token: token);
  }
}
