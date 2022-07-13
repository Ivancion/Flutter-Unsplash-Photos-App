import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/user_liked_photos_cubit/user_liked_photos_cubit.dart';
import 'package:unsplash_images/bloc/user_liked_photos_cubit/user_liked_photos_cubit_state.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/photo_list_widget.dart';
import 'package:unsplash_images/ui/widgets/pop_app_bar_widget.dart';

class UserLikedPhotosScreen extends StatelessWidget {
  const UserLikedPhotosScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserLikedPhotosCubit>();

    return Scaffold(
      appBar: PopAppBarWidget(
        onIconPressed: () => Navigator.of(context).pop(cubit.totalLikes),
      ),
      body: BlocBuilder<UserLikedPhotosCubit, UserLikedPhotosCubitState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state.status == UserLikedPhotosCubitStateStatus.loading) {
            return const LoadingWidget();
          } else {
            return Column(
              children: [
                PhotoListWidget(
                  photoList: state.photos,
                  scrollController: cubit.scrollController,
                  likePhoto: cubit.likeThePhoto,
                  unlikePhoto: cubit.unlikeThePhoto,
                  downloadPhoto: cubit.downloadImage,
                ),
                if (state.status == UserLikedPhotosCubitStateStatus.error)
                  const CustomErrorWidget(),
              ],
            );
          }
        }),
      ),
    );
  }
}
