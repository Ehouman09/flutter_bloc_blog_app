part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;
  const AuthFailureState(this.message);
}

class AuthSuccessState extends AuthState {
  final UserEntity user;
  const AuthSuccessState(this.user);


}

