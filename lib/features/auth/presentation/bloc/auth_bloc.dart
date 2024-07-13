import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final UserSignUpUsecase _userSignUpUsecase;



  AuthBloc({
    required UserSignUpUsecase userSignUpUsecase
  })
      : _userSignUpUsecase = userSignUpUsecase,
        super(AuthInitial()) {

    on<AuthSignUpEvent>((event, emit)  async {
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
      
    });


  }

}
