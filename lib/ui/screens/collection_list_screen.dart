import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/collection_list_cubit/collection_list_cubit.dart';
import 'package:unsplash_images/bloc/collection_list_cubit/collection_list_cubit_state.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/search_app_bar_widget.dart';

class CollectionListScreen extends StatelessWidget {
  const CollectionListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CollectionListCubit>();
    return Scaffold(
      appBar: SearchAppBarWidget(
        onSubmitField: cubit.searchCollection,
        hintText: 'Search collections...',
        onProfileBtnPressed: () => Navigator.of(context).pushNamed(
          MainNavigationRouteNames.userProfileScreen,
          arguments: 'me',
        ),
        onLogoutPressed: () {
          cubit.deleteToken();
          Navigator.of(context).pushNamed(MainNavigationRouteNames.authScreen);
        },
      ),
      body: BlocBuilder<CollectionListCubit, CollectionListCubitState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state.status == CollectionListCubitStateStatus.loading) {
            return const LoadingWidget();
          } else if (state.status ==
              CollectionListCubitStateStatus.emptyQueryResponse) {
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
              children: [
                const _CollectionsListWidgetBody(),
                if (state.status == CollectionListCubitStateStatus.error)
                  const CustomErrorWidget(),
              ],
            );
          }
        }),
      ),
    );
  }
}

class _CollectionsListWidgetBody extends StatelessWidget {
  const _CollectionsListWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CollectionListCubit>();
    return Expanded(
      child: BlocBuilder<CollectionListCubit, CollectionListCubitState>(
        bloc: cubit,
        builder: (context, state) {
          return ListView.separated(
            controller: cubit.scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: cubit.state.collections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CollectionsHeader(index: index),
                    _CollectionsTableWidget(index: index),
                    _CollectionsBottomView(index: index),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 40);
            },
          );
        },
      ),
    );
  }
}

class _CollectionsTableWidget extends StatelessWidget {
  const _CollectionsTableWidget({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CollectionListCubit>();
    final collection = cubit.state.collections[index];
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 14,
      ),
      child: GestureDetector(
        onTap: () {
          _openDetailsScreen(collection.id, context);
        },
        child: BlocBuilder<CollectionListCubit, CollectionListCubitState>(
          bloc: cubit,
          builder: (context, state) {
            return Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                        ),
                        child: Image.network(
                          collection.previewPhotos[0].urls.regular,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(6),
                        ),
                        child: Image.network(
                          collection.previewPhotos[1].urls.regular,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                        ),
                        child: Image.network(
                          collection.previewPhotos[2].urls.regular,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(6),
                        ),
                        child: Image.network(
                          collection.previewPhotos[3].urls.regular,
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _openDetailsScreen(String id, BuildContext context) {
    Navigator.of(context).pushNamed(
        MainNavigationRouteNames.collectionDetailsScreen,
        arguments: id);
  }
}

class _CollectionsHeader extends StatelessWidget {
  const _CollectionsHeader({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final String title =
        context.read<CollectionListCubit>().state.collections[index].title;
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CollectionsBottomView extends StatelessWidget {
  const _CollectionsBottomView({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final collection =
        context.read<CollectionListCubit>().state.collections[index];
    return Row(
      children: [
        Text(
          '${collection.totalPhotos} photos',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF767676),
          ),
        ),
        const SizedBox(width: 5),
        const Text(
          '·',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF767676),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          'Curated by ${collection.user.username}',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF767676),
          ),
        ),
      ],
    );
  }
}
