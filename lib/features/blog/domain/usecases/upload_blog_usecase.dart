
import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<BlogEntity, UploadBlogParams>{

  final BlogRepository blogRepository;
  UploadBlogUsecase(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics
    );

  }


}

class UploadBlogParams {

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image,
});

  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final File image;
}