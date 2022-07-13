import 'package:equatable/equatable.dart';
import 'package:unsplash_images/data/entity/photo.dart';

enum UserPhotosCubitStateStatus { loading, error, success }

class UserPhotosCubitState extends Equatable {
  final List<Photo> photos;
  final UserPhotosCubitStateStatus status;

  const UserPhotosCubitState({
    required this.photos,
    required this.status,
  });

  const UserPhotosCubitState.initial()
      : photos = const <Photo>[],
        status = UserPhotosCubitStateStatus.loading;

  UserPhotosCubitState copyWith({
    List<Photo>? photos,
    UserPhotosCubitStateStatus? status,
  }) {
    return UserPhotosCubitState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [photos, status];
}
