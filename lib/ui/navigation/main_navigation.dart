import 'package:flutter/material.dart';
import 'package:unsplash_images/data/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loadingScreen = 'loading_screen';
  static const authScreen = 'auth';
  static const mainScreen = 'main_screen';
  static const errorScreen = 'error_screen';
  static const collectionDetailsScreen = 'details';
  static const userProfileScreen = 'user_profile_screen';
  static const userPhotosScreen = 'user_photos_screen';
  static const userLikedPhotosScreen = 'user_liked_photos_screen';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = {
    MainNavigationRouteNames.loadingScreen: (_) =>
        _screenFactory.makeLoadingScreen(),
    MainNavigationRouteNames.authScreen: (_) => _screenFactory.makeAuthScreen(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.userProfileScreen:
        final username = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeUserProfileScreen(username));
      case MainNavigationRouteNames.errorScreen:
        final errorMessage = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeErrorScreen(errorMessage));
      case MainNavigationRouteNames.collectionDetailsScreen:
        final collectionId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) =>
                _screenFactory.makeCollectionDetailsScreen(collectionId));
      case MainNavigationRouteNames.userPhotosScreen:
        final username = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeUserPhotosScreen(username));
      case MainNavigationRouteNames.userLikedPhotosScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        final username = arguments['username'] as String;
        final totalLikes = arguments['total_likes'] as int;
        return MaterialPageRoute(
            builder: (_) =>
                _screenFactory.makeUserLikedPhotosScreen(username, totalLikes));
      default:
        const widget = Text('Navigation Error!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
