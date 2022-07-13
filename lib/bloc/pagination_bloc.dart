import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PaginationEvent {}

class LoadNextPageEvent extends PaginationEvent {}

class ResetDataEvent extends PaginationEvent {}

class SearchEvent extends PaginationEvent {
  final String query;

  SearchEvent(this.query);
}

enum DataStatus { initial, success, failure, emptyQueryResponse }

class PaginationBlocState<T> extends Equatable {
  final DataStatus status;
  final List<T> data;
  final int currentPage;
  final bool hasNextPage;
  final String searchQuery;

  const PaginationBlocState({
    required this.status,
    required this.data,
    required this.currentPage,
    required this.hasNextPage,
    required this.searchQuery,
  });

  PaginationBlocState.initial()
      : status = DataStatus.initial,
        data = <T>[],
        currentPage = 0,
        hasNextPage = true,
        searchQuery = '';

  PaginationBlocState<T> copyWith({
    DataStatus? status,
    List<T>? data,
    int? currentPage,
    bool? hasNextPage,
    String? searchQuery,
  }) {
    return PaginationBlocState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props {
    return [
      status,
      data,
      currentPage,
      hasNextPage,
      searchQuery,
    ];
  }
}

class PaginationBloc<T> extends Bloc<PaginationEvent, PaginationBlocState<T>> {
  final Future<List<T>> Function(int page)? load;
  final Future<List<T>> Function(int page)? searchFunc;

  PaginationBloc(
    PaginationBlocState<T> initialState, {
    this.load,
    this.searchFunc,
  }) : super(initialState) {
    on<PaginationEvent>((event, emit) async {
      if (event is LoadNextPageEvent) {
        await onLoadNextPageEvent(event, emit);
      } else if (event is ResetDataEvent) {
        await onResetDataEvent(event, emit);
      } else if (event is SearchEvent) {
        await onSearchEvent(event, emit);
      }
    }, transformer: droppable());
  }

  Future<void> onLoadNextPageEvent(
    LoadNextPageEvent event,
    Emitter<PaginationBlocState<T>> emit,
  ) async {
    if (searchFunc != null && state.searchQuery.isNotEmpty) {
      if (!state.hasNextPage) return;
      final nextPage = state.currentPage + 1;
      try {
        if (state.status == DataStatus.initial) {
          final result = await searchFunc!(nextPage);
          if (result.isEmpty) {
            final newState =
                state.copyWith(status: DataStatus.emptyQueryResponse);
            return emit(newState);
          } else {
            final data = state.data..addAll(result);
            final newState = state.copyWith(
              status: DataStatus.success,
              data: data,
              currentPage: nextPage,
            );
            return emit(newState);
          }
        }
        final result = await searchFunc!(nextPage);
        if (result.isNotEmpty) {
          final data = state.data..addAll(result);
          final newState = state.copyWith(
            status: DataStatus.success,
            data: data,
            currentPage: nextPage,
          );
          emit(newState);
        } else {
          final newState = state.copyWith(hasNextPage: false);
          emit(newState);
        }
      } catch (_) {
        emit(state.copyWith(status: DataStatus.failure));
      }
    } else {
      if (!state.hasNextPage || load == null) return;
      final nextPage = state.currentPage + 1;
      try {
        final result = await load!(nextPage);
        if (result.isEmpty) {
          final newState = state.copyWith(hasNextPage: false);
          return emit(newState);
        } else {
          final data = state.data..addAll(result);
          final newState = state.copyWith(
            status: DataStatus.success,
            data: data,
            currentPage: nextPage,
          );
          return emit(newState);
        }
      } catch (_) {
        emit(state.copyWith(status: DataStatus.failure));
      }
    }
  }

  Future<void> onResetDataEvent(
    ResetDataEvent event,
    Emitter<PaginationBlocState<T>> emit,
  ) async {
    emit(PaginationBlocState<T>.initial());
  }

  Future<void> onSearchEvent(
    SearchEvent event,
    Emitter<PaginationBlocState<T>> emit,
  ) async {
    if (state.searchQuery == event.query ||
        event.query.isEmpty ||
        searchFunc == null) return;
    final newState = state.copyWith(searchQuery: event.query);
    emit(newState);
    add(LoadNextPageEvent());
  }
}
