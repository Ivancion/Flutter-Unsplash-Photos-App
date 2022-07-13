import 'package:unsplash_images/configuration/configuration.dart';
import 'package:unsplash_images/data/api_client/network_client.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();

  String makeAuthorizeString() {
    String uri =
        '${Configuration.scheme}://unsplash.com${Configuration.authorizeEndpoint}?client_id=${Configuration.clientId}&redirect_uri=${Configuration.redirectUri}&response_type=code&scope=public+read_user+write_likes';
    return uri;
  }

  Future<String> makeToken(String authorizeCode) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['access_token'];
      return result;
    }

    final token = _networkClient.post(
      path: Configuration.tokenEndpoint,
      host: 'unsplash.com',
      parser: parser,
      urlParameters: <String, dynamic>{
        'client_id': Configuration.clientId,
        'client_secret': Configuration.secretKey,
        'redirect_uri': Configuration.redirectUri,
        'code': authorizeCode,
        'grant_type': 'authorization_code',
      },
    );
    return token;
  }
}
