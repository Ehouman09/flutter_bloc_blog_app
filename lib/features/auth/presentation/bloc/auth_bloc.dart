import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final UserSignUpUsecase _userSignUpUsecase;
  final UserLoginUsecase _userLoginUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;



  AuthBloc({
    required UserSignUpUsecase userSignUpUsecase,
    required UserLoginUsecase userLoginUsecase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })
      : _userSignUpUsecase = userSignUpUsecase,
      _userLoginUsecase = userLoginUsecase,
      _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {

    on<AuthSignUpEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);


  }

  void _isUserLoggedIn(AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {

    final response = await _currentUserUsecase(NoParams());
    
    response.fold(
            (failure) => emit(AuthFailureState(failure.message)),
            (user) {

              print("#####user########${user.id}##");
              print("#####user########${user.email}##");
              _emitAuthSuccess(user, emit);
            }
    );

  }


  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit)  async {

    final response = await _userSignUpUsecase(
        UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password
        )
    );

    response.fold(
            (failure) => emit(AuthFailureState(failure.message)),
            (user) => _emitAuthSuccess(user, emit)
    );

  }

  void _onAuthLogin(AuthLoginEvent event,Emitter<AuthState> emit)  async {

    final response = await _userLoginUsecase(
        UserLoginParams(
            email: event.email,
            password: event.password
        )
    );

    response.fold(
            (failure) => emit(AuthFailureState(failure.message)),
            (user) => _emitAuthSuccess(user, emit)
    );

  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user));

  }

}
