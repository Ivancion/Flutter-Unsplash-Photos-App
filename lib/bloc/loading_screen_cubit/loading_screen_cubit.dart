import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_images/data/repositories/auth_repository.dart';

enum LoadingScreenCubitState { loading, authorized, unauthorized }

class LoadingScreenCubit extends Cubit<LoadingScreenCubitState> {
  final AuthRepository authRepository;

  LoadingScreenCubit(this.authRepository)
      : super(LoadingScreenCubitState.loading) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final isAuth = await authRepository.isAuth();
    isAuth
        ? emit(LoadingScreenCubitState.authorized)
        : emit(LoadingScreenCubitState.unauthorized);
  }
}
