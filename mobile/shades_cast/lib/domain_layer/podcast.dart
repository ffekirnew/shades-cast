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

// <<<<<<< firaols_branch
//   factory Podcast.fromJson(Map<String, dynamic> json) {
//     return Podcast(
//       id: json['id'],
//       title: json['title'],
//       author: json['creator'],
//       description: json['description'],
//       imageUrl: json['cover_image'],
//       categories: json['categories'],
//     );
// =======
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'imageUrl': imageUrl,
      'categories': categories
    };
  }

  static Podcast fromMap(Map<String, dynamic> map) {
    return Podcast(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        author: map['author'],
        imageUrl: map['imageUrl'],
        categories: map['categories']);
// >>>>>>> master
  }
}
