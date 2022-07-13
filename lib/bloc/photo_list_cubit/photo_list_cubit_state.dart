import 'package:equatable/equatable.dart';
import 'package:unsplash_images/data/entity/photo.dart';

enum PhotoListCubitStateStatus { loading, success, error, emptyQueryResponse }

class PhotoListCubitState extends Equatable {
  final List<Photo> photos;
  final PhotoListCubitStateStatus status;

  const PhotoListCubitState({
    required this.photos,
    required this.status,
  });

  PhotoListCubitState.initial()
      : photos = <Photo>[],
        status = PhotoListCubitStateStatus.loading;

  PhotoListCubitState copyWith({
    List<Photo>? photos,
    PhotoListCubitStateStatus? status,
  }) {
    return PhotoListCubitState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [photos, status];
}
