part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class BlogUploadEvent extends BlogEvent {

  BlogUploadEvent({
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

class BlogFetchEvent extends BlogEvent {}



