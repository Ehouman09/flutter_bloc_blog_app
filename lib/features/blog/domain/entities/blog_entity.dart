
class BlogEntity {

  BlogEntity({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.updatedAt,
  });

  final String id;
  final String posterId;
  final String title;
  final String content;
  final String image;
  final List<String> topics;
  final DateTime updatedAt;


}