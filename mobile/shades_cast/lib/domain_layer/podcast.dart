class Podcast {
  final int id;
  final String title;
  final String? author;
  final String? description;
  final String? imageUrl;
  final List? categories;

  Podcast(
      {required this.id,
      required this.title,
      required this.author,
      required this.description,
      required this.imageUrl,
      required this.categories});

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'],
      title: json['title'],
      author: json['creator'],
      description: json['description'],
      imageUrl: json['cover_image'],
      categories: json['categories'],
    );
  }
}
