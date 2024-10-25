import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {

  BlogRepositoryImpl(this.blogRemoteDataSource);

  final BlogRemoteDataSource blogRemoteDataSource;

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
      required File image,
      required String title,
      required String content,
      required String posterId,
      required DateTime updatedAt,
      required List<String> topics
  }) async {


      try {

        BlogModel blogModel = BlogModel(
            id: const Uuid().v1(),
            posterId: posterId,
            title: title,
            content: content,
            imageUrl: '',
            topics: topics,
            updatedAt: DateTime.now()
        );

        final imageUrl = await blogRemoteDataSource.updloadBlogImage(
          image: image,
          blog: blogModel
        );
        blogModel = blogModel.copyWith(
          imageUrl: imageUrl
        );

        final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
        return right(uploadedBlog);

      } on ServerException catch (e) {

        return left(Failure(e.message));

      }



  }
}
