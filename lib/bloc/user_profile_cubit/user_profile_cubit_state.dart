import 'package:equatable/equatable.dart';

enum UserProfileDataStatus { loading, success, failed }

class UserProfileCubitState extends Equatable {
  final String username;
  final String name;
  final String? firstName;
  final String? lastName;
  final String profileImage;
  final String? bio;
  final int totalLikes;
  final int totalPhotos;
  final UserProfileDataStatus status;

  const UserProfileCubitState({
    required this.username,
    required this.name,
    this.firstName,
    this.lastName,
    required this.profileImage,
    this.bio,
    required this.totalLikes,
    required this.totalPhotos,
    required this.status,
  });

  const UserProfileCubitState.initial()
      : username = '',
        name = '',
        firstName = '',
        lastName = '',
        profileImage = '',
        bio = '',
        totalLikes = 0,
        totalPhotos = 0,
        status = UserProfileDataStatus.loading;

  UserProfileCubitState copyWith({
    String? username,
    String? name,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? bio,
    int? totalLikes,
    int? totalPhotos,
    UserProfileDataStatus? status,
  }) {
    return UserProfileCubitState(
      username: username ?? this.username,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      totalLikes: totalLikes ?? this.totalLikes,
      totalPhotos: totalPhotos ?? this.totalPhotos,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      username,
      name,
      firstName,
      lastName,
      profileImage,
      bio,
      totalLikes,
      totalPhotos,
      status,
    ];
  }
}
