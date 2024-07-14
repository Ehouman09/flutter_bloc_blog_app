part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {

  final String name;
  final String email;
  final String password;

  AuthSignUpEvent({
    required this.name,
    required this.email,
    required this.password
  });

}

class AuthLoginEvent extends AuthEvent {

  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password
  });

}

class AuthIsUserLoggedInEvent extends AuthEvent {}


