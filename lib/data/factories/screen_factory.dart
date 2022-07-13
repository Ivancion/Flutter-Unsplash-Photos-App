import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_images/bloc/collection_details_cubit/collection_details_cubit.dart';
import 'package:unsplash_images/bloc/collection_list_cubit/collection_list_cubit.dart';
import 'package:unsplash_images/bloc/loading_screen_cubit/loading_screen_cubit.dart';
import 'package:unsplash_images/bloc/photo_list_cubit/photo_list_cubit.dart';
import 'package:unsplash_images/bloc/user_liked_photos_cubit/user_liked_photos_cubit.dart';
import 'package:unsplash_images/bloc/user_list_cubit/user_list_cubit.dart';
import 'package:unsplash_images/bloc/user_photos_cubit/user_photos_cubit.dart';
import 'package:unsplash_images/bloc/user_profile_cubit/user_profile_cubit.dart';
import 'package:unsplash_images/data/repositories/auth_repository.dart';
import 'package:unsplash_images/data/repositories/collection_data_repository.dart';
import 'package:unsplash_images/data/repositories/photo_data_repository.dart';
import 'package:unsplash_images/data/repositories/user_data_repository.dart';
import 'package:unsplash_images/ui/screens/auth_screen/auth_screen.dart';
import 'package:unsplash_images/ui/screens/auth_screen/auth_screen_model.dart';
import 'package:unsplash_images/ui/screens/collection_details_screen.dart';
import 'package:unsplash_images/ui/screens/collection_list_screen.dart';
import 'package:unsplash_images/ui/screens/error_screen.dart';
import 'package:unsplash_images/ui/screens/loading_screen.dart';
import 'package:unsplash_images/ui/screens/main_screen.dart';
import 'package:unsplash_images/ui/screens/photo_list_screen.dart';
import 'package:unsplash_images/ui/screens/user_liked_photos_screen.dart';
import 'package:unsplash_images/ui/screens/user_list_screen.dart';
import 'package:unsplash_images/ui/screens/user_photos_screen.dart';
import 'package:unsplash_images/ui/screens/user_profile_screen.dart';

class ScreenFactory {
  final AuthRepository authRepository;
  final CollectionDataRepository collectionDataRepository;
  final PhotoDataRepository photoDataRepository;
  final UserDataRepository userDataRepository;

  ScreenFactory()
      : authRepository = AuthRepository(),
        collectionDataRepository = CollectionDataRepository(),
        photoDataRepository = PhotoDataRepository(),
        userDataRepository = UserDataRepository();

  Widget makeLoadingScreen() {
    return BlocProvider(
      create: ((_) => LoadingScreenCubit(authRepository)),
      child: const LoadingScreen(),
      lazy: false,
    );
  }

  Widget makeUserProfileScreen(String username) {
    return BlocProvider(
      create: ((context) => UserProfileCubit(
            username: username,
            userDataRepository: UserDataRepository(),
          )),
      child: const UserProfileScreen(),
    );
  }

  Widget makePhotoListScreen() {
    return BlocProvider(
      create: ((context) => PhotoListCubit(
            context,
            photoDataRepository,
            authRepository,
          )),
      child: const PhotoListScreen(),
    );
  }

  Widget makeCollectionDetailsScreen(String collectionId) {
    return BlocProvider(
      create: (context) => CollectionDetailsCubit(
        collectionId: collectionId,
        context: context,
        collectionDataRepostitory: collectionDataRepository,
        photoDataRepository: photoDataRepository,
      ),
      child: const CollectionDetailsScreen(),
    );
  }

  Widget makeCollectionListScreen() {
    return BlocProvider(
      create: ((context) => CollectionListCubit(
            collectionDataRepository: collectionDataRepository,
            authRepository: authRepository,
          )),
      child: const CollectionListScreen(),
    );
  }

  Widget makeUserListScreen() {
    return BlocProvider(
      create: ((context) => UserListCubit(
            userDataRepository: userDataRepository,
            authRepository: authRepository,
          )),
      child: const UserListScreen(),
    );
  }

  Widget makeAuthScreen() {
    return Provider(
      create: ((context) => AuthModel(authRepository: authRepository)),
      child: const AuthScreen(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreen();
  }

  Widget makeErrorScreen(String error) {
    return ErrorScreen(error: error);
  }

  Widget makeUserPhotosScreen(String username) {
    return BlocProvider(
      create: (context) => UserPhotosCubit(
        username: username,
        context: context,
        userDataRepository: userDataRepository,
        photoDataRepository: photoDataRepository,
      ),
      child: const UserPhotosScreen(),
    );
  }

  Widget makeUserLikedPhotosScreen(String username, int totalLikes) {
    return BlocProvider(
      create: (context) => UserLikedPhotosCubit(
        totalLikes: totalLikes,
        username: username,
        context: context,
        userDataRepository: userDataRepository,
        photoDataRepository: photoDataRepository,
      ),
      child: const UserLikedPhotosScreen(),
    );
  }
}
