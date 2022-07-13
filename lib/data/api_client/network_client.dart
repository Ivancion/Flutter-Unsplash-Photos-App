import 'dart:convert';
import 'dart:io';

import 'package:unsplash_images/configuration/configuration.dart';
import 'package:unsplash_images/data/api_client/api_client_exception.dart';

class NetworkClient {
  final _client = HttpClient();

  Uri makeUri(
    String path,
    String host, [
    Map<String, dynamic>? urlParameters,
  ]) {
    final url = Uri(
      scheme: Configuration.scheme,
      host: host,
      path: path,
      queryParameters: urlParameters?.map(
        (key, value) => MapEntry(
          key,
          value.toString(),
        ),
      ),
    );

    return url;
  }

  Future<T> get<T>({
    required String path,
    required String host,
    required T Function(dynamic json) parser,
    String? token,
    Map<String, dynamic>? urlParameters,
  }) async {
    final url = makeUri(path, host, urlParameters);
    try {
      final request = await _client.getUrl(url);
      if (token != null) {
        request.headers.add('Authorization', 'Bearer $token');
      }
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> post<T>({
    required String path,
    required String host,
    required T Function(dynamic json) parser,
    String? token,
    Map<String, dynamic>? urlParameters,
  }) async {
    try {
      final url = makeUri(path, host, urlParameters);
      final request = await _client.postUrl(url);
      if (token != null) {
        request.headers.add('Authorization', 'Bearer $token');
      }
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);

      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> delete<T>({
    required String path,
    required String host,
    required T Function(dynamic json) parser,
    String? token,
    Map<String, dynamic>? urlParameters,
  }) async {
    try {
      final url = makeUri(path, host, urlParameters);
      final request = await _client.deleteUrl(url);
      if (token != null) {
        request.headers.add('Authorization', 'Bearer $token');
      }
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);

      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => json.decode(v));
  }
}
