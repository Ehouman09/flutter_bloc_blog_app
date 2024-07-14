import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract  interface class AuthRemoteDataSource {

  Session? get currentSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();

}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl(this.supabaseClient);
  final SupabaseClient supabaseClient;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password
  }) async {

    try {

      final response = await supabaseClient.auth.signInWithPassword(
          password: password,
          email: email,
      );

      if(response.user == null){
        throw ServerException("User is null !");
      }

      return UserModel.fromJson(response.user!.toJson());

    } catch (e) {

      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
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

       return UserModel.fromJson(response.user!.toJson());

    } catch (e) {

      throw ServerException(e.toString());
    }

  }

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {

    try {

      if(currentSession!.user != null){

      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentSession!.user.id);

      return UserModel.fromJson(userData.first)
            .copyWith(
              email: currentSession!.user.email
        );
      }


    } catch (e) {

    }
  }





}