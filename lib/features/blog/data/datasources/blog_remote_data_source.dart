

import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {

  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> updloadBlogImage({
    required File image,
    required BlogModel blog
  });

}


class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {

  BlogRemoteDataSourceImpl(this.supabaseClient);
  final SupabaseClient supabaseClient;

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {

    try {

      final response = await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(response.first);

    } catch (e) {
      print("#######error#####${e}###");
      throw ServerException(e.toString());
    }

  }

  @override
  Future<String> updloadBlogImage({
    required File image,
    required BlogModel blog
  }) async {

    try {

       await supabaseClient.storage.from("blog_images").upload(
          blog.id,
          image
      );

      return supabaseClient.storage
          .from("blog_images")
          .getPublicUrl(blog.id);

    } catch (e){
      print("#######error#####${e}###");
      throw ServerException(e.toString());
    }

  }


}
