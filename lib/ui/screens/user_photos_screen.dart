import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/user_photos_cubit/user_photos_cubit.dart';
import 'package:unsplash_images/bloc/user_photos_cubit/user_photos_cubit_state.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/photo_list_widget.dart';
import 'package:unsplash_images/ui/widgets/pop_app_bar_widget.dart';

class UserPhotosScreen extends StatelessWidget {
  const UserPhotosScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserPhotosCubit>();

    return Scaffold(
      appBar: const PopAppBarWidget(),
      body: BlocBuilder<UserPhotosCubit, UserPhotosCubitState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state.status == UserPhotosCubitStateStatus.loading) {
            return const LoadingWidget();
          } else {
            final bool showBtns = cubit.username != 'me';
            return Column(
              children: [
                PhotoListWidget(
                  photoList: state.photos,
                  scrollController: cubit.scrollController,
                  likePhoto: showBtns ? cubit.likeThePhoto : null,
                  unlikePhoto: showBtns ? cubit.unlikeThePhoto : null,
                  downloadPhoto: showBtns ? cubit.downloadImage : null,
                ),
                if (state.status == UserPhotosCubitStateStatus.error)
                  const CustomErrorWidget(),
              ],
            );
          }
        }),
      ),
    );
  }
}
