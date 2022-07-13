import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/collection_details_cubit/collection_details_cubit.dart';
import 'package:unsplash_images/bloc/collection_details_cubit/collection_details_cubit_state.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/photo_list_widget.dart';
import 'package:unsplash_images/ui/widgets/pop_app_bar_widget.dart';

class CollectionDetailsScreen extends StatefulWidget {
  const CollectionDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CollectionDetailsScreen> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState extends State<CollectionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CollectionDetailsCubit>();

    return Scaffold(
      appBar: const PopAppBarWidget(),
      body: BlocBuilder<CollectionDetailsCubit, CollectionDetailsCubitState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state.status == CollectionDetailsCubitStateStatus.loading) {
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
                if (state.status == CollectionDetailsCubitStateStatus.error)
                  const CustomErrorWidget(),
              ],
            );
          }
        }),
      ),
    );
  }
}
