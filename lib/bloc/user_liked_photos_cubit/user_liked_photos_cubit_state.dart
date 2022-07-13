import 'package:equatable/equatable.dart';
import 'package:unsplash_images/data/entity/photo.dart';

enum UserLikedPhotosCubitStateStatus { loading, success, error }

class UserLikedPhotosCubitState extends Equatable {
  final List<Photo> photos;
  final UserLikedPhotosCubitStateStatus status;

  const UserLikedPhotosCubitState({
    required this.photos,
    required this.status,
  });

  const UserLikedPhotosCubitState.initial()
      : photos = const <Photo>[],
        status = UserLikedPhotosCubitStateStatus.loading;

  UserLikedPhotosCubitState copyWith({
    List<Photo>? photos,
    UserLikedPhotosCubitStateStatus? status,
  }) {
    return UserLikedPhotosCubitState(
      photos: photos ?? this.photos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [photos, status];
}
