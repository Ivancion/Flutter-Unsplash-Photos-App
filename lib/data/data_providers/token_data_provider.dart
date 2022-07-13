import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const tokenId = 'token-id';
}

class TokenDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getToken() => _secureStorage.read(key: _Keys.tokenId);

  Future<void> setToken(String value) {
    return _secureStorage.write(key: _Keys.tokenId, value: value);
  }

  Future<void> deleteToken() async {
    _secureStorage.delete(key: _Keys.tokenId);
  }
}
