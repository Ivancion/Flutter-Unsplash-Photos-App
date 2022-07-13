import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_images/data/api_client/api_client_exception.dart';
import 'package:unsplash_images/data/data_providers/token_data_provider.dart';
import 'package:unsplash_images/data/repositories/auth_repository.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthModel {
  final AuthRepository authRepository;
  final _tokenDataProvider = TokenDataProvider();

  AuthModel({required this.authRepository});

  String get authorizeString => authRepository.authorizeString();

  Future<void> auth(BuildContext context, String authorizeCode) async {
    try {
      final authToken = await authRepository.makeToken(authorizeCode);
      await _tokenDataProvider.setToken(authToken);
      Navigator.pushReplacementNamed(
          context, MainNavigationRouteNames.mainScreen);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _openErrorScreen(
              ApiClientException(ApiClientExceptionType.network), context);
          break;
        case ApiClientExceptionType.other:
          _openErrorScreen(
              ApiClientException(ApiClientExceptionType.other), context);
          break;
      }
    }
  }

  void validateWebView(WebResourceError error, BuildContext context) {
    if (error.errorType == WebResourceErrorType.hostLookup) {
      _openErrorScreen(
          ApiClientException(ApiClientExceptionType.network), context);
    } else {
      _openErrorScreen(
          ApiClientException(ApiClientExceptionType.other), context);
    }
  }

  void _openErrorScreen(ApiClientException exception, BuildContext context) {
    String errorMessage;
    switch (exception.type) {
      case ApiClientExceptionType.network:
        errorMessage = 'No internet connection. Check it and try again.';
        Navigator.of(context).pushReplacementNamed(
            MainNavigationRouteNames.errorScreen,
            arguments: errorMessage);
        break;
      case ApiClientExceptionType.other:
        errorMessage = 'Something go wrong. Try again later';
        Navigator.of(context).pushReplacementNamed(
            MainNavigationRouteNames.errorScreen,
            arguments: errorMessage);
        break;
    }
  }

  FutureOr<NavigationDecision> handleNavigationActions(
      NavigationRequest navReq, BuildContext context) async {
    if (navReq.url.contains('native')) {
      final code = navReq.url.split('=')[1];
      await auth(context, code);
      return NavigationDecision.navigate;
    }
    return NavigationDecision.navigate;
  }
}
