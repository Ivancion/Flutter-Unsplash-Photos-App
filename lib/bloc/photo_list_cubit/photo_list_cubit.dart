import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/pagination_bloc.dart';
import 'package:unsplash_images/bloc/photo_list_cubit/photo_list_cubit_state.dart';
import 'package:unsplash_images/data/entity/photo.dart';
import 'package:unsplash_images/data/repositories/auth_repository.dart';
import 'package:unsplash_images/data/repositories/photo_data_repository.dart';

class PhotoListCubit extends Cubit<PhotoListCubitState> {
  final AuthRepository authRepository;
  final PhotoDataRepository photoDataRepository;
  late final ScrollController scrollController;
  late final PaginationBloc<Photo> paginationBloc;
  late final StreamSubscription<PaginationBlocState<Photo>>
      _paginationBlocSubscription;
  final BuildContext _context;

  PhotoListCubit(
    this._context,
    this.photoDataRepository,
    this.authRepository,
  ) : super(PhotoListCubitState.initial()) {
    scrollController = ScrollController()..addListener(_loadMore);
    paginationBloc = PaginationBloc<Photo>(
      PaginationBlocState.initial(),
      load: (page) async {
        final result = await photoDataRepository.getPopularPhotos(
            page: page, orderBy: 'popular');
        return result;
      },
      searchFunc: (page) async {
        final result = await photoDataRepository.searchPhotos(
            page: page, query: paginationBloc.state.searchQuery);
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
          status: PhotoListCubitStateStatus.success,
        );
        emit(newState);
        break;
      case DataStatus.failure:
        emit(state.copyWith(status: PhotoListCubitStateStatus.error));
        break;
      case DataStatus.emptyQueryResponse:
        emit(state.copyWith(
            status: PhotoListCubitStateStatus.emptyQueryResponse));
        break;
    }
  }

  Future<void> _loadMore() async {
    if (state.status == PhotoListCubitStateStatus.error) return;
    if (scrollController.position.extentAfter < 300) {
      paginationBloc.add(LoadNextPageEvent());
    }
  }

  Future<void> searchPhotos(String text) async {
    emit(PhotoListCubitState.initial());
    paginationBloc.add(ResetDataEvent());
    paginationBloc.add(SearchEvent(text));
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

      ScaffoldMessenger.of(_context).showSnackBar(
        const SnackBar(
          content: Text('Downloaded to Gallery!'),
        ),
      );
    } catch (_) {
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(_context).showSnackBar(
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

  Future<void> deleteToken() async {
    await authRepository.deleteToken();
  }
}
