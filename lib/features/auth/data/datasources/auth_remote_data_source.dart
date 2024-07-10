import 'package:blog_app/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract  interface class AuthRemoteDataSource {

  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl(this.supabaseClient);
  final SupabaseClient supabaseClient;

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password
  }) async {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  }) async {

    try {

       final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          data: {
            'name': name,
          }
      );

       if(response.user == null){
         throw ServerException("User is null !");
       }

       return response.user!.id;

    } catch (e) {

      throw ServerException(e.toString());
    }

  }



}