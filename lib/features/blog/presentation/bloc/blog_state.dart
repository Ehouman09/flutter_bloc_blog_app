part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoadingState extends BlogState {}

class BlogFailureState extends BlogState {
final String message;

BlogFailureState(this.message);
}

class BlogSuccessState extends BlogState {
  // final List<BlogModel> response;
  // BlogSuccessState(this.response);


}

// class BlogPostingState extends BlogState {}
//
// class BlogPostingFailureState extends BlogState {
// final String message;
//
//   BlogPostingFailureState(this.message);
// }
//
// class BlogPostingSuccessState extends BlogState {
//   final List<BlogModel> response;
//     BlogPostingSuccessState(this.response);
//
// }

