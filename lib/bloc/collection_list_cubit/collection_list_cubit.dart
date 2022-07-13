import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/collection_list_cubit/collection_list_cubit_state.dart';
import 'package:unsplash_images/bloc/pagination_bloc.dart';
import 'package:unsplash_images/data/entity/collection.dart';
import 'package:unsplash_images/data/repositories/auth_repository.dart';
import 'package:unsplash_images/data/repositories/collection_data_repository.dart';

class CollectionListCubit extends Cubit<CollectionListCubitState> {
  final AuthRepository authRepository;
  final CollectionDataRepository collectionDataRepository;
  late final ScrollController _scrollController;
  late final PaginationBloc<Collection> _paginationBloc;
  late final StreamSubscription<PaginationBlocState<Collection>>
      _paginationBlocSubscription;

  ScrollController get scrollController => _scrollController;

  CollectionListCubit({
    required this.authRepository,
    required this.collectionDataRepository,
  }) : super(const CollectionListCubitState.initial()) {
    _scrollController = ScrollController()..addListener(_loadMore);
    _paginationBloc = PaginationBloc<Collection>(
      PaginationBlocState.initial(),
      load: (page) async {
        final result = await collectionDataRepository.getCollections(
          page: page,
          perPage: 20,
        );
        return result;
      },
      searchFunc: (page) async {
        final result = await collectionDataRepository.searchCollections(
            page: page, query: _paginationBloc.state.searchQuery);
        return result;
      },
    );

    _onState(_paginationBloc.state);
    _paginationBlocSubscription = _paginationBloc.stream.listen(_onState);
    _paginationBloc.add(LoadNextPageEvent());
  }

  void _onState(PaginationBlocState<Collection> blocState) {
    switch (blocState.status) {
      case DataStatus.initial:
        break;
      case DataStatus.success:
        List<Collection> collections = List.from(blocState.data);
        final newState = state.copyWith(
          collections: collections,
          status: CollectionListCubitStateStatus.success,
        );
        emit(newState);
        break;
      case DataStatus.failure:
        emit(state.copyWith(status: CollectionListCubitStateStatus.error));
        break;
      case DataStatus.emptyQueryResponse:
        emit(state.copyWith(
            status: CollectionListCubitStateStatus.emptyQueryResponse));
        break;
    }
  }

  Future<void> _loadMore() async {
    if (state.status == CollectionListCubitStateStatus.error) return;
    if (_scrollController.position.extentAfter < 300) {
      _paginationBloc.add(LoadNextPageEvent());
    }
  }

  Future<void> searchCollection(String text) async {
    emit(const CollectionListCubitState.initial());
    _paginationBloc.add(ResetDataEvent());
    _paginationBloc.add(SearchEvent(text));
  }

  Future<void> deleteToken() async {
    await authRepository.deleteToken();
  }

  @override
  Future<void> close() {
    _paginationBlocSubscription.cancel();
    return super.close();
  }
}
