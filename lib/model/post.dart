class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  // Factory constructor to parse JSON data
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
