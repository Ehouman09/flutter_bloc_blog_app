import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final UserSignUpUsecase _userSignUpUsecase;
  final UserLoginUsecase _userLoginUsecase;



  AuthBloc({
    required UserSignUpUsecase userSignUpUsecase,
    required UserLoginUsecase userLoginUsecase,
  })
      : _userSignUpUsecase = userSignUpUsecase,
      _userLoginUsecase = userLoginUsecase,
        super(AuthInitial()) {

    on<AuthSignUpEvent>(_onAuthSignUp);


  }


  void _onAuthSignUp(AuthSignUpEvent event,Emitter<AuthState> emit)  async {

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

}
