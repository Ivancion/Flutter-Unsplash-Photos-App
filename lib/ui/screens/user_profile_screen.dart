import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/user_profile_cubit/user_profile_cubit.dart';
import 'package:unsplash_images/bloc/user_profile_cubit/user_profile_cubit_state.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/pop_app_bar_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PopAppBarWidget(),
      body: BlocBuilder<UserProfileCubit, UserProfileCubitState>(
        builder: ((context, state) {
          if (state.status == UserProfileDataStatus.loading) {
            return const LoadingWidget();
          } else if (state.status == UserProfileDataStatus.failed) {
            return const CustomErrorWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _UserProfileImage(),
                  SizedBox(height: 24),
                  _UserProfileData(),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  _PhotosBtn(),
                  SizedBox(height: 10),
                  _LikedPhotosBtn(),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

class _UserProfileImage extends StatelessWidget {
  const _UserProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();

    return CircleAvatar(
      radius: 60,
      backgroundImage: NetworkImage(cubit.state.profileImage),
    );
  }
}

class _UserProfileData extends StatelessWidget {
  const _UserProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cubit.state.name,
          style: const TextStyle(
              fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (cubit.state.bio != null)
          Text(
            cubit.state.bio!,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}

class _PhotosBtn extends StatelessWidget {
  const _PhotosBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => openUserPhotosScreen(
        context,
        cubit.state.username,
        cubit.state.totalPhotos,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.photo,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(width: 10),
                  Text('User\'s photos', style: TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                children: [
                  BlocBuilder<UserProfileCubit, UserProfileCubitState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Text(
                        '${state.totalPhotos}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openUserPhotosScreen(
    BuildContext context,
    String username,
    int totalPhotos,
  ) {
    if (totalPhotos == 0) return;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.userPhotosScreen,
      arguments: username,
    );
  }
}

class _LikedPhotosBtn extends StatelessWidget {
  const _LikedPhotosBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        int? totalLikes = await openUserLikedPhotosScreen(
          cubit.state.totalLikes,
          context,
          cubit.state.username,
        );
        cubit.updateState(totalLikes);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text('Liked photos', style: TextStyle(fontSize: 18)),
                ],
              ),
              Row(
                children: [
                  BlocBuilder<UserProfileCubit, UserProfileCubitState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return Text(
                        '${state.totalLikes}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int?> openUserLikedPhotosScreen(
    int totalLikes,
    BuildContext context,
    String username,
  ) async {
    if (totalLikes == 0) return null;
    int likes = await Navigator.of(context).pushNamed(
      MainNavigationRouteNames.userLikedPhotosScreen,
      arguments: <String, dynamic>{
        'username': username,
        'total_likes': totalLikes,
      },
    ) as int;
    return likes;
  }
}
