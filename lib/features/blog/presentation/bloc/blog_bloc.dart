import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';

part 'blog_event.dart';
part 'blog_state.dart';


class BlogBloc extends Bloc<BlogEvent, BlogState> {

  final UploadBlogUsecase _uploadBlogUsecase;


  BlogBloc({
    required UploadBlogUsecase uploadBlogUsecase,
  })
      : _uploadBlogUsecase = uploadBlogUsecase,
        super(BlogInitial()) {


      on<BlogEvent>((_, emit) => emit(BlogLoadingState()));
      on<BlogUpload>();


  }



  // void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit)  async {
  //
  //   final response = await _userSignUpUsecase(
  //       UserSignUpParams(
  //           name: event.name,
  //           email: event.email,
  //           password: event.password
  //       )
  //   );
  //
  //   response.fold(
  //           (failure) => emit(AuthFailureState(failure.message)),
  //           (user) => _emitAuthSuccess(user, emit)
  //   );
  //
  // }



}

