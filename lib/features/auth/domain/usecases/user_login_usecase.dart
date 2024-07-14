

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements UseCase<UserEntity, UserLoginParams>{

  final AuthRepository authRepository;
  UserLoginUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(UserLoginParams params)async {

    return await authRepository.loginWithEmailPassword(
        email: params.email,
        password: params.password
    );

  }

}

class UserLoginParams {

  UserLoginParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}