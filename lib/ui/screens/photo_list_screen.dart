import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/photo_list_cubit/photo_list_cubit.dart';
import 'package:unsplash_images/bloc/photo_list_cubit/photo_list_cubit_state.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/photo_list_widget.dart';
import 'package:unsplash_images/ui/widgets/search_app_bar_widget.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhotoListCubit>();

    return Scaffold(
      appBar: SearchAppBarWidget(
        onSubmitField: cubit.searchPhotos,
        hintText: 'Search photos...',
        onProfileBtnPressed: () => Navigator.of(context).pushNamed(
          MainNavigationRouteNames.userProfileScreen,
          arguments: 'me',
        ),
        onLogoutPressed: () {
          cubit.deleteToken();
          Navigator.of(context).pushNamed(MainNavigationRouteNames.authScreen);
        },
      ),
      body: BlocBuilder<PhotoListCubit, PhotoListCubitState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state.status == PhotoListCubitStateStatus.loading) {
            return const LoadingWidget();
          } else if (state.status ==
              PhotoListCubitStateStatus.emptyQueryResponse) {
            return const Center(
              child: Text(
                'No results for your query',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhotoListWidget(
                  scrollController: cubit.scrollController,
                  photoList: state.photos,
                  likePhoto: cubit.likeThePhoto,
                  unlikePhoto: cubit.unlikeThePhoto,
                  downloadPhoto: cubit.downloadImage,
                ),
                if (state.status == PhotoListCubitStateStatus.error)
                  const CustomErrorWidget(),
              ],
            );
          }
        }),
      ),
    );
  }
}
