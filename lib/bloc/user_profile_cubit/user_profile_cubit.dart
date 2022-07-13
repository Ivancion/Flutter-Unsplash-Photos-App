import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/user_profile_cubit/user_profile_cubit_state.dart';
import 'package:unsplash_images/data/entity/user_public_profile.dart';
import 'package:unsplash_images/data/repositories/user_data_repository.dart';

class UserProfileCubit extends Cubit<UserProfileCubitState> {
  final String username;
  final UserDataRepository userDataRepository;

  UserProfileCubit({required this.username, required this.userDataRepository})
      : super(const UserProfileCubitState.initial()) {
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      UserPublicProfile userProfileInfo;
      if (username == 'me') {
        userProfileInfo = await userDataRepository.getCurrentUserProfile();
      } else {
        userProfileInfo = await userDataRepository.getUserPublicProfileInfo(
            username: username);
      }
      final newState = UserProfileCubitState(
          username: userProfileInfo.username,
          name: userProfileInfo.name,
          firstName: userProfileInfo.firstName,
          lastName: userProfileInfo.lastName,
          profileImage: userProfileInfo.profileImage.medium,
          bio: userProfileInfo.bio,
          totalLikes: userProfileInfo.totalLikes,
          totalPhotos: userProfileInfo.totalPhotos,
          status: UserProfileDataStatus.success);
      emit(newState);
    } catch (_) {
      final newState = state.copyWith(status: UserProfileDataStatus.failed);
      emit(newState);
    }
  }

  void updateState(int? totalLikes) {
    if (username == 'me') {
      emit(state.copyWith(totalLikes: totalLikes));
    }
  }
}
