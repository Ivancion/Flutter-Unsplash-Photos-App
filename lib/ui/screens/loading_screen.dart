import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/loading_screen_cubit/loading_screen_cubit.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoadingScreenCubit, LoadingScreenCubitState>(
        listener: (context, state) {
          if (state == LoadingScreenCubitState.authorized) {
            Navigator.of(context)
                .pushNamed(MainNavigationRouteNames.mainScreen);
          } else if (state == LoadingScreenCubitState.unauthorized) {
            Navigator.of(context)
                .pushNamed(MainNavigationRouteNames.authScreen);
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
