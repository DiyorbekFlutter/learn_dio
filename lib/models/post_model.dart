class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body']
  );
}
