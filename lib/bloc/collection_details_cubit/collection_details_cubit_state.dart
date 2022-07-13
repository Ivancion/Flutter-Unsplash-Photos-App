import 'package:equatable/equatable.dart';
import 'package:unsplash_images/data/entity/photo.dart';

enum CollectionDetailsCubitStateStatus { loading, error, success }

class CollectionDetailsCubitState extends Equatable {
  final List<Photo> photos;
  final CollectionDetailsCubitStateStatus status;

  const CollectionDetailsCubitState({
    required this.photos,
    required this.status,
  });

  const CollectionDetailsCubitState.initial()
      : photos = const <Photo>[],
        status = CollectionDetailsCubitStateStatus.loading;

  CollectionDetailsCubitState copyWith({
    List<Photo>? photos,
    CollectionDetailsCubitStateStatus? status,
  }) {
    return CollectionDetailsCubitState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [photos, status];
}
