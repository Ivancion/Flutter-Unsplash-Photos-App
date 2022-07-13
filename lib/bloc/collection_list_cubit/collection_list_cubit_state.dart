import 'package:equatable/equatable.dart';
import 'package:unsplash_images/data/entity/collection.dart';

enum CollectionListCubitStateStatus {
  loading,
  error,
  success,
  emptyQueryResponse
}

class CollectionListCubitState extends Equatable {
  final List<Collection> collections;
  final CollectionListCubitStateStatus status;

  const CollectionListCubitState({
    required this.collections,
    required this.status,
  });

  const CollectionListCubitState.initial()
      : collections = const <Collection>[],
        status = CollectionListCubitStateStatus.loading;

  CollectionListCubitState copyWith({
    List<Collection>? collections,
    CollectionListCubitStateStatus? status,
  }) {
    return CollectionListCubitState(
      collections: collections ?? this.collections,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [collections, status];
}
