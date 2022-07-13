import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/bloc/user_list_cubit/user_list_cubit.dart';
import 'package:unsplash_images/bloc/user_list_cubit/user_list_cubit_state.dart';
import 'package:unsplash_images/ui/navigation/main_navigation.dart';
import 'package:unsplash_images/ui/widgets/custom_error_widget.dart';
import 'package:unsplash_images/ui/widgets/loading_widget.dart';
import 'package:unsplash_images/ui/widgets/search_app_bar_widget.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<UserListCubit>();

    return Scaffold(
      appBar: SearchAppBarWidget(
        onSubmitField: cubit.searchUsers,
        hintText: 'Search users...',
        onProfileBtnPressed: () => Navigator.of(context).pushNamed(
          MainNavigationRouteNames.userProfileScreen,
          arguments: 'me',
        ),
        onLogoutPressed: () {
          cubit.deleteToken();
          Navigator.of(context).pushNamed(MainNavigationRouteNames.authScreen);
        },
      ),
      body: BlocBuilder<UserListCubit, UserListCubitState>(
        bloc: cubit,
        builder: ((context, state) {
          if (state.status == UserListCubitStateStatus.initial) {
            return const Center(
              child: Text(
                'Search something to see data',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else if (state.status ==
              UserListCubitStateStatus.emptyQueryResponse) {
            return const Center(
              child: Text(
                'No results for your query',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          } else if (state.status == UserListCubitStateStatus.loading) {
            return const LoadingWidget();
          } else {
            return Column(
              children: [
                const _UsersListBody(),
                if (state.status == UserListCubitStateStatus.error)
                  const CustomErrorWidget(),
              ],
            );
          }
        }),
      ),
    );
  }
}

class _UsersListBody extends StatelessWidget {
  const _UsersListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserListCubit>();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<UserListCubit, UserListCubitState>(
          bloc: cubit,
          builder: (context, state) {
            return ListView.separated(
              controller: cubit.scrollController,
              itemCount: state.users.length,
              itemBuilder: ((context, index) {
                final user = state.users[index];
                return Container(
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFd1d1d1)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                user.profileImage.medium,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '@${user.username}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        _ViewProfileBtn(index: index),
                      ],
                    ),
                  ),
                );
              }),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            );
          },
        ),
      ),
    );
  }
}

class _ViewProfileBtn extends StatelessWidget {
  const _ViewProfileBtn({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserListCubit>();
    return InkWell(
      onTap: () {
        _openUserProfile(cubit.state.users[index].username, context);
      },
      borderRadius: BorderRadius.circular(4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFd1d1d1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        height: 32,
        child: const Center(
          child: Text(
            'View profile',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF767676),
            ),
          ),
        ),
      ),
    );
  }

  void _openUserProfile(String username, BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.userProfileScreen,
        arguments: username);
  }
}
