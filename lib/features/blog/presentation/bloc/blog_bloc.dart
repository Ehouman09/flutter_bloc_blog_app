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
      on<BlogUploadEvent>(_onUploadBlog);


  }



  void _onUploadBlog(BlogUploadEvent event, Emitter<BlogState> emit)  async {

    final response = await _uploadBlogUsecase(
      UploadBlogParams(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          topics: event.topics,
          image: event.image,
        updatedAt: DateTime.now()
      )
    );

    response.fold(
            (failure) => emit(BlogFailureState(failure.message)),
            (user) =>  emit(BlogSuccessState())
    );

  }



}

