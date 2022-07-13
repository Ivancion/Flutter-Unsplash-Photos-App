import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/pagination_bloc.dart';
import 'package:unsplash_images/bloc/user_list_cubit/user_list_cubit_state.dart';
import 'package:unsplash_images/data/entity/user.dart';
import 'package:unsplash_images/data/repositories/auth_repository.dart';
import 'package:unsplash_images/data/repositories/user_data_repository.dart';

class UserListCubit extends Cubit<UserListCubitState> {
  final AuthRepository authRepository;
  final UserDataRepository userDataRepository;
  late final ScrollController _scrollController;
  late final PaginationBloc<User> _paginationBloc;
  late final StreamSubscription<PaginationBlocState<User>>
      _paginationBlocSubscription;

  ScrollController get scrollController => _scrollController;

  UserListCubit({
    required this.authRepository,
    required this.userDataRepository,
  }) : super(const UserListCubitState.initial()) {
    _scrollController = ScrollController()..addListener(_loadMore);
    _paginationBloc = PaginationBloc<User>(
      PaginationBlocState.initial(),
      searchFunc: (page) async {
        final result = await userDataRepository.searchUsers(
            page: page, query: _paginationBloc.state.searchQuery);
        return result;
      },
    );

    _onState(_paginationBloc.state);
    _paginationBlocSubscription = _paginationBloc.stream.listen(_onState);
  }

  void _onState(PaginationBlocState<User> blocState) {
    switch (blocState.status) {
      case DataStatus.initial:
        break;
      case DataStatus.success:
        List<User> users = List.from(blocState.data);
        final newState = state.copyWith(
          users: users,
          status: UserListCubitStateStatus.success,
        );
        emit(newState);
        break;
      case DataStatus.failure:
        emit(state.copyWith(
          status: UserListCubitStateStatus.error,
        ));
        break;
      case DataStatus.emptyQueryResponse:
        emit(state.copyWith(
          status: UserListCubitStateStatus.emptyQueryResponse,
        ));
        break;
    }
  }

  Future<void> _loadMore() async {
    if (state.status == UserListCubitStateStatus.error) return;
    if (_scrollController.position.extentAfter < 300) {
      _paginationBloc.add(LoadNextPageEvent());
    }
  }

  Future<void> searchUsers(String text) async {
    const initialState = UserListCubitState.initial();
    final newState =
        initialState.copyWith(status: UserListCubitStateStatus.loading);
    emit(newState);
    _paginationBloc.add(ResetDataEvent());
    _paginationBloc.add(SearchEvent(text));
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
