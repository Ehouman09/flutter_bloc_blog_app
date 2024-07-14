import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
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



  AuthBloc({
    required UserSignUpUsecase userSignUpUsecase,
    required UserLoginUsecase userLoginUsecase,
    required CurrentUserUsecase currentUserUsecase,
  })
      : _userSignUpUsecase = userSignUpUsecase,
      _userLoginUsecase = userLoginUsecase,
        _currentUserUsecase = currentUserUsecase,
        super(AuthInitial()) {

    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);


  }

  void _isUserLoggedIn(AuthIsUserLoggedInEvent event, Emitter emit) async {

    emit(AuthLoadingState());

    final response = await _currentUserUsecase(NoParams());
    
    response.fold(
            (failure) => emit(AuthFailureState(failure.message)),
            (user) {

              print("#####user########${user.id}##");
              print("#####user########${user.email}##");
             emit(AuthSuccessState(user));
            }
    );

  }


  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit)  async {

    emit(AuthLoadingState());
    final response = await _userSignUpUsecase(
        UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password
        )
    );

    response.fold(
            (failure) => emit(AuthFailureState(failure.message)),
            (user) => emit(AuthSuccessState(user))
    );

  }

  void _onAuthLogin(AuthLoginEvent event,Emitter<AuthState> emit)  async {

    emit(AuthLoadingState());

    final response = await _userLoginUsecase(
        UserLoginParams(
            email: event.email,
            password: event.password
        )
    );

    response.fold(
            (failure) => emit(AuthFailureState(failure.message)),
            (user) => emit(AuthSuccessState(user))
    );

  }

}
