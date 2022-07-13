import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/pagination_bloc.dart';
import 'package:unsplash_images/bloc/user_photos_cubit/user_photos_cubit_state.dart';
import 'package:unsplash_images/data/entity/photo.dart';
import 'package:unsplash_images/data/repositories/photo_data_repository.dart';
import 'package:unsplash_images/data/repositories/user_data_repository.dart';

class UserPhotosCubit extends Cubit<UserPhotosCubitState> {
  final String username;
  final UserDataRepository userDataRepository;
  final PhotoDataRepository photoDataRepository;
  late final ScrollController scrollController;
  late final PaginationBloc<Photo> paginationBloc;
  late final StreamSubscription<PaginationBlocState<Photo>>
      _paginationBlocSubscription;
  final BuildContext context;

  UserPhotosCubit({
    required this.context,
    required this.username,
    required this.userDataRepository,
    required this.photoDataRepository,
  }) : super(const UserPhotosCubitState.initial()) {
    scrollController = ScrollController()..addListener(_loadMore);
    paginationBloc = PaginationBloc<Photo>(
      PaginationBlocState.initial(),
      load: (page) async {
        final result = await userDataRepository.getUserPhotos(
            page: page, username: username);
        return result;
      },
    );

    _onState(paginationBloc.state);
    _paginationBlocSubscription = paginationBloc.stream.listen(_onState);
    paginationBloc.add(LoadNextPageEvent());
  }

  void _onState(PaginationBlocState<Photo> blocState) {
    switch (blocState.status) {
      case DataStatus.initial:
        break;
      case DataStatus.success:
        List<Photo> photos = List.from(blocState.data);
        final newState = state.copyWith(
          photos: photos,
          status: UserPhotosCubitStateStatus.success,
        );
        emit(newState);
        break;
      case DataStatus.failure:
        emit(state.copyWith(status: UserPhotosCubitStateStatus.error));
        break;
      case DataStatus.emptyQueryResponse:
        break;
    }
  }

  Future<void> _loadMore() async {
    if (state.status == UserPhotosCubitStateStatus.error) return;
    if (scrollController.position.extentAfter < 300) {
      paginationBloc.add(LoadNextPageEvent());
    }
  }

  Future<void> likeThePhoto(String photoId, int index) async {
    try {
      final photo = await photoDataRepository.likeThePhoto(photoId: photoId);
      List<Photo> photos = List.from(state.photos);
      photos[index] = photos[index].copyWith(likedByUser: photo.likedByUser);
      final newState = state.copyWith(photos: photos);
      emit(newState);
    } catch (e) {
      _showErrorSnackBar();
    }
  }

  Future<void> unlikeThePhoto(String photoId, int index) async {
    try {
      final photo = await photoDataRepository.unlikeThePhoto(photoId: photoId);
      List<Photo> photos = List.from(state.photos);
      photos[index] = photo;
      final newState = state.copyWith(photos: photos);
      emit(newState);
    } catch (e) {
      _showErrorSnackBar();
    }
  }

  Future<void> downloadImage(String url) async {
    try {
      await photoDataRepository.savePhoto(url);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Downloaded to Gallery!'),
        ),
      );
    } catch (_) {
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Something go wrong, try again later'),
      ),
    );
  }

  @override
  Future<void> close() {
    _paginationBlocSubscription.cancel();
    return super.close();
  }
}
