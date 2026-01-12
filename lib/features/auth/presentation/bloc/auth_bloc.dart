import 'package:blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entity/user_entity.dart';
import '../../domain/usecases/user_login.dart' as login;
import '../../domain/usecases/user_sign_up.dart' as signup;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final login.UserLogIn _userLogIn;
  final Currentuser _currentuser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required login.UserLogIn userLogIn,
    required Currentuser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogIn = userLogIn,
       _currentuser = currentUser,
        _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLogInEvent>(_onAuthLogIn);
    on<AuthIsUserLogIn>(_isUserLoggedIn);
  }
  Future<void> _isUserLoggedIn(
    AuthIsUserLogIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentuser(NoParams());
    res.fold((failure) => emit(AuthFailure(failure.message)), (user) {
      
      _emitAuthSuccess(user,emit);
    });
  }

  Future<void> _handleAuthAction(
    Emitter<AuthState> emit,
    Future<Either<Failure, UserEntity>> Function() authFunction,
  ) async {
    emit(AuthLoading());
    final res = await authFunction();
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  //gestion de l'inscription
  Future<void> _onAuthSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _handleAuthAction(
      emit,
      () => _userSignUp(
        signup.SignUpParams(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      ),
    );
  }

  //gestion de la connexion
  Future<void> _onAuthLogIn(
    AuthLogInEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _handleAuthAction(
      emit,
      () => _userLogIn(
        login.SignUpParams(email: event.email, password: event.password),
      ),
    );
  }

  //mise a jour de l'utilisateur dans le cubit global
  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser( user);
    emit(AuthSuccess(user));
  }
}
