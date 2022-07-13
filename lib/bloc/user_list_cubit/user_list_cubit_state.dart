import 'package:equatable/equatable.dart';
import 'package:unsplash_images/data/entity/user.dart';

enum UserListCubitStateStatus {
  loading,
  error,
  emptyQueryResponse,
  success,
  initial,
}

class UserListCubitState extends Equatable {
  final List<User> users;
  final UserListCubitStateStatus status;

  const UserListCubitState({
    required this.users,
    required this.status,
  });

  const UserListCubitState.initial()
      : users = const <User>[],
        status = UserListCubitStateStatus.initial;

  UserListCubitState copyWith({
    List<User>? users,
    UserListCubitStateStatus? status,
  }) {
    return UserListCubitState(
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [users, status];
}
