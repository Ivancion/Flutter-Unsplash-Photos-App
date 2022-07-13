import 'package:flutter/material.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.loadingScreen,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
