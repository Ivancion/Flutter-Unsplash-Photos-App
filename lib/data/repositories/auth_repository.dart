import 'package:unsplash_images/data/api_client/auth_api_client.dart';
import 'package:unsplash_images/data/data_providers/token_data_provider.dart';

class AuthRepository {
  final _tokenDataProvider = TokenDataProvider();
  final _authApiClient = AuthApiClient();

  Future<bool> isAuth() async {
    final token = await _tokenDataProvider.getToken();
    final isAuth = token != null;
    return isAuth;
  }

  String authorizeString() {
    return _authApiClient.makeAuthorizeString();
  }

  Future<String> makeToken(String authorizeCode) async {
    return _authApiClient.makeToken(authorizeCode);
  }

  Future<void> deleteToken() async {
    await _tokenDataProvider.deleteToken();
  }
}
